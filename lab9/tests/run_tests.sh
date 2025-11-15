#!/usr/bin/env bash

mkdir -p asm/output/
mkdir -p asm/expected/

(cd ..; make)

SUCCESS=1
COUNT=0

for f in ./algo/good/*
do
  OUTPUT="asm/output/$(basename "${f%.al}.asm")"
  EXPECTED="asm/expected/$(basename "${f%.al}".asm)"

  # Run Lab 9
  ../lab9 -o "$OUTPUT" < "$f" > /dev/null

  # Run Scooper's Lab 9
  ./scooperlab9 -o "${EXPECTED%.asm}" < "$f" > /dev/null


  if [ $? -eq 0 ]; then
    let COUNT+=1
    echo "Good Test: Passed $f"
  else
    echo "Good Test Failed: $f"
    SUCCESS=0
  fi
done

