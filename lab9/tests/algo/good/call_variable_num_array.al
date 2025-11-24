int myArray[1024];

void foo(int x);


void foo (int x)
begin

end


int main(void)
begin

   int num;
   num = myArray[5];
   foo(num);
   foo(myArray[5]);
   foo(5);

end