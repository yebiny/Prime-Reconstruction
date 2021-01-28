#!bin/bash
set -e

SUBJ=${1}
DIR=${2}
INFIX=${3}

target_dir=results/$SUBJ/$DIR

for target in `ls $target_dir/*fsf | grep $INFIX`;
do
    printf $target'\n'
    feat $target
done


