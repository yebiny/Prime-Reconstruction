#!/bin/bash
source path.sh
SUBJ=${1}
INFIX=${2}

TEMPLATE=templates/secondlevel_template.fsf

input1=$RESULTS/$SUBJ/firstlevel
input2=$INFIX
output=$RESULTS/$SUBJ/secondlevel

bash scripts/render-secondlevel-template.sh $input1 $input2 $output $TEMPLATE
