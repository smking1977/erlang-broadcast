#!/bin/bash

function usage {
    echo "start.sh [config]"
    echo ".  config should be dev or test or other such that ${config}.config exists as a file in the directory of the app"
    echo ".  and that fixture-${config} is valid"
}

args=("$@")

cd $(dirname $0)

if [ $# -lt 1 ]; then
    usage
else
    CONFIG=$1
    if [ -f ./${CONFIG}.config ]; then
        rm -f log/[0-9]* log/index log/kernel.log log/sasl.log
        exec erl +K true -pa ebin -pa deps/*/ebin -boot start_sasl -mnesia dir db -config ${CONFIG}.config  -s rb -s sb -sname sb_${CONFIG}
    fi
fi
