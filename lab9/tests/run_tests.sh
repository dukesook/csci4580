#!/usr/bin/env bash

mkdir -p asm/output/
mkdir -p asm/expected/
SUCCESS=1
COUNT=0

# Build Project
make -C .. > /dev/null
if [ $? -ne 0 ]
then
  echo "error! Build failed."
  exit 1
fi



for f in ./algo/good/*
do
  OUTPUT="asm/output/$(basename "${f%.al}.asm")"
  EXPECTED="asm/expected/$(basename "${f%.al}".asm)"

  # Run Lab 9
  ../lab9 -o "$OUTPUT" < "$f" > /dev/null

  # Run Scooper's Lab 9
  ./scooperlab9 -o "${EXPECTED%.asm}" < "$f" > /dev/null

  # Compare the outputs
  diff -u <(./normalize_mips.sh "$EXPECTED") <(./normalize_mips.sh "$OUTPUT")
  if [ $? -eq 0 ]; then
    let COUNT+=1
    echo -e "Test $f: \e[32mPassed\e[0m"
  else
    echo -e "Test $f: \e[31mFailed!\e[0m"
    SUCCESS=0
  fi
done

