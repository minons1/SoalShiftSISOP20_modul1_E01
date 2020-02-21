#!/bin/bash

LC_NUMERIC=POSIX awk -F'\t' 'BEGIN {min=100000000};
{if( $21<min && $21 != "") {min=$21;region=$13}}
END {print min,region}' dataset.tsv
