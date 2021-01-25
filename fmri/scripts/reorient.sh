#!/bin/bash
set -e  
export BXH_DIR=packages/bxh_xcede_tools-1.11.14-MacOSX.i686/bin/

TARGET_DIR=${1}
OUTPUT_DIR=${2}

ORIENTATION=LAS


if [ -d "$OUTPUT_DIR" ]; then
  read -t 5 -p "data has already been converted. overwrite? (y/N) " overwrite || true
  if [ "$overwrite" != "y" ]; then exit; fi
  rm -rf $OUTPUT_DIR
fi
mkdir -p $OUTPUT_DIR


printf "=== Start reorient. ===\n"
for target_file in `ls $TARGET_DIR/*.bxh`; do
  file_name=$(echo ${target_file%%.*}| cut -d'/' -f 3)
  output_file=$OUTPUT_DIR/$file_name
  
  printf "========================\n"
  printf "* target: "$target_file"\n"
  printf "* output: "$output_file"\n"

  # reorient each scan
  $BXH_DIR/bxhreorient --orientation=$ORIENTATION $target_file $output_file  1>/dev/null 2>/dev/null
done
