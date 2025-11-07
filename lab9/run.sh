clear
clear

make && ./lab9 -o out.asm < test.al

echo ""
echo ""
echo "Running MARS with out.asm"

java -jar Mars4_5.jar sm out.asm
