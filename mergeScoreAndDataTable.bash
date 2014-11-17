#!/bin/bash

dir=$(dirname $0)
# file=$(ls dataTable | head -n 1)

[ -e "$dir/mergedData/winLoseScoreData.dat" ] && rm $dir/mergedData/winLoseScoreData.dat
for file in `ls $dir/dataTable`
do
  echo $file
  paste -d"," $dir/dataTable/$file $dir/scores/$file > $dir/mergedData/${file}
done
