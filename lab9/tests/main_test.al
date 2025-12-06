
int printArray(int x[], int size)
begin
  int i;
  i = 0;

  while (i < size) do
  begin
    write i;
    write ". ";
    write x[i];
    write "\n";
    i = i + 1;
  end

end

int fib(int x)
begin
  int sum;

  if (x == 0) then
  begin
    return 0;
  end
  endif

  sum = fib(x-1);
  write sum;
  write " \n";
  return sum + x;

end

void testExpression(void)
begin
  int x;
  write "\n===Testing expression===\n";
  write "x = 4 + 10 - 6 * 3 / 2: \n  ";
  x = 4 + 10 - 6 * 3 / 2;
  write "x: ";
  write x;
  write "\n";
end

void testIf(void)
begin
  int x;
  x = 5;
  write "\n===Testing if===\n";
  write "if x == 5, write 'five', else write 'not five!'\n";
  if x == 5 then
    begin
      write "five!\n";
    end
  else
    begin
      write "not five!";
    end
  endif
end

void testMethodCalls(void)
begin
  int result;

  write "\n===Testing Method Calls===\n";
  write "Print the fibinachi sequence for 7\n";

  
  result = fib(7);

  write "the result is: ";
  write result;
  write "\n";

end

void testArray(void)
begin
  int nums[10];
  int size;

  nums[0] = 100;
  nums[1] = 200;
  nums[2] = 300;
  nums[3] = 400;
  nums[4] = 500;
  nums[5] = 600;
  nums[6] = 700;
  nums[7] = 800;
  nums[8] = 900;
  nums[9] = 1000;

  write "\n===Testing Array Passing===\n";
  write "call printArray() on int nums[10]:\n";
  size = 10;
  printArray(nums, size);
end

void testWhile(void)
begin
  int x;
  x = 0;
  write "\n===Testing while===\n";
  write "while (x <= 10), x++:\n ";
  while (x <= 10) do
  begin
    write x;
    write " ";
    x = x + 1;
  end
  write "\n";
end

void testBreakContinue(void)
begin
  int x;
  x = 0;

  write "\n===Testing break and continue===\n";
  write "while true, if x > 10 then continue, else break\n";
  while true do
  begin

    write "  x is: ";
    write x;

    if x <= 10 then
      begin
        write ", continue!\n";
        x = x + 1;
        continue;
        write "ERROR! AFTER CONTINUE";
      end
    else
      begin
        write ", x is greater than 10, break!\n";
        break;
      end
    endif;
  end
  write "broke out of while(true)";

end

int main(int x)
begin

  testExpression();
  testIf();
  testWhile();
  testArray();
  testMethodCalls();
  testBreakContinue();


end