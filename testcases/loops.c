#include <stdio.h>

#define N 50

int matrix[N][N];

void fill(int val) {
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++) {
      matrix[i][j] = i * N + j + val;
    }
  }
}

int sum_diagonal() {
  int s = 0;
  for (int i = 0; i < N; i++) {
    s += matrix[i][i];
  }
  return s;
}

int main() {
  fill(42);
  printf("diag sum = %d\n", sum_diagonal());
  return 0;
}
