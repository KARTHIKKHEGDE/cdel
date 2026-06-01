#include <math.h>
#include <stdio.h>

double hypotenuse(double a, double b) {
  return sqrt(a * a + b * b);
}

int factorial(int n) {
  if (n <= 1) {
    return 1;
  }
  return n * factorial(n - 1);
}

int fib(int n) {
  if (n <= 1) {
    return n;
  }
  return fib(n - 1) + fib(n - 2);
}

int main() {
  printf("hyp = %.2f\n", hypotenuse(3.0, 4.0));
  printf("10! = %d\n", factorial(10));
  printf("fib(10) = %d\n", fib(10));
  return 0;
}
