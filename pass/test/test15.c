#include <stdio.h>
#include <stdlib.h>

/* =============================================
 * TEST 15 — Matrix Operations (C)
 * Matrix multiply, transpose, determinant (3x3),
 * and trace for large matrices.
 * ============================================= */

#define N 30

void matMultiply(int A[N][N], int B[N][N], int C[N][N]) {
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++) {
            C[i][j] = 0;
            for (int k = 0; k < N; k++)
                C[i][j] += A[i][k] * B[k][j];
        }
}

void matTranspose(int A[N][N], int T[N][N]) {
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            T[i][j] = A[j][i];
}

long long matTrace(int A[N][N]) {
    long long trace = 0;
    for (int i = 0; i < N; i++) trace += A[i][i];
    return trace;
}

/* 3x3 determinant helper */
int det3x3(int m[3][3]) {
    return m[0][0] * (m[1][1]*m[2][2] - m[1][2]*m[2][1])
         - m[0][1] * (m[1][0]*m[2][2] - m[1][2]*m[2][0])
         + m[0][2] * (m[1][0]*m[2][1] - m[1][1]*m[2][0]);
}

void matAdd(int A[N][N], int B[N][N], int C[N][N]) {
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            C[i][j] = A[i][j] + B[i][j];
}

void matScale(int A[N][N], int scalar, int C[N][N]) {
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            C[i][j] = A[i][j] * scalar;
}

int main() {
    int A[N][N], B[N][N], C[N][N], T[N][N], D[N][N];

    /* Initialize */
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++) {
            A[i][j] = (i + j) % 7;
            B[i][j] = (i * j + 1) % 11;
        }

    matMultiply(A, B, C);
    matTranspose(C, T);
    matAdd(C, T, D);
    matScale(D, 2, D);

    printf("Trace of C:   %lld\n", matTrace(C));
    printf("Trace of T:   %lld\n", matTrace(T));
    printf("Trace of 2*(C+T): %lld\n", matTrace(D));

    int small[3][3] = {{1,2,3},{4,5,6},{7,8,9}};
    printf("Det 3x3: %d\n", det3x3(small));

    return 0;
}
