#!/bin/bash

dir=$(dirname $0)
echo "TOURNAMENT,GRADE,YEAR,MONTH,DAY,ROUND,PLAYER_1,PLAYER_2,WINNER" > winLoseData.dat
for file in `ls ./dataTable`
do
  cat $dir/"dataTable"/$file >> winLoseData.dat
done
