#!/bin/bash

dir=$(dirname $0)

[ $# -ne 0 ] && { echo "Usage: ./makeTounamentData.bash" ; exit 0 ; }

ls $dir/htmls | grep html | parallel -a - $dir/html2players.bash
