#include <stdio.h>
#include <string.h>

/* =============================================
 * TEST 17 — Dynamic Programming Suite (C)
 * LCS, Edit Distance, 0/1 Knapsack, Coin Change,
 * Longest Increasing Subsequence.
 * ============================================= */

/* ---------- Longest Common Subsequence ---------- */
int lcs(const char* X, const char* Y) {
    int m = strlen(X), n = strlen(Y);
    int dp[m + 1][n + 1];
    for (int i = 0; i <= m; i++)
        for (int j = 0; j <= n; j++) {
            if (i == 0 || j == 0) dp[i][j] = 0;
            else if (X[i-1] == Y[j-1]) dp[i][j] = dp[i-1][j-1] + 1;
            else dp[i][j] = dp[i-1][j] > dp[i][j-1] ? dp[i-1][j] : dp[i][j-1];
        }
    return dp[m][n];
}

/* ---------- Edit Distance ---------- */
int editDistance(const char* s1, const char* s2) {
    int m = strlen(s1), n = strlen(s2);
    int dp[m + 1][n + 1];
    for (int i = 0; i <= m; i++) dp[i][0] = i;
    for (int j = 0; j <= n; j++) dp[0][j] = j;
    for (int i = 1; i <= m; i++)
        for (int j = 1; j <= n; j++) {
            if (s1[i-1] == s2[j-1]) dp[i][j] = dp[i-1][j-1];
            else {
                int ins = dp[i][j-1] + 1;
                int del = dp[i-1][j] + 1;
                int rep = dp[i-1][j-1] + 1;
                dp[i][j] = ins < del ? (ins < rep ? ins : rep) : (del < rep ? del : rep);
            }
        }
    return dp[m][n];
}

/* ---------- 0/1 Knapsack ---------- */
int knapsack(int W, int wt[], int val[], int n) {
    int dp[n + 1][W + 1];
    for (int i = 0; i <= n; i++)
        for (int w = 0; w <= W; w++) {
            if (i == 0 || w == 0) dp[i][w] = 0;
            else if (wt[i-1] <= w)
                dp[i][w] = dp[i-1][w] > (val[i-1] + dp[i-1][w - wt[i-1]])
                         ? dp[i-1][w] : (val[i-1] + dp[i-1][w - wt[i-1]]);
            else dp[i][w] = dp[i-1][w];
        }
    return dp[n][W];
}

/* ---------- Coin Change ---------- */
int coinChange(int coins[], int numCoins, int amount) {
    int dp[amount + 1];
    dp[0] = 0;
    for (int i = 1; i <= amount; i++) dp[i] = amount + 1;
    for (int i = 1; i <= amount; i++)
        for (int j = 0; j < numCoins; j++)
            if (coins[j] <= i && dp[i - coins[j]] + 1 < dp[i])
                dp[i] = dp[i - coins[j]] + 1;
    return dp[amount] > amount ? -1 : dp[amount];
}

/* ---------- Longest Increasing Subsequence ---------- */
int lis(int arr[], int n) {
    int dp[n];
    for (int i = 0; i < n; i++) dp[i] = 1;
    for (int i = 1; i < n; i++)
        for (int j = 0; j < i; j++)
            if (arr[j] < arr[i] && dp[j] + 1 > dp[i])
                dp[i] = dp[j] + 1;
    int maxLen = 0;
    for (int i = 0; i < n; i++)
        if (dp[i] > maxLen) maxLen = dp[i];
    return maxLen;
}

int main() {
    printf("LCS(\"AGGTAB\", \"GXTXAYB\"): %d\n",
           lcs("AGGTAB", "GXTXAYB"));

    printf("Edit distance(\"sunday\", \"saturday\"): %d\n",
           editDistance("sunday", "saturday"));

    int wt[] = {10, 20, 30, 40, 50};
    int val[] = {60, 100, 120, 160, 200};
    printf("Knapsack(capacity=80): %d\n", knapsack(80, wt, val, 5));

    int coins[] = {1, 5, 10, 25};
    printf("Coin change(63): %d coins\n", coinChange(coins, 4, 63));

    int arr[] = {10, 22, 9, 33, 21, 50, 41, 60, 80, 3, 15, 25, 35, 45, 55};
    printf("LIS length: %d\n", lis(arr, 15));

    return 0;
}
