#!/bin/bash

dir=`dirname $0`

## remove vacant data files

ls -l $dir/dataTable |
awk '{if($5<1) print $9}' |
sed -e "s;^;$dir/;" | 
xargs rm 


