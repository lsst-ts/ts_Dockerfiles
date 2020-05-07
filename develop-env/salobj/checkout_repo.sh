#!/usr/bin/env bash

if [ $# == 0 ]; then
    echo "Give branch names to checkout."
    exit 1
else
    echo "Got $# positional parameters."
fi

git fetch --all

while [ "$1" != "" ]; do
    if [[ "$1" == tags/* ]] ;
    then
        echo checkout $1 -b $1
        git checkout $1 -b $1 && exit 0
    else
        echo checkout $1
        git pull
        git checkout $1 && exit 0
    fi

    shift

done

exit 1

