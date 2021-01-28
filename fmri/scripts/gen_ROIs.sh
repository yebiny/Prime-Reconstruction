#!/bin/bash
maskDir=packages/visualCortexMasks
maskName1=$maskDir/harvardoxford-cortical_prob_Lateral_Occipital_Cortex_inferior_division.nii.gz
maskName2=$maskDir/harvardoxford-cortical_prob_Lingual_Gyrus.nii.gz
maskName3=$maskDir/harvardoxford-cortical_prob_Occipital_Fusiform_Gyrus.nii.gz
maskName4=$maskDir/harvardoxford-cortical_prob_Occipital_Pole.nii.gz
maskName5=$maskDir/harvardoxford-cortical_prob_Parahippocampal_Gyrus_posterior_division.nii.gz
maskName6=$maskDir/harvardoxford-cortical_prob_Temporal_Occipital_Fusiform_Cortex.nii.gz

#whole visucal corex
outputfile=$maskDir/mask1
#add masks
fslmaths $maskName1 -add $maskName2 -add $maskName3 -add $maskName4 -add $maskName5 -add $maskName6 $outputfile
#threshold and binalyze
fslmaths $outputfile -thr 1 -bin ${outputfile}_bin

#temporal occipital fusiform
outputfile=$maskDir/mask2
#threshold and binalyze
fslmaths $maskName6 -thr 1 -bin ${outputfile}_bin

