#!/bin/bash
source path.sh

SUBJ=${1}

# data generator
SUP_MASK='sup_maskCut1_bin.nii.gz'
ENH_MASK='enhance_maskCut1_bin.nii.gz'
python scripts/data_generator.py $DATA $RESULTS $SUP_MASK $ENH_MASK $SUBJ
