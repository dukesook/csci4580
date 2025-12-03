int size;

int fib(int x)
begin
  int sum;

  write "calling fib with x = ";
  write x;
  write "\n";

  if (x == 0) then
  begin
    return 0;
  end
  endif

  sum = fib(x-1);
  write "  value returned: ";
  write sum;
  write "\n";
  return sum + x;

end

void main(void)
begin
  int num, result;
  
  write "enter your number:\n";
  read num;

  result = fib(num);

  write "the result is: ";
  write result;
  write "\n";

end