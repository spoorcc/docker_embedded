#/usr/bin/env bash

function local_ci() {
basedir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/..
echo "$basedir"
while inotifywait -r --exclude='.*(\/bld\/.*|.sw(p|o))' -e modify $basedir/src; do
    cmake --build $basedir/bld
    # Wait a little bit before rescheduling
    sleep 3
done

}

local_ci
