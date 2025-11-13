clear
clear

TEST_FILE="test.al"

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

if [ -x ~scooper/lab9 ]
  then
    ~scooper/lab9 -o scooper < "$TEST_FILE"
    if [ $? -ne 0 ]
    then
      echo ""
      echo "Scooper's compilation failed with exit code $EXIT_CODE"
      exit $EXIT_CODE
    else
      echo ""
      echo "Scooper created scooper.asm"
    fi 
fi


# if statement that always fails to skip running MARS during automated testing
if [ 1 -eq 0 ]
then
  echo ""
  echo ""
  echo "Running MARS with out.asm"

  java -jar Mars4_5.jar sm out.asm
fi

