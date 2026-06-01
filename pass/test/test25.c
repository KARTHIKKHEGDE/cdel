#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* =============================================
 * TEST 25 — Comprehensive C: File-like Buffer I/O
 * Ring buffer, stack machine (mini VM), bit
 * manipulation utilities, and CRC-like checksum.
 * ============================================= */

/* ---------- Ring Buffer ---------- */
#define RING_SIZE 64

typedef struct {
    int buf[RING_SIZE];
    int head, tail, count;
} RingBuffer;

void rbInit(RingBuffer* rb) { rb->head = rb->tail = rb->count = 0; }
int rbEmpty(RingBuffer* rb) { return rb->count == 0; }
int rbFull(RingBuffer* rb) { return rb->count == RING_SIZE; }

int rbPush(RingBuffer* rb, int val) {
    if (rbFull(rb)) return 0;
    rb->buf[rb->tail] = val;
    rb->tail = (rb->tail + 1) % RING_SIZE;
    rb->count++;
    return 1;
}

int rbPop(RingBuffer* rb, int* val) {
    if (rbEmpty(rb)) return 0;
    *val = rb->buf[rb->head];
    rb->head = (rb->head + 1) % RING_SIZE;
    rb->count--;
    return 1;
}

/* ---------- Mini Stack VM ---------- */
#define VM_STACK 128

typedef struct {
    int stack[VM_STACK];
    int sp;
} StackVM;

void vmInit(StackVM* vm) { vm->sp = -1; }
void vmPush(StackVM* vm, int val) { vm->stack[++vm->sp] = val; }
int vmPop(StackVM* vm) { return vm->stack[vm->sp--]; }

enum { OP_PUSH, OP_ADD, OP_SUB, OP_MUL, OP_DUP, OP_SWAP, OP_PRINT, OP_HALT };

void vmExecute(StackVM* vm, int program[], int len) {
    int pc = 0;
    while (pc < len) {
        switch (program[pc]) {
        case OP_PUSH: vmPush(vm, program[++pc]); break;
        case OP_ADD: { int b = vmPop(vm), a = vmPop(vm); vmPush(vm, a+b); break; }
        case OP_SUB: { int b = vmPop(vm), a = vmPop(vm); vmPush(vm, a-b); break; }
        case OP_MUL: { int b = vmPop(vm), a = vmPop(vm); vmPush(vm, a*b); break; }
        case OP_DUP: { int a = vmPop(vm); vmPush(vm, a); vmPush(vm, a); break; }
        case OP_SWAP: {
            int b = vmPop(vm), a = vmPop(vm);
            vmPush(vm, b); vmPush(vm, a); break;
        }
        case OP_PRINT: printf("VM> %d\n", vm->stack[vm->sp]); break;
        case OP_HALT: return;
        }
        pc++;
    }
}

/* ---------- Bit Manipulation ---------- */
int countSetBits(unsigned int n) {
    int count = 0;
    while (n) { count += n & 1; n >>= 1; }
    return count;
}

int isPowerOfTwo(unsigned int n) { return n && !(n & (n-1)); }
unsigned int reverseBits(unsigned int n) {
    unsigned int result = 0;
    for (int i = 0; i < 32; i++) {
        result = (result << 1) | (n & 1);
        n >>= 1;
    }
    return result;
}

/* ---------- CRC-like Checksum ---------- */
unsigned int simpleChecksum(const char* data, int len) {
    unsigned int crc = 0xFFFFFFFF;
    for (int i = 0; i < len; i++) {
        crc ^= (unsigned char)data[i];
        for (int j = 0; j < 8; j++) {
            if (crc & 1) crc = (crc >> 1) ^ 0xEDB88320;
            else crc >>= 1;
        }
    }
    return ~crc;
}

int main() {
    /* Ring Buffer */
    RingBuffer rb;
    rbInit(&rb);
    for (int i = 0; i < 50; i++) rbPush(&rb, i * 7);
    int sum = 0, val;
    while (rbPop(&rb, &val)) sum += val;
    printf("Ring buffer sum: %d\n", sum);

    /* Stack VM: compute (3 + 4) * (10 - 2) = 56 */
    StackVM vm;
    vmInit(&vm);
    int program[] = {
        OP_PUSH, 3, OP_PUSH, 4, OP_ADD,
        OP_PUSH, 10, OP_PUSH, 2, OP_SUB,
        OP_MUL, OP_PRINT, OP_HALT
    };
    vmExecute(&vm, program, sizeof(program)/sizeof(int));

    /* Bit manipulation */
    printf("Set bits in 255: %d\n", countSetBits(255));
    printf("Set bits in 1023: %d\n", countSetBits(1023));
    printf("Is 64 power of 2: %s\n", isPowerOfTwo(64) ? "YES" : "NO");
    printf("Is 65 power of 2: %s\n", isPowerOfTwo(65) ? "YES" : "NO");

    /* Checksum */
    const char* msg1 = "Hello, World!";
    const char* msg2 = "Hello, World?";
    printf("Checksum '%s': %08X\n", msg1, simpleChecksum(msg1, strlen(msg1)));
    printf("Checksum '%s': %08X\n", msg2, simpleChecksum(msg2, strlen(msg2)));

    return 0;
}
