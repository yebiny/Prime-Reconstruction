#!/bin/bash

SUBJ=${1}

check=data/$SUBJ
sample=data/subSample


if [ -d "$check" ]; then
  read -t 5 -p "directory is already exist. " exit;
else 
cp -rf $sample $check
fi

mkdir results/$SUBJ
