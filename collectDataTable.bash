#!/bin/bash

for file in `ls ./dataTable `
do
  echo $file

  title=$(head -n 1 ./dataTable/$file | 
  sed 's/.$//' |
  sed 's/,/ /')
  echo $title

  cat dataTable/$file | 
  awk '{if(NR>1) print $0}' | 
  sed "s/^/$title,/"  >> winLoseData
done
