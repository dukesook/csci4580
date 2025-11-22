int foo(void) begin

  while 1 do
  begin

    break;

      while 0 do
        while 1 do
        begin
          break;
          continue;
        end

    continue;

  end

end

void main(void)
begin

  int x;
  int y;
  x = 0;
  y = 10;
  

  while x < 5 do
  begin
    x = x + 1;
    write x;
    continue;

    while y != 0 do
    begin
      y = y - 1;
      if x == 100 then
        begin
          break;
        end
      endif
      continue;
    end

  end

end