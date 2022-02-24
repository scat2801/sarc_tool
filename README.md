# sarc_tool
Tested in Matlab 2020b, with image processing toolbox

Segmentation data processing
All NIFTI (image and masks) files in one folder OR Point to your datafolder using addpath('C:\data_folder') in script.m

Add all image and segmentation files in script.m, carefully check filenames, and whether it's '.nii' or '.nii.gz'
Run sarcscript

The pre-processed mask (with thresholding applied) is saved in the same working folder as 'ppMaskName' (e.g ppseg101.nii.gz)


M Chen
24/02/2022
