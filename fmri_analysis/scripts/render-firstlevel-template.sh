#!/bin/bash
set -e
source tool.sh

#VARIABLES
TARGET_DIR=${1}
MPRAGE_BRAIN=${2}
OUTPUT_DIR=${3}

template=${4}
DESIGN_DIR=${5}
INFIX=${6}

function render_firstlevel {
  fsf_template=$1
  output_dir=$2
  standard_brain=$3
  data_file_prefix=$4
  initial_highres_file=$5
  highres_file=$6
  ev_dir1=$7
  ev_dir2=$8
  ev_dir=$9

  # note: the following replacements put absolute paths into the fsf file. this
  #       is necessary because FEAT changes directories internally
  cat $fsf_template \
    | sed "s:<?= \$OUTPUT_DIR ?>:$output_dir:g" \
    | sed "s:<?= \$STANDARD_BRAIN ?>:$standard_brain:g" \
    | sed "s:<?= \$DATA_FILE_PREFIX ?>:$data_file_prefix:g" \
    | sed "s:<?= \$INITIAL_HIGHRES_FILE ?>:$initial_highres_file:g" \
    | sed "s:<?= \$HIGHRES_FILE ?>:$highres_file:g" \
    | sed "s:<?= \$EV1 ?>:$ev_dir1:g" \
    | sed "s:<?= \$EV2 ?>:$ev_dir2:g" \
    | sed "s:<?= \$EV_DIR ?>:$ev_dir:g" 

}


if [ -d "$OUTPUT_DIR" ]; then
  read -t 5 -p "data has already been converted. overwrite? (y/N) " overwrite || true
  if [ "$overwrite" == "n" ]; then exit; fi
else mkdir $OUTPUT_DIR
fi

for target in `ls $TARGET_DIR | grep $INFIX | grep nii`;
do
    outfix=$(echo ${target%%.*}| rev | cut -d'/' -f 1 |rev)
    printf '==========================================\n'
    printf '* target: '$target'\n'
    printf '* template: '$template'\n'
    printf '* output: '$OUTPUT_DIR/$outfix'\n' 
    render_firstlevel $template \
                      $OUTPUT_DIR/$outfix.feat\
                      $STANDARD_BRAIN \
                      $TARGET_DIR/$target \
                      $USELESS_BRAIN \
                      $MPRAGE_BRAIN \
                      . \
                      . \
                      $DESIGN_DIR/$outfix \
                      > $OUTPUT_DIR/$outfix.fsf
done

