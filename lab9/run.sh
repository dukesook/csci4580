clear
clear

TEST_FILE="test.al"
OUTPUT="out.asm"
EXPECTED_ASM="scooper.asm"
NORMALIZE="./tests/normalize_mips.sh"
LAB9_EXIT_CODE=0
SCOOPER_EXIT_CODE=0

# Compile test.al to out.asm
make && ./lab9 -o out.asm < "$TEST_FILE"
LAB9_EXIT_CODE=$?
if [ $LAB9_EXIT_CODE -eq 0 ] # if success
then
  echo ""
  echo "Created out.asm"
else
  echo ""
  echo -e "./lab9 -o out.asm: \e[31mFailed!\e[0m"
fi

# Run scooper's lab9
./tests/scooperlab9 -o ${EXPECTED_ASM%.asm} < "$TEST_FILE"
SCOOPER_EXIT_CODE=$?

echo ""
if [ $LAB9_EXIT_CODE -ne $SCOOPER_EXIT_CODE ]
then
  echo -e "Lab9 exit code: \e[31m$LAB9_EXIT_CODE\e[0m"
  echo -e "Scooper's exit code: \e[31m$SCOOPER_EXIT_CODE\e[0m"
  echo -e "Exit codes do not match. Please check your implementation."
  exit 1
elif [ $LAB9_EXIT_CODE -eq 0 ] # if both succeeded
then
  echo "Lab9 created ${OUTPUT}"
  echo "Scooper created ${EXPECTED_ASM}"
else # both failed
  echo -e "Lab9 exit code: \e[31m$LAB9_EXIT_CODE\e[0m"
  echo -e "Scooper's exit code: \e[31m$SCOOPER_EXIT_CODE\e[0m"
  echo -e "\e[31m${TEST_FILE} is bad!\e[0m"
  exit 1
fi


# Compare out.asm to scooper.asm
# diff
#  -y : side-by-side comparison
#  -u : unified format - means ???
#  --suppress-common-lines : only show differing lines
if diff --color=always -u  <($NORMALIZE "$OUTPUT") <($NORMALIZE "$EXPECTED_ASM")
then
  echo -e "\e[32mPASS\e[0m"
else
  echo -e "\e[31mFAIL\e[0m"
fi