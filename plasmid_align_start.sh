#!/bin/bash

SEQ=$1
START=$2

echo "Starting plasmid file is: $SEQ"
echo "Start sequence input: $START"

#convert to uppercase (if it's not already)
val=$(echo "$START" | tr '[:lower:]' '[:upper:]')

echo "Start sequence after conversion to uppercase (if needed): $val"

#make temp file with header
head -1 $SEQ > ${SEQ}_fasta_header.txt

#make temp file with sequence, also include code snippet to convert any lowercase sequence to uppercase
sed '1d' $SEQ | tr '[:lower:]' '[:upper:]' > ${SEQ}_sequence


#remove first line and match to sequence

MATCHED_ROW_NUM=`perl -pe "s/$val/\n$val$1/g" ${SEQ}_sequence | wc -l`

#check how many times the start sequence was matched:
ORIG_ROW_NUM=`cat ${SEQ}_sequence | wc -l`
TIMES_MATCHED=`expr $MATCHED_ROW_NUM - $ORIG_ROW_NUM`

echo "Matched start sequence in plasmid ${TIMES_MATCHED} time"

if [ $TIMES_MATCHED=1 ]; then  

   #make variables for sequence before or after specified start sequence
   SECOND=`perl -pe "s/$val/\n$val/" ${SEQ}_sequence | head -1`
   FIRST=`perl -pe "s/$val/\n$val/" ${SEQ}_sequence | head -2 | tail -1`
   
   #paste sequences together and cat back in the fastq header
   echo -e "${FIRST}${SECOND}" | cat ${SEQ}_fasta_header.txt - > Realigned_${SEQ}
   
else
    echo "Error: need to match start sequence one time and only one time - aborting"
fi

rm ${SEQ}_fasta_header.txt
rm ${SEQ}_sequence
