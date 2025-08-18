## Hi!
### This is the repository for the project **"Automated tracking of behavioral synchrony in marmoset dyads"**  

  
### The folder DeepSORT_ML2025 contains the following:  
  
      
1. **yolo_project** - Has trained yolo models and data.yaml
  
3. **Scripts**
    - **final_scripts.ipynb**: The entire pipeline including tracking with YOLO+SORT on stitched cam 10 and cam11 videos, correcting ID switch manually, tracking cam15 and cam18 with guide, cubic spline interpolation of centres of bounding boxes, triangulation + distance calculation + plots
      
    - **yolov8_train.ipynb**: Notebook for training YOLO (versions and network architecture can be manipulated)
      
    - **extra**: all other codes
        - **label_yolo.ipynb**: To label images for YOLO training (bounding boxes) using labelImg
        - **SIPEC_yolo.ipynb**: All codes to make SIPEC dataset usable for YOLO training. NOTE: Also has certain codes for removing unmatched images/labels, and also to create train, test, val split
        - **sorting_vids.ipynb**: To make custom directories like those for different camera views.
        - **yolo_sort.ipynb**: Every other thing I've tried in all parts of the project.
    - **videos**: Random outputs of various scripts
      
    - **sort, cvat and labelImg**: Software folders with their source codes
      
    - **trim**: leaves only first 30 sec of video
      
    - **stitch_dir.bat** running this with create the stitched output folder form the cam10 and cam11 folders
      
    - **align_videos_rotate.bat**: for stitching one pair

   
     
### For any queries, feel free to contact me
email: muktaglondhe@gmail.com
  
### Happy tracking! 🐒📹📐
