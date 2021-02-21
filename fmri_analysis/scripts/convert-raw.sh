#!/bin/bash
set -e  # fail immediately on error
source path.sh

# variables
SUBJ=${1}
DICOM_DIR=${2}
OUTPUT_DIR=${3}

# custom these lines
export BXH_DIR=packages/bxh_xcede_tools-1.11.14-MacOSX.i686/bin/
source $DATA/$SUBJ/dicom_list.sh
run_order_file=$DATA/$SUBJ/run-order.txt

# fix lines 
ORIENTATION=LAS
PREFIX=scan
ERROR_FLAG=ERROR_RUN
UNEXPECTED_NUMBER_OF_SCANS=1
UNEXPECTED_NUMBER_OF_TRS=2

# check output directory
if [ -d "$OUTPUT_DIR" ]; then
  read -t 5 -p "data has already been converted. overwrite? (y/n) " overwrite || true
  if [ "$overwrite" == "n" ]; then exit; fi
else mkdir $OUTPUT_DIR
fi


printf "* output dir : %s"$OUTPUT_DIR"\n"
temp_output_dir=$(mktemp -d -t tmp.XXXXXX)


# dicom2bxh
printf "* data dir : %s"$DICOM_DIR"\n"
t=0
for i in $DICOMLIST
do
  let "t += 1"
$BXH_DIR/dicom2bxh $DICOM_DIR/*KBRI.$i*.IMA $temp_output_dir/$PREFIX-$t.bxh 1>/dev/null 2>/dev/null
printf $i"\n"
done

# strip blank lines and comments from run order file
stripped_run_order_file=$(mktemp -t tmp.XXXXX)
sed '/^$/d;/^#/d;s/#.*//' $run_order_file > $stripped_run_order_file

# check that the actual number of scans retrieved matches what's expected, and
# exit with an error if not.
num_actual_scans=$(find $temp_output_dir/*.bxh -maxdepth 1 -type f | wc -l)
num_expected_scans=$(wc -l < $stripped_run_order_file)
if [ $num_actual_scans != $num_expected_scans ]; then
  echo "found $num_actual_scans scans, but $num_expected_scans were described in $run_order_file. check that you're listing enough scans for your circle localizer, etc... because those may convert as more than one scan." >/dev/stderr
  exit $UNEXPECTED_NUMBER_OF_SCANS
fi

printf "END\n"



# convert all scans to gzipped nifti format, and if the run order file indicates
# how many TRs are expected in a particular scan, check that there are actually
# that many TRs, and exit with an error if not.
number=0
# the sed magic here strips out comments
cat $stripped_run_order_file | while read name num_expected_trs; do
  let "number += 1"
  if [ $name == $ERROR_FLAG ]; then
    continue
  fi
# convert the scan
  niigz_file_prefix=$temp_output_dir/$name
  $BXH_DIR/bxh2analyze --analyzetypes --niigz --niftihdr -s "${temp_output_dir}/${PREFIX}-$number.bxh" $niigz_file_prefix 1>/dev/null 2>/dev/null

  if [ -n "$num_expected_trs" ]; then
    num_actual_trs=$(fslnvols ${niigz_file_prefix}.nii.gz)
    if [ $num_expected_trs -ne $num_actual_trs ]; then
      echo "$name has $num_actual_trs TRs--expected $num_expected_trs" >/dev/stderr
      exit $UNEXPECTED_NUMBER_OF_TRS
    fi
  fi
done

printf "END2\n"

rm -f $temp_output_dir/$PREFIX-*.bxh
rm -f $temp_output_dir/$PREFIX-*.dat
rm -f $stripped_run_order_file
mv $temp_output_dir/* $OUTPUT_DIR

