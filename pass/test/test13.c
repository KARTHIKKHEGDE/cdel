#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* =============================================
 * TEST 13 — Hash Table (Open Addressing)
 * Hash table with linear probing, insert, search,
 * delete, rehash, and collision statistics.
 * ============================================= */

#define TABLE_SIZE 128

typedef struct {
    int key;
    int value;
    int occupied;
    int deleted;
} Entry;

typedef struct {
    Entry entries[TABLE_SIZE];
    int count;
    int collisions;
} HashTable;

void htInit(HashTable* ht) {
    memset(ht->entries, 0, sizeof(ht->entries));
    ht->count = 0;
    ht->collisions = 0;
}

int hashFunc(int key) {
    unsigned int h = (unsigned int)key;
    h = ((h >> 16) ^ h) * 0x45d9f3b;
    h = ((h >> 16) ^ h) * 0x45d9f3b;
    h = (h >> 16) ^ h;
    return (int)(h % TABLE_SIZE);
}

int htInsert(HashTable* ht, int key, int value) {
    if (ht->count >= TABLE_SIZE * 3 / 4) return 0; /* load factor limit */
    int idx = hashFunc(key);
    int start = idx;
    while (ht->entries[idx].occupied && !ht->entries[idx].deleted) {
        if (ht->entries[idx].key == key) {
            ht->entries[idx].value = value; /* update */
            return 1;
        }
        ht->collisions++;
        idx = (idx + 1) % TABLE_SIZE;
        if (idx == start) return 0;
    }
    ht->entries[idx].key = key;
    ht->entries[idx].value = value;
    ht->entries[idx].occupied = 1;
    ht->entries[idx].deleted = 0;
    ht->count++;
    return 1;
}

int htSearch(HashTable* ht, int key, int* value) {
    int idx = hashFunc(key);
    int start = idx;
    while (ht->entries[idx].occupied) {
        if (!ht->entries[idx].deleted && ht->entries[idx].key == key) {
            *value = ht->entries[idx].value;
            return 1;
        }
        idx = (idx + 1) % TABLE_SIZE;
        if (idx == start) break;
    }
    return 0;
}

int htDelete(HashTable* ht, int key) {
    int idx = hashFunc(key);
    int start = idx;
    while (ht->entries[idx].occupied) {
        if (!ht->entries[idx].deleted && ht->entries[idx].key == key) {
            ht->entries[idx].deleted = 1;
            ht->count--;
            return 1;
        }
        idx = (idx + 1) % TABLE_SIZE;
        if (idx == start) break;
    }
    return 0;
}

void htStats(HashTable* ht) {
    int occupied = 0, deleted = 0;
    for (int i = 0; i < TABLE_SIZE; i++) {
        if (ht->entries[i].occupied) occupied++;
        if (ht->entries[i].deleted)  deleted++;
    }
    printf("Count: %d, Occupied slots: %d, Deleted: %d, Collisions: %d\n",
           ht->count, occupied, deleted, ht->collisions);
}

int main() {
    HashTable ht;
    htInit(&ht);

    /* Insert 80 items */
    for (int i = 0; i < 80; i++)
        htInsert(&ht, i * 7 + 3, i * 100);

    printf("After 80 inserts:\n");
    htStats(&ht);

    /* Search for some keys */
    int found = 0, val;
    for (int i = 0; i < 80; i++) {
        if (htSearch(&ht, i * 7 + 3, &val)) found++;
    }
    printf("Found %d / 80 keys\n", found);

    /* Delete every other key */
    for (int i = 0; i < 80; i += 2)
        htDelete(&ht, i * 7 + 3);

    printf("After deleting 40 keys:\n");
    htStats(&ht);

    return 0;
}
