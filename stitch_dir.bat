@echo off
setlocal enabledelayedexpansion

REM === Settings ===
set "ROT_ANGLE=0.122"
set "CROP_W=1808"
set "CROP_H=900"
set "FOLDER_CAM10=cam10"
set "FOLDER_CAM11=cam11"
set "OUTPUT_FOLDER=stitched_outputs"

if not exist "%OUTPUT_FOLDER%" mkdir "%OUTPUT_FOLDER%"

REM === Arrays for storing matched file pairs ===
set matched_count=0
set unmatched_count=0
set pair_index=0

echo ===========================
echo 🔍 Scanning for matching pairs...
echo ===========================

for %%f in (%FOLDER_CAM10%\*.mp4) do (
    set "file10=%%~nxf"
    set "name10=%%~nf"

    call set "name11=%%name10:_cam10_=_cam11_%%"
    if "!name11!"=="!name10!" (
        call set "name11=%%name10:_cam10=_cam11%%"
    )

    if exist "%FOLDER_CAM11%\!name11!.mp4" (
        set /a matched_count+=1
        set /a pair_index+=1
        set "cam10_!pair_index!=!file10!"
        set "cam11_!pair_index!=!name11!.mp4"
    ) else (
        set /a unmatched_count+=1
    )
)

echo.
echo ✅ Ready to stitch:
echo Matched pairs    : %matched_count%
echo Unmatched cam10s : %unmatched_count%
echo ===========================
echo.

REM === Stitch each matched pair ===
echo 🛠 Starting stitching now...

for /l %%i in (1,1,%pair_index%) do (
    call set "file10=%%cam10_%%i%%"
    call set "file11=%%cam11_%%i%%"

    for %%x in (!file10!) do (
        set "name10=%%~nx"
    )

    set "outname=!name10:_cam10_=!"
    set "outname=!outname:_cam10=!"
    set "outname=!outname:.mp4=!"
    set "output_file=%OUTPUT_FOLDER%\!outname!.mp4"

    echo 🔄 Stitching: !file10! + !file11!
    echo    → Output: !output_file!

    ffmpeg -y -i "%FOLDER_CAM10%\!file10!" -i "%FOLDER_CAM11%\!file11!" -filter_complex ^
"[0:v]scale=1920:1080[vid1]; ^
 [1:v]rotate=%ROT_ANGLE%:c=black@0, crop=%CROP_W%:%CROP_H%, scale=1920:1080[vid2]; ^
 [vid1][vid2]hstack=inputs=2" "!output_file!"

    if exist "!output_file!" (
        echo 🟢 Saved: !output_file!
    ) else (
        echo ❌ Failed to create !output_file!
    )
)

echo.
echo ✅ All stitching done.
pause
