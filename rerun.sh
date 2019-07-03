#!/usr/bin/env bash

# Living in https://gist.github.com/rubencaro/633cd90065d399d5fe1b56e46440d2bb
# Loosely based on https://github.com/tartley/rerun2

ignore_secs=0.25
clear='false'
verbose='false'
ignore_until=$(date +%s.%N)
excludes='\.git|\.coverage|\.cache|tmp|env|deps|_build'
cmd=""
yellow=$(tput setaf 11)
reset=$(tput sgr0)

function usage {
    cat << USAGE
Rerun a given command every time filesystem changes are detected.

Usage: $(basename $0) [OPTIONS] COMMAND

  -c, --clear             Clear the screen before each execution of COMMAND.
  -v, --verbose           Print details about this script's execution.
  -h, --help              Display this help and exit.
  -e, --exclude REGEXP    Don't fire for paths that match given REGEXP.
                              Can be given several times.

Run the given COMMAND, and then every time filesystem changes are
detected in or below the current directory, run COMMAND again.

Given REGEXPs will be concatenated using OR and passed to 'inotifywait'.
Any path matching any of those REGEXPs will not be monitored for changes.
Default excludes are '$excludes'

COMMAND can only be a simple command, ie. "executable arg arg...".
For compound commands, use:

    $(basename $0) bash -c "ls -l | grep ^d"

USAGE
}

while [ $# -gt 0 ]; do
    case "$1" in
        -c|--clear) clear='true';;
        -v|--verbose) verbose='true';;
        -h|--help) usage; exit;;
        -e|--exclude) # add to default excludes
            excludes="$excludes|$2"; shift;;
        *) # the rest is the actual cmd
            cmd="$@"; break;;
    esac
    shift
done

function maybe_echo {
    [ $verbose = "true" ] && echo $1
}

function execute {
    [ $clear = "true" ] && clear
    maybe_echo "At: $yellow$(date)$reset"
    maybe_echo "Excludes: $yellow$excludes$reset"
    maybe_echo "Running: $yellow$cmd$reset"
    (sleep $ignore_secs && $cmd) &
}

execute

inotifywait --quiet --recursive --monitor --format "%e %w%f" \
    --event modify --event move --event create --event delete \
    --exclude "($excludes)" \
    . | while read changed
do
    # ignore events that are too close in time, fire only once
    if [ $(echo "$(date +%s.%N) > $ignore_until" | bc) -eq 1 ] ; then
        ignore_until=$(echo "$(date +%s.%N) + $ignore_secs" | bc)
        maybe_echo "Changed: $changed"
        execute
    fi
done
