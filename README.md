# Tracking Marmoset Dyads 

## What is this project about?

Marmosets are small monkeys that live in groups. To understand how pairs of marmosets coordinate their behavior, researchers often measure synchrony: how close they stay, how they move together, and how they interact in space.

Traditionally, this requires hours of manual video annotation. This project provides a fully automated pipeline that can:

Detect multiple marmosets in multi-camera video recordings,

Track each one across time and across cameras,

Reconstruct their 3D positions using camera geometry, and

Calculate the distance between them to study synchrony.

How does it work?
1. Camera setup

Four cameras record the marmosets: cam10, cam11, cam15, cam18.

The arena is covered in two halves:

Half A: cam10 + cam18

Half B: cam11 + cam15

To reconstruct 3D positions, we use the intrinsic and extrinsic calibration parameters of all cameras.

2. Video stitching

Cam10 and cam11 each record half of the same arena wall.

They are stitched into a single wide-angle video so both marmosets can be tracked together.

3. Tracking with AI

In the stitched video, we use YOLOv8 (object detection) + SORT (tracking with a Kalman filter) to follow the marmosets over time.

4. Masked videos for DeepLabCut

Using the YOLO+SORT bounding boxes, we generate masked videos that highlight only the regions where marmosets appear.

These videos are then fed into DeepLabCut (DLC) for fine-grained body part tracking.

This ensures DLC recieves only one marmoset per frames, thereby eliminating the ID switch problem.

5. Identity correction

Sometimes the tracker confuses the two individuals.

For cam15 and cam18, stitching is not possible due to external angle constraints. Instead, we use the stitched cam10+11 results as a guide to keep identity consistent.

6. Why track in all cameras?

Even though stitching is only done for cam10+11, we track in all four cameras. This is necessary because later we use triangulation: combining 2D positions from different cameras to recover 3D coordinates of each marmoset.

7. Post-processing

Smooth the trajectories with cubic spline interpolation.

Triangulate 2D detections into 3D positions using camera calibration.

Compute inter-individual distance over time.

Generate annotated videos, CSV files, and synchrony plots.
  
### The folder DeepSORT_ML2025 contains the following:  
  
      
1. **yolo_project** - Has trained yolo models and data.yaml
  
3. **Scripts**
    - **final_scripts.ipynb**: The entire pipeline including tracking with YOLO+SORT on stitched cam 10 and cam11 videos, correcting ID switch manually, tracking cam15 and cam18 with guide, cubic spline interpolation of centres of bounding boxes, triangulation + distance calculation + plots
      
    - **yolov8_train.ipynb**: Notebook for training YOLO (versions and network architecture can be manipulated)
      
    - **extra**: all other codes
        - **label_yolo.ipynb**: To label images for YOLO training (bounding boxes) using labelImg
        - **SIPEC_yolo.ipynb**: All codes to make SIPEC dataset usable for YOLO training. NOTE: Also has certain codes for removing unmatched images/labels, and also to create train, test, val split
        - **sorting_vids.ipynb**: To make custom directories like those for different camera views.
      
    - **sort, cvat and labelImg**: Software folders with their source codes
      
    - **trim**: leaves only first 30 sec of video
      
    - **stitch_dir.bat** running this with create the stitched output folder form the cam10 and cam11 folders
      
    - **align_videos_rotate.bat**: for stitching one pair

   
     
### For any queries, feel free to contact me
email: muktaglondhe@gmail.com
  
### Happy tracking! 🐒📹📐
