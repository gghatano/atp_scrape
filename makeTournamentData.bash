#!/bin/bash

dir=$(dirname $0)

[ $# -ne 0 ] && { echo "Usage: ./makeTounamentData.bash" ; exit 0 ; }

for file in `ls $dir/htmls | grep html `
do
  echo $file
  $dir/html2players.bash $file
done
