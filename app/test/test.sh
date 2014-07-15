#!/bin/sh

PORT=8080

try() {
  expected_count=$1

  count=`curl -s web-app:8080 | sed 's/^Redis reply: \([0-9]*\)$/\1/'`

  if [ $count != $expected_count ]; then
    echo "[!!!] Failed: expected ${expected_count}, got ${count}" >&2
    exit 2
  fi
}

try 1
try 2
try 3
try 4
try 5

echo 'OK'
