#!/bin/bash

SUBJ=${1}
INFIX=${2}

output=results/$SUBJ/firstlevel
input1=results/$SUBJ/2-reorient
input2=results/$SUBJ/3-bet/t1_mprage_brain.nii.gz

template=templates/firstlevel_$INFIX.fsf
design=data/$SUBJ/design

bash scripts/render-firstlevel-template.sh $input1 $input2 $output $template $design $INFIX
