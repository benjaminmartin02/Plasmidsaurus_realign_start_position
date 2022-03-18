#!/bin/bash

SEQ=$1
START=$2

#convert to uppercase (if it's not already)
val=$(echo "$START" | tr '[:lower:]' '[:upper:]')

head -1 $SEQ > ${SEQ}_fasta_header.txt

#remove first line and match to sequence, also include code snippet to convert plasmid sequence to uppercase

MATCHED_ROW_NUM=`sed '1d' $SEQ | tr '[:lower:]' '[:upper:]' | perl -pe "s/$val/\n$val$1/" | wc -l`

#check how many times the start sequence was matched:
ORIG_ROW_NUM=`sed '1d' $SEQ | wc -l`
TIMES_MATCHED=`expr $MATCHED_ROW_NUM - $ORIG_ROW_NUM`

echo "Matched start sequence in plasmid ${TIMES_MATCHED} time"

if [ $TIMES_MATCHED=1 ]; then  

   #make variables for sequence before or after specified start sequence
   SECOND=`sed '1d' $SEQ | tr '[:lower:]' '[:upper:]' | perl -pe "s/$val/\n$val$1/" | head -1`
   FIRST=`sed '1d' $SEQ | tr '[:lower:]' '[:upper:]' | perl -pe "s/$val/\n$val$1/" | head -2 | tail -1`
   
   #paste sequences together and cat back in the fastq header
   echo -e "${FIRST}${SECOND}" | cat ${SEQ}_fasta_header.txt - > Realigned_${SEQ}
   
else
    echo "Error: need to match start sequence one time and only one time - aborting"
fi

rm ${SEQ}_fasta_header.txt
