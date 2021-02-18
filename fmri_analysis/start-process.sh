#!/bin/bash
source path.sh

SUBJ=${1}
RAWDATA=${2}

bash scripts/convert-raw.sh $SUBJ $RAWDATA $RESULTS/$SUBJ/1-convert
bash scripts/reorient-las.sh $RESULTS/$SUBJ/1-convert/ $RESULTS/$SUBJ/2-reorient
bash scripts/bet.sh $RESULTS/$SUBJ/2-reorient/ $RESULTS/$SUBJ/3-bet/
