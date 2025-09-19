make clean
make
mkdir -p tests_output

echo "Running tests..."

echo "  Running Test 1: lab5goodtest.al..."
./lab5 < tests/lab5goodtest.al > tests_output/lab5goodtest_output.txt

echo "  Running Test 2: lab5goodtestwithproto.al..."
./lab5 < tests/lab5goodtestwithproto.al > tests_output/lab5goodtestwithproto_output.txt

echo "  Running Test 3: lab5badtest.al..."
./lab5 < tests/lab5badtest.al > tests_output/lab5badtest_output.txt

echo "Tests complete! See tests_output/"
