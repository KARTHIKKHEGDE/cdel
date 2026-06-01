#include <stdio.h>
#include <stdlib.h>

/* =============================================
 * TEST 14 — Binary Search Tree + AVL Rotation
 * BST with insert, search, delete, inorder traversal,
 * height calculation, and balance checking.
 * ============================================= */

typedef struct BSTNode {
    int data;
    struct BSTNode* left;
    struct BSTNode* right;
    int height;
} BSTNode;

BSTNode* createBSTNode(int data) {
    BSTNode* n = (BSTNode*)malloc(sizeof(BSTNode));
    n->data = data;
    n->left = n->right = NULL;
    n->height = 1;
    return n;
}

int height(BSTNode* n) { return n ? n->height : 0; }
int maxVal(int a, int b) { return a > b ? a : b; }
int getBalance(BSTNode* n) { return n ? height(n->left) - height(n->right) : 0; }

BSTNode* rightRotate(BSTNode* y) {
    BSTNode* x = y->left;
    BSTNode* T2 = x->right;
    x->right = y;
    y->left = T2;
    y->height = maxVal(height(y->left), height(y->right)) + 1;
    x->height = maxVal(height(x->left), height(x->right)) + 1;
    return x;
}

BSTNode* leftRotate(BSTNode* x) {
    BSTNode* y = x->right;
    BSTNode* T2 = y->left;
    y->left = x;
    x->right = T2;
    x->height = maxVal(height(x->left), height(x->right)) + 1;
    y->height = maxVal(height(y->left), height(y->right)) + 1;
    return y;
}

BSTNode* avlInsert(BSTNode* node, int data) {
    if (!node) return createBSTNode(data);
    if (data < node->data)      node->left  = avlInsert(node->left, data);
    else if (data > node->data) node->right = avlInsert(node->right, data);
    else return node;

    node->height = 1 + maxVal(height(node->left), height(node->right));
    int balance = getBalance(node);

    if (balance > 1 && data < node->left->data)    return rightRotate(node);
    if (balance < -1 && data > node->right->data)   return leftRotate(node);
    if (balance > 1 && data > node->left->data) {
        node->left = leftRotate(node->left);
        return rightRotate(node);
    }
    if (balance < -1 && data < node->right->data) {
        node->right = rightRotate(node->right);
        return leftRotate(node);
    }
    return node;
}

BSTNode* bstSearch(BSTNode* root, int key) {
    if (!root || root->data == key) return root;
    if (key < root->data) return bstSearch(root->left, key);
    return bstSearch(root->right, key);
}

void inorder(BSTNode* root, int* count) {
    if (!root) return;
    inorder(root->left, count);
    (*count)++;
    inorder(root->right, count);
}

int countNodes(BSTNode* root) {
    if (!root) return 0;
    return 1 + countNodes(root->left) + countNodes(root->right);
}

int isBalanced(BSTNode* root) {
    if (!root) return 1;
    int bal = getBalance(root);
    if (bal < -1 || bal > 1) return 0;
    return isBalanced(root->left) && isBalanced(root->right);
}

void freeTree(BSTNode* root) {
    if (!root) return;
    freeTree(root->left);
    freeTree(root->right);
    free(root);
}

int main() {
    BSTNode* root = NULL;

    /* Insert 100 values */
    for (int i = 0; i < 100; i++)
        root = avlInsert(root, rand() % 500);

    int count = 0;
    inorder(root, &count);
    printf("Inorder count: %d\n", count);
    printf("Node count:    %d\n", countNodes(root));
    printf("Height:        %d\n", height(root));
    printf("Balanced:      %s\n", isBalanced(root) ? "YES" : "NO");

    int searchCount = 0;
    for (int i = 0; i < 200; i++)
        if (bstSearch(root, i)) searchCount++;
    printf("Found %d / 200 searched keys\n", searchCount);

    freeTree(root);
    return 0;
}
