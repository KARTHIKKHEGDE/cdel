#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* =============================================
 * TEST 11 — Sorting Algorithms Benchmark
 * Implements Bubble, Selection, Insertion, Merge,
 * and Quick sort, then compares their behavior.
 * ============================================= */

#define SIZE 200

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

/* ---------- Bubble Sort ---------- */
void bubbleSort(int arr[], int n) {
    for (int i = 0; i < n - 1; i++) {
        int swapped = 0;
        for (int j = 0; j < n - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                swap(&arr[j], &arr[j + 1]);
                swapped = 1;
            }
        }
        if (!swapped) break;
    }
}

/* ---------- Selection Sort ---------- */
void selectionSort(int arr[], int n) {
    for (int i = 0; i < n - 1; i++) {
        int minIdx = i;
        for (int j = i + 1; j < n; j++) {
            if (arr[j] < arr[minIdx])
                minIdx = j;
        }
        swap(&arr[minIdx], &arr[i]);
    }
}

/* ---------- Insertion Sort ---------- */
void insertionSort(int arr[], int n) {
    for (int i = 1; i < n; i++) {
        int key = arr[i];
        int j = i - 1;
        while (j >= 0 && arr[j] > key) {
            arr[j + 1] = arr[j];
            j--;
        }
        arr[j + 1] = key;
    }
}

/* ---------- Merge Sort ---------- */
void merge(int arr[], int l, int m, int r) {
    int n1 = m - l + 1;
    int n2 = r - m;
    int L[n1], R[n2];

    for (int i = 0; i < n1; i++) L[i] = arr[l + i];
    for (int j = 0; j < n2; j++) R[j] = arr[m + 1 + j];

    int i = 0, j = 0, k = l;
    while (i < n1 && j < n2) {
        if (L[i] <= R[j]) arr[k++] = L[i++];
        else              arr[k++] = R[j++];
    }
    while (i < n1) arr[k++] = L[i++];
    while (j < n2) arr[k++] = R[j++];
}

void mergeSort(int arr[], int l, int r) {
    if (l < r) {
        int m = l + (r - l) / 2;
        mergeSort(arr, l, m);
        mergeSort(arr, m + 1, r);
        merge(arr, l, m, r);
    }
}

/* ---------- Quick Sort ---------- */
int partition(int arr[], int low, int high) {
    int pivot = arr[high];
    int i = low - 1;
    for (int j = low; j <= high - 1; j++) {
        if (arr[j] < pivot) {
            i++;
            swap(&arr[i], &arr[j]);
        }
    }
    swap(&arr[i + 1], &arr[high]);
    return i + 1;
}

void quickSort(int arr[], int low, int high) {
    if (low < high) {
        int pi = partition(arr, low, high);
        quickSort(arr, low, pi - 1);
        quickSort(arr, pi + 1, high);
    }
}

/* ---------- Verification ---------- */
int isSorted(int arr[], int n) {
    for (int i = 1; i < n; i++)
        if (arr[i] < arr[i - 1]) return 0;
    return 1;
}

void fillRandom(int arr[], int n) {
    for (int i = 0; i < n; i++)
        arr[i] = rand() % 10000;
}

void copyArray(int src[], int dst[], int n) {
    memcpy(dst, src, n * sizeof(int));
}

int main() {
    int original[SIZE], working[SIZE];
    fillRandom(original, SIZE);

    copyArray(original, working, SIZE);
    bubbleSort(working, SIZE);
    printf("Bubble    : %s\n", isSorted(working, SIZE) ? "PASS" : "FAIL");

    copyArray(original, working, SIZE);
    selectionSort(working, SIZE);
    printf("Selection : %s\n", isSorted(working, SIZE) ? "PASS" : "FAIL");

    copyArray(original, working, SIZE);
    insertionSort(working, SIZE);
    printf("Insertion : %s\n", isSorted(working, SIZE) ? "PASS" : "FAIL");

    copyArray(original, working, SIZE);
    mergeSort(working, 0, SIZE - 1);
    printf("Merge     : %s\n", isSorted(working, SIZE) ? "PASS" : "FAIL");

    copyArray(original, working, SIZE);
    quickSort(working, 0, SIZE - 1);
    printf("Quick     : %s\n", isSorted(working, SIZE) ? "PASS" : "FAIL");

    return 0;
}
