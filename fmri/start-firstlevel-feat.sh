#!bin/bash
set -e

TARGET_DIR=results/${1}/firstlevel

for target in `ls $TARGET_DIR/*fsf`;
do
    printf $target'\n'
    feat $target
done


