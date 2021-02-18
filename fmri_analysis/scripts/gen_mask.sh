#!/bin/bash

INPUT_DIR=${1}
OUTPUT_DIR=${2}

if [ -d "$OUTPUT_DIR" ]; then
 read -t 5 -p "data has already been converted. overwrite? (y/N) " overwrite || true
  if [ "$overwrite" != "y" ]; then exit; fi
  rm -rf $OUTPUT_DIR
  else mkdir -p $OUTPUT_DIR
fi


inputfile=$INPUT_DIR/phase1.gfeat/cope3.feat/stats/zstat1.nii.gz
outputfile=$OUTPUT_DIR/stim_act_thr31.nii.gz
#thresholding z>3.1 (stim > baseline)
fslmaths $inputfile -thr 3.1 $outputfile

# #################### mask 1 (stim vs. base threshold 3.1 + whole visual cortex mask) + selecting supp & enhance voxels
anatMask=packages/visualCortexMasks/mask1_bin.nii.gz
#cutting using anatomical mask
inputfile=$OUTPUT_DIR/stim_act_thr31.nii.gz
outputfile=$OUTPUT_DIR/stim_act_thr31_anatCut.nii.gz
fslmaths $inputfile -mas $anatMask $outputfile

#binalization
inputfile=$OUTPUT_DIR/stim_act_thr31_anatCut.nii.gz
outputfile=$OUTPUT_DIR/stim_act_thr31_anatCut_bin.nii.gz
fslmaths $inputfile -bin $outputfile


# selecting suppression & enhancement voxels (cutting by visual cortex mask)
visCortexMask=$OUTPUT_DIR/stim_act_thr31_anatCut_bin.nii.gz
cp $visCortexMask $OUTPUT_DIR/mask1.nii.gz
gunzip $OUTPUT_DIR/mask1.nii.gz

inputfile=$INPUT_DIR/phase2.gfeat/cope3.feat/stats/zstat1.nii.gz
outputfile=$OUTPUT_DIR/temp.nii.gz
fslmaths $inputfile -mas $visCortexMask $outputfile
inputfile=$OUTPUT_DIR/temp.nii.gz
outputfile=$OUTPUT_DIR/sup_maskCut1.nii.gz
fslmaths $inputfile -thr 0 $outputfile
inputfile=$OUTPUT_DIR/sup_maskCut1.nii.gz
outputfile=$OUTPUT_DIR/sup_maskCut1_bin.nii.gz
fslmaths $inputfile -bin $outputfile



inputfile=$INPUT_DIR/phase2.gfeat/cope4.feat/stats/zstat1.nii.gz
outputfile=$OUTPUT_DIR/temp.nii.gz
fslmaths $inputfile -mas $visCortexMask $outputfile
inputfile=$OUTPUT_DIR/temp.nii.gz
outputfile=$OUTPUT_DIR/enhance_maskCut1.nii.gz
fslmaths $inputfile -thr 0 $outputfile
inputfile=$OUTPUT_DIR/enhance_maskCut1.nii.gz
outputfile=$OUTPUT_DIR/enhance_maskCut1_bin.nii.gz
fslmaths $inputfile -bin $outputfile


# #################### mask 2 (temporal occipital cortex) + selecting supp & enhance voxels
anatMask=packages/visualCortexMasks/mask2_bin.nii.gz


# selecting suppression & enhancement voxels (cutting by visual cortex mask)
visCortexMask=$anatMask
cp $visCortexMask $OUTPUT_DIR/mask2.nii.gz
gunzip $OUTPUT_DIR/mask2.nii.gz

inputfile=$INPUT_DIR/phase2.gfeat/cope3.feat/stats/zstat1.nii.gz
outputfile=$OUTPUT_DIR/temp.nii.gz
fslmaths $inputfile -mas $visCortexMask $outputfile
inputfile=$OUTPUT_DIR/temp.nii.gz
outputfile=$OUTPUT_DIR/sup_maskCut2.nii.gz
fslmaths $inputfile -thr 0 $outputfile
inputfile=$OUTPUT_DIR/sup_maskCut2.nii.gz
outputfile=$OUTPUT_DIR/sup_maskCut2_bin.nii.gz
fslmaths $inputfile -bin $outputfile



inputfile=$INPUT_DIR/phase2.gfeat/cope4.feat/stats/zstat1.nii.gz
outputfile=$OUTPUT_DIR/temp.nii.gz
fslmaths $inputfile -mas $visCortexMask $outputfile
inputfile=$OUTPUT_DIR/temp.nii.gz
outputfile=$OUTPUT_DIR/enhance_maskCut2.nii.gz
fslmaths $inputfile -thr 0 $outputfile
inputfile=$OUTPUT_DIR/enhance_maskCut2.nii.gz
outputfile=$OUTPUT_DIR/enhance_maskCut2_bin.nii.gz
fslmaths $inputfile -bin $outputfile
