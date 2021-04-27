#!/bin/bash
source path.sh

#sublist='sub04 sub05 sub06 sub07 sub08 sub09 sub10 sub11 sub13 sub14 sub15 sub16 sub17 sub18 sub21 sub22 sub23 sub24'
sublist='sub08 sub09 sub10 sub11 sub13 sub14 sub15 sub16 sub17 sub18 sub21 sub22 sub23'

#for sub in $sublist
#do
#bash start-firstlevel-glm.sh $sub phase2
#bash start-secondlevel-glm.sh $sub phase2 
#done

#python scripts/gen_design.py sub07 $DATA
#bash start-firstlevel-glm.sh sub07 phase1
#bash start-firstlevel-glm.sh sub07 phase2
bash start-secondlevel-glm.sh sub19 phase1 
bash start-secondlevel-glm.sh sub19 phase2 
