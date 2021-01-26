#!/bin/bash

SUBJ=${1}
DATA=${2}

bash scripts/convert-raw.sh $SUBJ $DATA results/$SUBJ/1-convert
bash scripts/reorient-las.sh results/$SUBJ/1-convert/ results/$SUBJ/2-reorient
bash scripts/bet.sh results/$SUBJ/2-reorient/ results/$SUBJ/3-bet/
