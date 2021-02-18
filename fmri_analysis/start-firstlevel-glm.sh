#!/bin/bash
source path.sh

SUBJ=${1}
INFIX=${2}

output=$RESULTS/$SUBJ/firstlevel
input1=$RESULTS/$SUBJ/2-reorient
input2=$RESULTS/$SUBJ/3-bet/t1_mprage_brain.nii.gz
template=templates/firstlevel_$INFIX.fsf
design=$DATA/$SUBJ/design

# make design directory

read -t 5 -p "Do you want make Design directory? (y/N) " overwrite || true
if [ "$overwrite" == "y" ]; 
then python scripts/gen_design.py $SUBJ $DATA;fi

# rendering
bash scripts/render-firstlevel-template.sh $input1 $input2 $output $template $design $INFIX

# feat
bash scripts/feat.sh $SUBJ firstlevel $INFIX
