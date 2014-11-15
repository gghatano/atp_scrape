#!/bin/bash

echo "TOURNAMENT,GRADE,YEAR,MONTH,DAY,ROUND,PLAYER_1,PLAYER_2,WINNER" > winLoseData.dat
for file in `ls ./dataTable`
do

  title=$(head -n 1 ./dataTable/$file | 
  sed 's/.$//' |
  sed 's/,/ /')
  echo $title

  grade=$(echo $file | cut -d"_" -f 2)

  cat dataTable/$file | 
  awk '{if(NR>1) print $0}' | 
  sed "s/^/$title,$grade,/"  >> winLoseData.dat
done
