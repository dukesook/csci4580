boolean Y[10], y;

boolean foo(boolean mybool);

boolean main(boolean z, boolean Z[])
begin
  boolean x, X[50];

  foo(x);
  foo(X[1]);
  foo(z);
  foo(Z[2]);
  foo(y);
  foo(Y[20]);

  x = x < x;
  x = x > x;
  x = x <= x;
  x = x >= x;
  x = x == x;
  x = x != x;
  x = x and x;
  x = x or x;

  X[10] = X[10] < X[10];
  X[10] = X[10] > X[10];
  X[10] = X[10] <= X[10];
  X[10] = X[10] >= X[10];
  X[10] = X[10] == X[10];
  X[10] = X[10] != X[10];
  X[10] = X[10] and X[10];
  X[10] = X[10] or X[10];

  z = z < z;
  z = z > z;
  z = z <= z;
  z = z >= z;
  z = z == z;
  z = z != z;
  z = z and z;
  z = z or z;

  Z[5] = Z[5] < Z[5];
  Z[5] = Z[5] > Z[5];
  Z[5] = Z[5] <= Z[5];
  Z[5] = Z[5] >= Z[5];
  Z[5] = Z[5] == Z[5];
  Z[5] = Z[5] != Z[5];
  Z[5] = Z[5] and Z[5];
  Z[5] = Z[5] or Z[5];

  y = y < y;
  y = y > y;
  y = y <= y;
  y = y >= y;
  y = y == y;
  y = y != y;
  y = y and y;
  y = y or y;

  Y[7] = Y[7] < Y[7];
  Y[7] = Y[7] > Y[7];
  Y[7] = Y[7] <= Y[7];
  Y[7] = Y[7] >= Y[7];
  Y[7] = Y[7] == Y[7];
  Y[7] = Y[7] != Y[7];
  Y[7] = Y[7] and Y[7];
  Y[7] = Y[7] or Y[7];

end


boolean foo(boolean mybool)
begin

end
