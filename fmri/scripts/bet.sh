#!/bin/bash
set -e

TARGET_DIR=${1}
OUTPUT_DIR=${2}

if [ -d "$OUTPUT_DIR" ]; then
  read -t 5 -p "data has already been converted. overwrite? (y/N) " overwrite || true
  if [ "$overwrite" != "y" ]; then exit; fi
  rm -rf $OUTPUT_DIR
fi
mkdir -p $OUTPUT_DIR

bet $TARGET_DIR/t1_mprage.nii.gz $OUTPUT_DIR/t1_mprage_brain.nii.gz -R

#! option: -m -B -f
# mask , strict mode(-B, -R..) , -f 0.5 (defalt)
