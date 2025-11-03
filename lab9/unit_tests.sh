#!/usr/bin/env bash

make

SUCCESS=1
COUNT=0

# Good Tests
for f in tests/good/*; do
  ./lab9 -o out.asm < "$f" > /dev/null
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
  ./lab9 -o out.asm < "$f" > /dev/null
  RESULT=$?
  if [ $RESULT -eq 1 ]; then
    let COUNT+=1
  else
    echo "Bad Test Failed: $f with value $RESULT"
    cat "$f"
    SUCCESS=0
  fi
done

if [ $SUCCESS -eq 1 ]; then
  echo "All $COUNT Tests Passed"
else
  echo "Tests Failed!!!!!!!!!"
fi
