#!/bin/bash
set -ex
DOT_FILES=$(readlink -f $(dirname $0))
find $DOT_FILES -mindepth 1 -prune -path '*/.git' -o -iname .\* -print0 | xargs --verbose -0 ln -s -f -t $HOME

