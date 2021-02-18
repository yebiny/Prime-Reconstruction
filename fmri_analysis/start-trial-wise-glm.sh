#!/bin/bash
source path.sh

SUBJ=${1}

# generate mask
INPUT_DIR=$RESULTS/$SUBJ/secondlevel
OUTPUT_DIR=$RESULTS/$SUBJ/mask
bash scripts/gen_mask.sh $INPUT_DIR $OUTPUT_DIR

# feat
bash scripts/feat.sh $SUBJ trial_wise train

# aling trial_wise
TRIALWISE_DIR=$RESULTS/$SUBJ/trial_wise
MASK_DIR=$RESULTS/$SUBJ/mask
bash scripts/aling_TrialWiseTstat2standard.sh $TRIALWISE_DIR $MASK_DIR
