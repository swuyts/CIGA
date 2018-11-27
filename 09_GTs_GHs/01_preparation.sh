cd in/

wget http://csbl.bmb.uga.edu/dbCAN/download/dbCAN-fam-HMMs.txt
wget http://csbl.bmb.uga.edu/dbCAN/download/hmmscan-parser.sh

hmmconvert -a dbCAN-fam-HMMs.txt > dbCAN-fam-HMMs_converted.txt
hmmpress dbCAN-fam-HMMs_converted.txt
