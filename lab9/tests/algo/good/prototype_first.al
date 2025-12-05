int g[5];

void foo(int a1[], int a2);

int main(void)
begin

  int arr[50];
  foo(arr, 4);


end

void foo(int a1[], int a2)
begin

  foo(a1, a1[5]);
  foo(g, a2);

end