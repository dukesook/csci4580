int foo(int x)
begin

  foo(foo(foo(foo(foo(x)))));

end

int main(int y)
begin

  foo(main(foo(main(y))));

end


