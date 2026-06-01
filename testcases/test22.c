#include <stdio.h>
#include <stdlib.h>

/* =============================================
 * TEST 22 — Heap (Min-Heap) + Heap Sort (C)
 * Min-heap with insert, extractMin, heapify,
 * decrease key, and full heap sort.
 * ============================================= */

#define MAX_HEAP 256

typedef struct {
    int arr[MAX_HEAP];
    int size;
} MinHeap;

void heapInit(MinHeap* h) { h->size = 0; }

void heapSwap(int* a, int* b) { int t = *a; *a = *b; *b = t; }

void siftUp(MinHeap* h, int i) {
    while (i > 0) {
        int parent = (i - 1) / 2;
        if (h->arr[parent] > h->arr[i]) {
            heapSwap(&h->arr[parent], &h->arr[i]);
            i = parent;
        } else break;
    }
}

void siftDown(MinHeap* h, int i) {
    while (2 * i + 1 < h->size) {
        int smallest = i;
        int l = 2 * i + 1, r = 2 * i + 2;
        if (l < h->size && h->arr[l] < h->arr[smallest]) smallest = l;
        if (r < h->size && h->arr[r] < h->arr[smallest]) smallest = r;
        if (smallest != i) {
            heapSwap(&h->arr[i], &h->arr[smallest]);
            i = smallest;
        } else break;
    }
}

void heapInsert(MinHeap* h, int val) {
    h->arr[h->size] = val;
    siftUp(h, h->size);
    h->size++;
}

int heapExtractMin(MinHeap* h) {
    int min = h->arr[0];
    h->size--;
    h->arr[0] = h->arr[h->size];
    siftDown(h, 0);
    return min;
}

int heapPeek(MinHeap* h) { return h->arr[0]; }

/* ---------- Heap Sort ---------- */
void heapSort(int arr[], int n) {
    /* Build max heap */
    for (int i = n / 2 - 1; i >= 0; i--) {
        int j = i;
        while (1) {
            int largest = j;
            int l = 2*j+1, r = 2*j+2;
            if (l < n && arr[l] > arr[largest]) largest = l;
            if (r < n && arr[r] > arr[largest]) largest = r;
            if (largest != j) {
                int t = arr[j]; arr[j] = arr[largest]; arr[largest] = t;
                j = largest;
            } else break;
        }
    }
    /* Extract elements */
    for (int i = n - 1; i > 0; i--) {
        int t = arr[0]; arr[0] = arr[i]; arr[i] = t;
        int j = 0, sz = i;
        while (1) {
            int largest = j;
            int l = 2*j+1, r = 2*j+2;
            if (l < sz && arr[l] > arr[largest]) largest = l;
            if (r < sz && arr[r] > arr[largest]) largest = r;
            if (largest != j) {
                int t2 = arr[j]; arr[j] = arr[largest]; arr[largest] = t2;
                j = largest;
            } else break;
        }
    }
}

int main() {
    MinHeap h;
    heapInit(&h);

    srand(99);
    for (int i = 0; i < 100; i++)
        heapInsert(&h, rand() % 1000);

    printf("Heap size: %d\n", h.size);
    printf("Min element: %d\n", heapPeek(&h));

    int prev = -1, sorted = 1;
    while (h.size > 0) {
        int val = heapExtractMin(&h);
        if (val < prev) sorted = 0;
        prev = val;
    }
    printf("Extracted in sorted order: %s\n", sorted ? "YES" : "NO");

    /* Heap sort on array */
    int arr[80];
    for (int i = 0; i < 80; i++) arr[i] = rand() % 500;
    heapSort(arr, 80);

    int isSorted = 1;
    for (int i = 1; i < 80; i++)
        if (arr[i] < arr[i-1]) { isSorted = 0; break; }
    printf("Heap sort result: %s\n", isSorted ? "PASS" : "FAIL");

    return 0;
}
