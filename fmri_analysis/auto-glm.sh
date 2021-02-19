#!/bin/bash


#sublist='sub02 sub05 sub06 sub07 sub08 sub09 sub10 sub11 sub13 sub14 sub15 sub16 sub17 sub18'
sublist='sub02 sub04 sub19'
for sub in $sublist:
do

bash start-firstlevel-glm.sh $sub phase1
bash start-firstlevel-glm.sh $sub phase2
bash start-secondlevel-glm.sh $sub phase1 
bash start-secondlevel-glm.sh $sub phase2 

done
