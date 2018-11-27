#!/bin/bash

for file in manifestfiles/*txt
do
	java -jar scripts/webin-cli-1.5.1.jar -context genome -userName LOGIN -password PASSWORD -manifest $file -submit

done
