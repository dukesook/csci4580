#!/usr/bin/env bash

clear
clear

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
  ../lab9 -o "${OUTPUT%.asm}" < "$f" > /dev/null
  if [ $? -ne 0 ]
  then
    echo -e "Test $f: \e[31mCompilation Failed!\e[0m"
    SUCCESS=0
    continue
  fi

  # Run Scooper's Lab 9
  ./scooperlab9 -o "${EXPECTED%.asm}" < "$f" > /dev/null

  # Compare the outputs
  BASENAME=$(basename "$f")
  diff -u --color=always <(./normalize_mips.sh "$EXPECTED") <(./normalize_mips.sh "$OUTPUT")
  if [ $? -eq 0 ]; then
    let COUNT+=1
    echo -e "Test $BASENAME: \e[32mPassed\e[0m"
  else
    echo -e "Test $f: \e[31mFailed!\e[0m"
    SUCCESS=0
  fi
done

echo ""
if [ $SUCCESS -eq 1 ]
then
  echo -e "All $COUNT tests \e[32mPassed\e[0m"
else
  echo -e "Some tests \e[31mFailed\e[0m"
fi
