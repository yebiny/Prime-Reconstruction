#!/bin/bash
source path.sh

SUP_MASK='sup_maskCut1_bin.nii.gz'
ENH_MASK='enhance_maskCut1_bin.nii.gz'
SUBJ_LIST=${1}

python scripts/data_generator.py $DATA $RESULTS $SUP_MASK $ENH_MASK $SUBJ_LIST
