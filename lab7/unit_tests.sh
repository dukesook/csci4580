#!/usr/bin/env bash

SUCCESS=1
COUNT=0

# Good Tests
for f in tests/good/*; do
  ./lab7 < "$f" > /dev/null
  if [ $? -eq 0 ]; then
    let COUNT+=1
    : # echo "Good Test: Passed $f"
  else
    echo "Good Test Failed: $f"
    SUCCESS=0
  fi
done

# Bad Tests
for f in tests/bad/*; do
  ./lab7 < "$f" > /dev/null
  if [ $? -eq 1 ]; then
    let COUNT+=1
    : # echo "Bad Test Passed"
  else
    echo "Bad Test Failed: $f"
    SUCCESS=0
  fi
done

if [ $SUCCESS -eq 1 ]; then
  echo "All $COUNT Tests Passed"
else
  echo "Tests Failed!!!!!!!!!"
fi
