#!/bin/bash
source path.sh

sublist='sub02 sub04 sub05 sub06 sub07 sub08 sub09 sub10 sub11 sub13 sub14 sub15 sub16 sub17 sub18 sub19 sub21 sub22 sub23 sub24'

for sub in $sublist
do
#mkdir $RESULTS/$sub/trial_wise
bash start-trial-wise-glm.sh $sub 
done

