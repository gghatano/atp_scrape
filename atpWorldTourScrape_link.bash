#!/bin/bash


dir=$(dirname $0)

for year in `seq 1968 2014`
do
   curl "http://www.atpworldtour.com/Scores/Archive-Event-Calendar.aspx?t=2&y=$year" |
   grep SGL | grep href |
   awk -F "\"" '{print $2}'  | 
   sed 's;^;http://www.atpworldtour.com;' > $dir/link_htmls/${year}_tournament_link.html
done

