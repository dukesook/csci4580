int my_array[1024];

void foo(int x);


void foo (int x)
begin

end


int main(void)
begin

   int num;
   num = my_array[5];
   foo(num);
   foo(my_array[5]);
   foo(5);

end