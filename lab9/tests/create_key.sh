
clear
clear

mkdir -p key

EXE='~scooper/lab9'
#EXE="../lab9"

for filepath in good_al/*.al;
do
  FILE=$(basename "${filepath%.al}")
  ~scooper/lab9 -o "key/${FILE}"  < "$filepath"
  EXIT_CODE=$?
  if [ $EXIT_CODE -ne 0 ]; then
    echo "Failed to create key for ${FILE} with exit code ${EXIT_CODE}"
  else
    echo "Created key for ${FILE}"
  fi

done