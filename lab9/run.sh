clear
clear

TEST_FILE="test.al"
OUTPUT="out.asm"
EXPECTED_ASM="scooper.asm"

# Compile test.al to out.asm
make && ./lab9 -o out.asm < "$TEST_FILE"
if [ $? -ne 0 ]
then
  echo ""
  echo "Compilation failed with exit code $EXIT_CODE"
  exit $EXIT_CODE
else
  echo ""
  echo "Created out.asm"
fi

# if [ -x ~scooper/lab9 ]
if [ -x scooperlab9 ]
  then
    ./scooperlab9 -o ${EXPECTED_ASM%.asm} < "$TEST_FILE"
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
echo "TODO: Compare out.asm to ${EXPECTED_ASM}"

normalize_mips() {
  local file="$1"
  sed 's/#.*$//' "$file" |          # strip comments
  sed 's/,//g' |                    # REMOVE COMMAS TODO: fix scooper
  sed 's/^[[:space:]]*//;s/[[:space:]]*$//' |  # trim both ends
  sed '/^$/d' |                     # drop blank lines
  tr -s ' '                         # collapse multiple spaces to one
}


if diff -u <(normalize_mips "$EXPECTED_ASM") <(normalize_mips "$OUTPUT"); then
  echo "PASS"
else
  echo "FAIL"
  exit 1
fi