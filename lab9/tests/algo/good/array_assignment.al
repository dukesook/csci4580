int x[100];
int g;

void main(void)
begin
  int y[20];
  int z;
  x[0] = 1;
  x[18] = 2;
  x[1] = x[2];
  x[2] = y[20];
  x[3] = z;
  x[4] = g;
  z = x[5];

  y[0] = 1;
  y[18] = 2;
  y[1] = x[2];
  y[2] = y[20];
  y[3] = z;
  y[4] = g;
  z = y[5];


end