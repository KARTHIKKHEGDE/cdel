#include <stdio.h>
#include <stdlib.h>

/* =============================================
 * TEST 12 — Linked List Operations
 * Singly linked list with insert, delete, reverse,
 * detect cycle, merge two sorted lists.
 * ============================================= */

typedef struct Node {
    int data;
    struct Node* next;
} Node;

Node* createNode(int data) {
    Node* n = (Node*)malloc(sizeof(Node));
    n->data = data;
    n->next = NULL;
    return n;
}

void insertFront(Node** head, int data) {
    Node* n = createNode(data);
    n->next = *head;
    *head = n;
}

void insertEnd(Node** head, int data) {
    Node* n = createNode(data);
    if (*head == NULL) { *head = n; return; }
    Node* cur = *head;
    while (cur->next) cur = cur->next;
    cur->next = n;
}

void deleteNode(Node** head, int key) {
    Node* cur = *head;
    Node* prev = NULL;
    while (cur && cur->data != key) {
        prev = cur;
        cur = cur->next;
    }
    if (!cur) return;
    if (!prev) *head = cur->next;
    else prev->next = cur->next;
    free(cur);
}

Node* reverseList(Node* head) {
    Node *prev = NULL, *cur = head, *next = NULL;
    while (cur) {
        next = cur->next;
        cur->next = prev;
        prev = cur;
        cur = next;
    }
    return prev;
}

int hasCycle(Node* head) {
    Node *slow = head, *fast = head;
    while (fast && fast->next) {
        slow = slow->next;
        fast = fast->next->next;
        if (slow == fast) return 1;
    }
    return 0;
}

Node* mergeSorted(Node* a, Node* b) {
    Node dummy;
    dummy.next = NULL;
    Node* tail = &dummy;
    while (a && b) {
        if (a->data <= b->data) { tail->next = a; a = a->next; }
        else                    { tail->next = b; b = b->next; }
        tail = tail->next;
    }
    tail->next = a ? a : b;
    return dummy.next;
}

int listLength(Node* head) {
    int len = 0;
    while (head) { len++; head = head->next; }
    return len;
}

void printList(Node* head) {
    while (head) {
        printf("%d -> ", head->data);
        head = head->next;
    }
    printf("NULL\n");
}

void freeList(Node* head) {
    while (head) {
        Node* tmp = head;
        head = head->next;
        free(tmp);
    }
}

int main() {
    /* Build list 1 */
    Node* list1 = NULL;
    for (int i = 0; i < 20; i++) insertEnd(&list1, i * 2);

    /* Build list 2 */
    Node* list2 = NULL;
    for (int i = 0; i < 15; i++) insertEnd(&list2, i * 3 + 1);

    printf("List 1 length: %d\n", listLength(list1));
    printf("List 2 length: %d\n", listLength(list2));

    /* Reverse list 1 */
    list1 = reverseList(list1);
    list1 = reverseList(list1); /* back to original order */

    /* Delete some nodes */
    deleteNode(&list1, 0);
    deleteNode(&list1, 10);
    deleteNode(&list1, 38);

    printf("List 1 after deletes, length: %d\n", listLength(list1));
    printf("Cycle in list 1? %s\n", hasCycle(list1) ? "YES" : "NO");

    /* Merge two sorted lists */
    Node* merged = mergeSorted(list1, list2);
    printf("Merged length: %d\n", listLength(merged));

    freeList(merged);
    return 0;
}
