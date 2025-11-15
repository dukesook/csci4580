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


# Function Definition
normalize_mips() {
  local file="$1"
  sed 's/#.*$//' "$file" |                     # strip comments
  sed 's/,//g' |                               # REMOVE COMMAS TODO: fix scooper
  sed 's/^[[:space:]]*//;s/[[:space:]]*$//' |  # trim both ends
  sed '/^$/d' |                                # drop blank lines
  tr -s ' '                                    # collapse multiple spaces to one
}

# Compare out.asm to scooper.asm
if diff -u <(normalize_mips "$EXPECTED_ASM") <(normalize_mips "$OUTPUT")
then
  echo -e "\e[32mPASS\e[0m"
else
  echo -e "\e[31mFAIL\e[0m"
fi