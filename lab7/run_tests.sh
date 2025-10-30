#!/usr/bin/env bash

SUCCESS=1

# Good Tests
for f in tests/good/*; do
  ./lab7 < "$f" > /dev/null
  if [ $? -eq 0 ]; then
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
    : # echo "Bad Test Passed"
  else
    echo "Bad Test Failed: $f"
    SUCCESS=0
  fi

  if [ $SUCCESS -eq 1 ]; then
    echo "All Tests Passed"
  else
    echo "Tests Failed!!!!!!!!!"
  fi
done