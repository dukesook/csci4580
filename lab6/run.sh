# Clear the screen only if stdout is a terminal (not redirected)
if [ -t 1 ]; then
  clear
fi

# ./lab6 < test.al
./lab6 < test.al > output.txt