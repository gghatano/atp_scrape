#!/bin/bash

dir=$(dirname $0)
# file=$(ls players | grep BNL | head -n 1)
file=$1
pid=$$

# [ $# -ne 1 ] && { echo "Usage: the name of input player_tounament_file." ; exit 0 ; }

title=$(cat $dir/players/$file | head -n 1 | cut -d"," -f 1 | sed "s/\'/_/g")
# echo $title 
grade=$(cat $dir/players/$file | head -n 1 | cut -d"," -f 2)
# echo $grade

## get tounament-round-player-relation
cat $dir/players/$file | 
awk '{if(NR>1) print $0}' | 
sed 's/[^a-zA-Z_%]//g' | 
tr '\n' ',' | 
sed 's/%%*/%/g' | 
tr '%' '\n' | 
sed -e 's/^,//' -e 's/,$//' | 
grep -v -E "^ *$" > $dir/tmp/tournament.txt.$pid


date=$(echo $file | 
sed "s/\'/_/g" | 
xargs -I {} basename {} .txt | 
awk -F"_" -v OFS="," '{print $(NF-2), $(NF-1),$(NF)}')

round=0
[ -e "$dir/tmp/matches.txt.$pid" ] && rm $dir/tmp/matches.txt.$pid
cat $dir/tmp/tournament.txt.$pid | while read line 
do
  round=$(($round + 1))
  echo $line |
  gsed 's/\([^,]*\),\([^,]*\),/\1,\2\n/g' | 
  gsed "s/^/$title,$grade,$date,$round,/"  >> $dir/tmp/matches.txt.$pid
done

## get winner-name 
cat $dir/tmp/tournament.txt.$pid |
awk '{if(NR>1) print $0}' | 
tr '\n' ',' | 
tr ',' '\n'  > $dir/tmp/winners.txt.$pid

# cat $dir/tmp/matches.txt
# cat $dir/tmp/winners.txt


fileName=$(echo $file | sed -e 's/players_//' -e "s/\'/_/")
echo $fileName

## make data table 
## date-round-player1-player2-winner
paste -d"," $dir/tmp/matches.txt.$pid $dir/tmp/winners.txt.$pid | 
awk -F "," '{if(NF>8) print $0}'  > $dir/dataTable/$fileName

ls $dir/tmp | grep -E "txt.$pid" | sed "s;^;$dir/tmp/;" | xargs rm 
