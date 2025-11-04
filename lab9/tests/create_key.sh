
clear
clear

EXE=~scooper/lab9
EXE="../lab9"

for filepath in good/*.al;
do
  FILE=$(basename "${filepath%.al}")
  echo $FILE
  "$EXE" -o "${FILE}"  < $"filepath"
done