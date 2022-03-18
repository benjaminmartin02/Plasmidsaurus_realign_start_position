# Plasmidsaurus_realign_start_position
Quick code to realign start position of plasmidsaurus fasta based on input starting sequence. This is because the start of plasmid sequence is random, which can be a bit of a pain when comparing multiple plasmids (eg. making point mutants).

To run, simply input your plasmidsaurus sequence (fasta file) and the sequence where you want the plasmid to start.
- note, this assumes the fasta sequence **does not** contain any line breaks (so one line header and one line with sequence). eg.
```
>your_plasmid_sequence     coverage: 1.03e+03x
AATGTAGTCTTATGCAATACTCTTGTAGTCTTGCAACATGGTAACGATGAGTTAGCAACATGCCTTACAAGGAGAGAAAAAGCACCGTGCATGCCGATTGGTGGAAGTAAGGTGGTACGATCGTGCCTTATTAGGAAGGCAACAGACGGGTCTGACATGGATTGGACGAACCACTGAATTGCCGCATTGCAGAGATATTGTATTTAAGTGCCTAGCTCGATACATAAACGGGTCTCTCTGGTTAGACCAGATCTGAGCCTGGGAGCTCTCTGGCTAACTAGGGAACCCACTGCTTAAGCCTCAATAAAGCTTGCCTTGAGTGCTTCAAGTAGTGTGTGCCCGTCTGTTGTGTGACTCTGGTAACTAGAGATCCCTCAGACCCTTTTAGTCAGTGTGGAAAATCTCTAGCAGTGGCGCCCGAACAGGGACTTGAAAGCGAAAGGGAAACCAGAGGAGCTCTCTCGACGCAGGACTCGGCTTGCTGAAGCGCGCACGGCAAGAGGCGAGGGGCGGCGACTGGTGAGTACGCCAAAAATTTTGACTAGCGGAGGCTAGAAGGAGAGAGATGGGTGCGAGAGCGTCAGTATTAAGCGGGGGAGAATTAGATCGCGATGGGAAAAAATTCGGTTAAGGCCAGGGGGAAAGAAAAAATATAAATTAAAACATAT
```

### Usage
Using the **plasmid_align_start.sh**, give two inputs (in order, space delimited): 
1. the plasmid fasta file (must be formatted as above)
2. the start sequence to align by... note, the start sequence must be found in your plasmid once, and only once, otherwise the script will error.

Note, the script will convert any lowercase sequences to uppercase before attempting to match (so it should be case-insensitive).

The script will output a realigned sequence with "Realigned_" stuck on the start of your the file name: eg. **your_plasmid_sequence.fasta** as input will have the results output in file: **Realigned_your_plasmid_sequence.fasta**

So running the script can be done as so:
```
./plasmid_align_start.sh your_plasmid_sequence.fasta CTCAGACCCTTTTAGTCAGTGTGGAAAATCTCTAGCAGTGGCGCCC
```

Note, you may need to give execute permission to the script file, like so:
```
chmod a+x ./plasmid_align_start.sh
```
