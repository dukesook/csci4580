clear
clear

TEST_FILE="test.al"
OUTPUT="out.asm"
EXPECTED_ASM="scooper.asm"
NORMALIZE="./tests/normalize_mips.sh"

# Compile test.al to out.asm
make && ./lab9 -o out.asm < "$TEST_FILE"
if [ $? -ne 0 ]
then
  echo ""
  echo -e "./lab9 -o out.asm: \e[31mFailed!\e[0m"
  exit 1
else
  echo ""
  echo "Created out.asm"
fi

# if [ -x ~scooper/lab9 ]
if [ -x ./tests/scooperlab9 ]
  then
    ./tests/scooperlab9 -o ${EXPECTED_ASM%.asm} < "$TEST_FILE"
    if [ $? -ne 0 ]
    then
      echo ""
      echo "Scooper's compilation failed with exit code $EXIT_CODE"
      exit $EXIT_CODE
    else
      echo ""
      echo "Scooper created ${EXPECTED_ASM}"
    fi 
fi


# Compare out.asm to scooper.asm
if diff -u <($NORMALIZE "$EXPECTED_ASM") <($NORMALIZE "$OUTPUT")
then
  echo -e "\e[32mPASS\e[0m"
else
  echo -e "\e[31mFAIL\e[0m"
fi