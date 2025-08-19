@echo off
for %%f in (*.mp4) do (
    ffmpeg -y -i "%%f" -t 120 -c copy "%%~nf_120sec%%~xf"
)
echo Done cutting all .mp4 files to 120 seconds.
