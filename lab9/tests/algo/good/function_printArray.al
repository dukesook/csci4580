int size;

int printArray(int x[], int size)
begin
  int i;
  i = 0;

  while (i < size) do
  begin
    write i;
    write "\n";
    i = i + 1;
  end

end

void main(void)
begin
  int nums[10];
  size = 10;

  printArray(nums, size);


end