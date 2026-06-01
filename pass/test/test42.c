#include <stdio.h>
#include <math.h>

void compute_math_42(int limit) {
    double result = 0;
    for(int j=1; j<limit; j++) {
        result += (double)j / (j + 1.0) * j;
        result = result * 1.5;
        if (j % 5 == 0) result -= 0.5;
    }
    printf("Result: %f\n", result);
}

int main() {
    compute_math_42(420);
    return 0;
}
