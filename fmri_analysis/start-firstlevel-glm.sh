#!/bin/bash
source path.sh

SUBJ=${1}
INFIX=${2}

output=$RESULTS/$SUBJ/firstlevel
input1=$RESULTS/$SUBJ/2-reorient
input2=$RESULTS/$SUBJ/3-bet/t1_mprage_brain.nii.gz
template=templates/firstlevel_$INFIX.fsf
design=$DATA/$SUBJ/design

# rendering
bash scripts/render-firstlevel-template.sh $input1 $input2 $output $template $design $INFIX

# feat
bash scripts/feat.sh $SUBJ firstlevel $INFIX
