#!/bin/bash
set -e  
export BXH_DIR=packages/bxh_xcede_tools-1.11.14-MacOSX.i686/bin/

TARGET_DIR=${1}
OUTPUT_DIR=${2}
ORIENTATION=LAS

# check output directory
if [ -d "$OUTPUT_DIR" ]; then
  read -t 5 -p "data has already been converted. overwrite? (y/n) " overwrite || true
  if [ "$overwrite" == "n" ]; then exit; fi
else mkdir $OUTPUT_DIR
fi


printf "=== Start reorient. ===\n"
printf "* output dir : %s"$OUTPUT_DIR"\n"
for target_file in `ls $TARGET_DIR/*.bxh`; do
  #file_name=$(echo ${target_file%%.*}| cut -d ' ' -f 3)
  file_name=$(echo ${target_file%%.*}| rev | cut -d '/' -f 1|rev)
  output_file=$OUTPUT_DIR/$file_name
  
  printf "========================\n"
  printf "* file_name: "$file_name"\n"
  printf "* target: "$target_file"\n"
  printf "* output: "$output_file"\n"

  # reorient each scan
  $BXH_DIR/bxhreorient --orientation=$ORIENTATION $target_file $output_file  1>/dev/null 2>/dev/null

done

