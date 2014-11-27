#!/bin/bash

## cleanup winLoseScore.dat

## ./bad_tournament.list : unrelieable tournament names

cat ./bad_tournament.list | head -n 1 | while read line
do
  echo $line
  tournament=$(echo $line | cut -d"," -f1)
  year=$(echo $line | cut -d"," -f2)
  echo $tournament
  echo $year

  cat ./winLoseScore.dat | 
  grep "$tounament,$year"

done
