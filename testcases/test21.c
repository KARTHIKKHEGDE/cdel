#include <stdio.h>
#include <string.h>
#include <ctype.h>

/* =============================================
 * TEST 21 — String Processing & Parsing (C)
 * String reversal, palindrome check, word count,
 * Caesar cipher, run-length encoding, Atoi.
 * ============================================= */

void reverseStr(char* s) {
    int n = strlen(s);
    for (int i = 0; i < n / 2; i++) {
        char t = s[i]; s[i] = s[n-1-i]; s[n-1-i] = t;
    }
}

int isPalindrome(const char* s) {
    int n = strlen(s);
    for (int i = 0; i < n / 2; i++)
        if (tolower(s[i]) != tolower(s[n-1-i])) return 0;
    return 1;
}

int wordCount(const char* s) {
    int count = 0, inWord = 0;
    while (*s) {
        if (isspace(*s)) { inWord = 0; }
        else if (!inWord) { inWord = 1; count++; }
        s++;
    }
    return count;
}

void caesarEncrypt(char* s, int shift) {
    for (int i = 0; s[i]; i++) {
        if (isupper(s[i])) s[i] = 'A' + (s[i] - 'A' + shift) % 26;
        else if (islower(s[i])) s[i] = 'a' + (s[i] - 'a' + shift) % 26;
    }
}

void caesarDecrypt(char* s, int shift) {
    caesarEncrypt(s, 26 - shift);
}

int rleEncode(const char* input, char* output) {
    int outLen = 0;
    int n = strlen(input);
    for (int i = 0; i < n; ) {
        char c = input[i];
        int count = 1;
        while (i + count < n && input[i + count] == c) count++;
        if (count > 1) outLen += sprintf(output + outLen, "%d%c", count, c);
        else output[outLen++] = c;
        i += count;
    }
    output[outLen] = '\0';
    return outLen;
}

int myAtoi(const char* s) {
    int result = 0, sign = 1, i = 0;
    while (s[i] == ' ') i++;
    if (s[i] == '-') { sign = -1; i++; }
    else if (s[i] == '+') i++;
    while (s[i] >= '0' && s[i] <= '9') {
        result = result * 10 + (s[i] - '0');
        i++;
    }
    return sign * result;
}

int strCompareIgnoreCase(const char* a, const char* b) {
    while (*a && *b) {
        if (tolower(*a) != tolower(*b)) return tolower(*a) - tolower(*b);
        a++; b++;
    }
    return *a - *b;
}

int main() {
    char buf[256];

    strcpy(buf, "Hello World");
    reverseStr(buf);
    printf("Reversed: %s\n", buf);

    printf("racecar palindrome: %s\n", isPalindrome("racecar") ? "YES" : "NO");
    printf("hello palindrome: %s\n", isPalindrome("hello") ? "YES" : "NO");

    printf("Word count 'The quick brown fox': %d\n",
           wordCount("The quick brown fox jumps over the lazy dog"));

    strcpy(buf, "AttackAtDawn");
    caesarEncrypt(buf, 3);
    printf("Caesar encrypt: %s\n", buf);
    caesarDecrypt(buf, 3);
    printf("Caesar decrypt: %s\n", buf);

    char encoded[256];
    rleEncode("aaabbbccddddeeee", encoded);
    printf("RLE encode: %s\n", encoded);

    printf("Atoi('  -42abc'): %d\n", myAtoi("  -42abc"));
    printf("Atoi('12345'): %d\n", myAtoi("12345"));

    printf("Compare 'Hello' vs 'hello': %d\n",
           strCompareIgnoreCase("Hello", "hello"));

    return 0;
}
