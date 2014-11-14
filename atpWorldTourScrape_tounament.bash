#!/bin/bash

dir=$(dirname $0)

link_html=$1
year=$(echo $link_html | cut -d"_" -f 1)
num=0

cat $dir/link_htmls/$link_html | while read url
do
  num=$(($num + 1))
  echo $year $num
  curl $url > $dir/htmls/${year}_${num}.html
done


