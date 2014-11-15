#!/bin/bash

dir=$(dirname $0)
file=$1
# file="t_1_01.02.1970.txt.12797"

[ $# -ne 1 ] && { echo "Usage: the name of unput player_tounament_file." ; exit 0 ; }

## make date
day=$(echo $file | awk -F "." '{print $1}' | awk -F"_" '{print $3}')
month=$(echo $file | awk -F "." '{print $2}')
year=$(echo $file | awk -F "." '{print $3}')
date=$(echo $year,$month,$day)

tournamentGrade=$(echo $file | cut -d"_" -f 1,2)

echo $date
echo $tournamentGrade

title=$(cat $dir/players/$file | head -n 1)
echo $title 

## get tounament-round-player-relation
cat $dir/players/$file | 
awk '{if(NR>1) print $0}' | 
sed 's/[^a-zA-Z_%]//g' | 
tr '\n' ',' | 
tr '%' '\n' | 
sed -e 's/^,//' -e 's/,$//' | 
grep -v -E "^ *$" > $dir/tmp/tournament.txt

round=0
[ -e "$dir/tmp/matches.txt" ] && rm $dir/tmp/matches.txt
cat $dir/tmp/tournament.txt | while read line 
do
  round=$(($round + 1))
  echo $line |
  gsed 's/\([^,]*\),\([^,]*\),/\1,\2\n/g' | 
  gsed "s/^/$date,$round,/" >> $dir/tmp/matches.txt
done

## get winner-name 
cat $dir/tmp/tournament.txt |
awk '{if(NR>1) print $0}' | 
tr '\n' ',' | 
tr ',' '\n' > $dir/tmp/winners.txt

# cat $dir/tmp/matches.txt
# cat $dir/tmp/winners.txt

## make data table 
## date-round-player1-player2-winner
echo $title > $dir/dataTable/$file.dataTable 
paste -d"," $dir/tmp/matches.txt $dir/tmp/winners.txt | 
awk -F "," '{if(NF>6) print $0}' >> $dir/dataTable/$file.dataTable

