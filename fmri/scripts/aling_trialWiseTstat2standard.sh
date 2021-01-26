#!/bin/bash
#aligning trial-wise tstat to standard space

## ######################## aligning training data points(100) to standard (note taht there was a glm problem for using training + test)
source tool.sh

SUBJ=${1}
FIRSTLEVEL_DIR=results/$SUBJ/trial_wise
MASK_DIR=results/$SUBJ/mask

#################################### aligning tstat to standard
for run in {1..10}; do
	#training + test set
	for ii in {1..110}; do
	inputfile=$FIRSTLEVEL_DIR/phase1_trialWiseGLM_train_run$run.feat/stats/tstat$ii.nii.gz
	outputfile=$FIRSTLEVEL_DIR/phase1_trialWiseGLM_train_run$run.feat/stats/tstat${ii}_standard.nii.gz
	refmat=$FIRSTLEVEL_DIR/phase1_trialWiseGLM_train_run$run.feat/reg/example_func2standard.mat

	flirt -in $inputfile -ref $STANDARD_BRAIN -init $refmat -out $outputfile -applyxfm
	done
done

#################################### masking aligned tstat map
for run in {1..10}; do
	#training + test set
	for ii in {1..110}; do
		inputfile=$FIRSTLEVEL_DIR/phase1_trialWiseGLM_train_run$run.feat/stats/tstat${ii}_standard.nii.gz
		for mm in 1 2; do
			mask=$MASK_DIR/mask${mm}.nii
			outputfile=$FIRSTLEVEL_DIR/phase1_trialWiseGLM_train_run$run.feat/stats/tstat${ii}_mask${mm}.nii.gz
			fslmaths $inputfile -mas $mask $outputfile
		done
	done
done
