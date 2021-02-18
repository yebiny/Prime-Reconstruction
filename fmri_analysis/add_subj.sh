#!/bin/bash

source path.sh

SUBJ=${1}

check=$DATA/$SUBJ
sample=subSample


if [ -d "$check" ]; then
  read -t 5 -p "directory is already exist. " exit;
else 
cp -rf $sample $check
mkdir $RESULTS/$SUBJ
fi

