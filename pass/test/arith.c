#include <stdio.h>

int multiply(int a, int b) {
  return a * b;
}

int divide(int a, int b) {
  if (b == 0) {
    return 0;
  }
  return a / b;
}

int main() {
  int x = 10;
  int y = 3;
  int m = multiply(x, y);
  int d = divide(x, y);
  int sum = 0;

  for (int i = 0; i < 100; i++) {
    sum += i * i;
  }

  printf("m=%d d=%d sum=%d\n", m, d, sum);
  return 0;
}
