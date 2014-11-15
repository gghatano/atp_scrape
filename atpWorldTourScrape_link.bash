#!/bin/bash


dir=$(dirname $0)

for t in `seq 1 5`
do
  for year in `seq 1968 2014`
  do
     curl "http://www.atpworldtour.com/Scores/Archive-Event-Calendar.aspx?t=$t&y=$year" |
     grep SGL | grep href |
     awk -F "\"" '{print $2}'  | 
     sed 's;^;http://www.atpworldtour.com;' > $dir/link_htmls/t_${t}_year_${year}_tournament_link.html
  done
done

