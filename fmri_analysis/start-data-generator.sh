#!/bin/bash
source path.sh

SUBJ=${1}

# feat
bash start-feat.sh $SUBJ trial_wise train

# aling trial_wise
INPUT_DIR=$RESULTS/$SUBJ/trial_wise
OUTPUT_DIR=$RESULTS/$SUBJ/mask
bash scripts/aling_TrialWiseTstat2standard.sh $INPUT_DIR $OUTPUT_DIR

# data generator
SUP_MASK='sup_maskCut1_bin.nii.gz'
ENH_MASK='enhance_maskCut1_bin.nii.gz'
python scripts/data_generator.py $DATA $RESULTS $SUP_MASK $ENH_MASK $SUBJ
