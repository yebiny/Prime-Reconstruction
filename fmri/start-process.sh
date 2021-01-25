#!/bin/bash

SUBJ=${1}
DATA=${2}
OUTDIR=results/$SUBJ

input_1=$DATA
output_1=$OUTDIR/process/1-convert
run_order_file_1=exp_info/$SUBJ/run-order.txt
bash processing/convert-and-wrap-raw-data_new.sh $input_1 $output_1 $run_order_file_1

input_2=$output_1
output_2=$OUTDIR/process/2-orient
bash processing/reorient-to-las.sh $input_2 $output_2

input_3=$output_2
output_3=$OUTDIR/process/3-bet
bash processing/bet.sh $input_3 $output_3
