#!/bin/bash
source tool.sh


function define_vars {
 firstlevel_dir=$1
 inifx=$2
 outfix=$3
 standard_brain=$4
  
 echo "
 <?php
 \$OUTPUT_DIR = '$outfix';
 \$STANDARD_BRAIN = '$STANDARD_BRAIN';
 \$FIRSTLEVEL_DIR='$firstlevel_dir';
 "

 echo '$runs = array();'
 for runs in `ls $firstlevel_dir | grep $infix | grep feat`; do
   echo "array_push(\$runs, '$runs');";
 done

 echo "
 ?>
 "
}

input_dir=${1}
infix=${2}
output_dir=${3}
template=${4}

fsf_out=$output_dir/$infix.fsf
gfeat_out=$output_dir/$infix.gfeat

if [ -d "$output_dir" ]; then
  read -t 5 -p "data has already been converted. overwrite? (y/N) " overwrite || true
  if [ "$overwrite" != "y" ]; then exit; fi
else mkdir $output_dir
fi


define_vars $input_dir $infix $gfeat_out | cat - "$template" | php > "$fsf_out"
