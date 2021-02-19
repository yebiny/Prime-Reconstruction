#!/bin/bash


sublist='sub02 sub05 sub06 sub07 sub08 sub09 sub10 sub11 sub13 sub14 sub15 sub16 sub17 sub18'

for sub in $sublist:
do

bash start-firstlevel-glm $sub phase1
bash start-firstlevel-glm $sub phase2
bash start-secondlevel-glm $sub phase1 
bash start-secondlevel-glm $sub phase2 

done
