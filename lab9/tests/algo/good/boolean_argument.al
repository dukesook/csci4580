void foo(boolean box)
begin

  if (true) then
  begin
    return false;
  end
  endif
  return true;
end

void main(void)
begin

  int x;
  x = 0;

  while (x < 5) do
  begin
    x = x + 1;
    write x;
    foo(true);
    break;
  end

end