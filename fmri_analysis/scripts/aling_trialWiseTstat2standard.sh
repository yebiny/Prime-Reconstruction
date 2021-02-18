#!/bin/bash
#aligning trial-wise tstat to standard space

## ######################## aligning training data points(100) to standard (note taht there was a glm problem for using training + test)
source tool.sh

TRIALWISE_DIR=${1}
MASK_DIR=${2}

printf "== Start aling trial-wise : tstat to standard.. "
#################################### aligning tstat to standard
for run in {1..10}; do
	#training + test set
	for ii in {1..110}; do
	inputfile=$TRIALWISE_DIR/phase1_trialWiseGLM_train_run$run.feat/stats/tstat$ii.nii.gz
	outputfile=$TRIALWISE_DIR/phase1_trialWiseGLM_train_run$run.feat/stats/tstat${ii}_standard.nii.gz
	refmat=$TRIALWISE_DIR/phase1_trialWiseGLM_train_run$run.feat/reg/example_func2standard.mat

	flirt -in $inputfile -ref $STANDARD_BRAIN -init $refmat -out $outputfile -applyxfm
	done
    printf $run
done

printf "\n== Start aling trial-wise : tstat map.. "
#################################### masking aligned tstat map
for run in {1..10}; do
    #training + test set
	for ii in {1..110}; do
		inputfile=$TRIALWISE_DIR/phase1_trialWiseGLM_train_run$run.feat/stats/tstat${ii}_standard.nii.gz
		for mm in 1 2; do
			mask=$MASK_DIR/mask${mm}.nii
			outputfile=$TRIALWISE_DIR/phase1_trialWiseGLM_train_run$run.feat/stats/tstat${ii}_mask${mm}.nii.gz
			fslmaths $inputfile -mas $mask $outputfile
		done
	done
    printf $run
done
