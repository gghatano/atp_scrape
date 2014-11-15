#!/bin/bash

dir=$(dirname $0)

for file in `ls $dir/htmls | grep html | head`
do
  echo $file
  $dir/html2players.bash $file
done
