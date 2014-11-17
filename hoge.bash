#!/bin/bash

for file in `ls players`
do
  echo $file
  ./makeWinLoseData.bash $file
done
