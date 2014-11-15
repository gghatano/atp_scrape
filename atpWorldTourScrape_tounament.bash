#!/bin/bash

dir=$(dirname $0)

link_html=$1
t_year=$(echo $link_html | cut -d"_" -f 1,2,3,4)

echo $t_year
num=0

cat $dir/link_htmls/$link_html | while read url
do
  num=$(($num + 1))
  echo $year $num
  curl $url > $dir/htmls/${t_year}_${num}.html
done


