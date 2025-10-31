
int foo(int x)
begin

   foo(foo(foo(foo(foo(foo(x))))));

end

int main(void)
begin

   foo(foo(foo(foo(foo(foo(256))))));

end