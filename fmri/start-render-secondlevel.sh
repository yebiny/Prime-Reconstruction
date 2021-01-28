#!/bin/bash

SUBJ=${1}
INFIX=${2}

TEMPLATE=templates/secondlevel_template.fsf

input1=results/$SUBJ/firstlevel
input2=$INFIX
output=results/$SUBJ/secondlevel

bash scripts/render-secondlevel-template.sh $input1 $input2 $output $TEMPLATE
