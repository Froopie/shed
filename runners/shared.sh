#!/usr/bin/env bash

function read_code_and_input {
  export INPUT=$(cat -)
  /opt/shed/split_input.py <<< "${INPUT}"

  export FCODE="./code"
  export FSTDIN="/stdin"
}

function run {
  RUNNER=${*}

  cat ${FSTDIN} | ${RUNNER} 2>&1 &

  PID=$!

  sleep 5 && kill ${PID} 2> /dev/null &
  wait ${PID}
}

read_code_and_input
