#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <algorithm>
#include <functional>

using namespace std;

/* =============================================
 * TEST 23 — C++ Template Metaprogramming
 * Stack, Queue from scratch, template specialization,
 * function objects, lambda expressions, iterators.
 * ============================================= */

template<typename T, int CAPACITY = 100>
class Stack {
    T data[CAPACITY];
    int top;
public:
    Stack() : top(-1) {}
    bool empty() const { return top == -1; }
    bool full() const { return top == CAPACITY - 1; }
    void push(const T& val) { if (!full()) data[++top] = val; }
    T pop() { return data[top--]; }
    T peek() const { return data[top]; }
    int size() const { return top + 1; }
};

template<typename T, int CAPACITY = 100>
class Queue {
    T data[CAPACITY];
    int front, rear, count;
public:
    Queue() : front(0), rear(-1), count(0) {}
    bool empty() const { return count == 0; }
    bool full() const { return count == CAPACITY; }
    void enqueue(const T& val) {
        if (!full()) { rear = (rear + 1) % CAPACITY; data[rear] = val; count++; }
    }
    T dequeue() { T val = data[front]; front = (front+1) % CAPACITY; count--; return val; }
    T peek() const { return data[front]; }
    int size() const { return count; }
};

/* --- Balanced parentheses checker --- */
bool isBalanced(const string& expr) {
    Stack<char> s;
    for (char c : expr) {
        if (c == '(' || c == '[' || c == '{') s.push(c);
        else if (c == ')' || c == ']' || c == '}') {
            if (s.empty()) return false;
            char top = s.pop();
            if (c == ')' && top != '(') return false;
            if (c == ']' && top != '[') return false;
            if (c == '}' && top != '{') return false;
        }
    }
    return s.empty();
}

/* --- Infix to Postfix converter --- */
int precedence(char op) {
    if (op == '+' || op == '-') return 1;
    if (op == '*' || op == '/') return 2;
    return 0;
}

string infixToPostfix(const string& expr) {
    Stack<char> ops;
    string result;
    for (char c : expr) {
        if (isalnum(c)) result += c;
        else if (c == '(') ops.push(c);
        else if (c == ')') {
            while (!ops.empty() && ops.peek() != '(') result += ops.pop();
            if (!ops.empty()) ops.pop();
        } else {
            while (!ops.empty() && precedence(ops.peek()) >= precedence(c))
                result += ops.pop();
            ops.push(c);
        }
    }
    while (!ops.empty()) result += ops.pop();
    return result;
}

/* --- Function object --- */
template<typename T>
struct Accumulator {
    T total;
    Accumulator() : total(0) {}
    void operator()(T val) { total += val; }
};

int main() {
    /* Stack tests */
    Stack<int> intStack;
    for (int i = 0; i < 50; i++) intStack.push(i * i);
    int stackSum = 0;
    while (!intStack.empty()) stackSum += intStack.pop();
    cout << "Stack sum of squares: " << stackSum << endl;

    /* Queue tests */
    Queue<int> q;
    for (int i = 0; i < 30; i++) q.enqueue(i * 3);
    int queueSum = 0;
    while (!q.empty()) queueSum += q.dequeue();
    cout << "Queue sum: " << queueSum << endl;

    /* Balanced parentheses */
    cout << "({[]}) balanced: " << (isBalanced("({[]})") ? "YES" : "NO") << endl;
    cout << "([)] balanced: " << (isBalanced("([)]") ? "YES" : "NO") << endl;
    cout << "{[()()]} balanced: " << (isBalanced("{[()()]}") ? "YES" : "NO") << endl;

    /* Infix to postfix */
    cout << "a+b*c postfix: " << infixToPostfix("a+b*c") << endl;
    cout << "(a+b)*c postfix: " << infixToPostfix("(a+b)*c") << endl;
    cout << "a*(b+c)-d postfix: " << infixToPostfix("a*(b+c)-d") << endl;

    /* Function object */
    Accumulator<double> acc;
    vector<double> vals = {1.1, 2.2, 3.3, 4.4, 5.5, 6.6, 7.7, 8.8, 9.9};
    for (double v : vals) acc(v);
    cout << "Accumulator total: " << acc.total << endl;

    /* Lambda with map */
    map<string, int> wordFreq;
    vector<string> words = {"the","quick","brown","fox","the","fox","the","brown"};
    for (auto& w : words) wordFreq[w]++;
    cout << "Word frequencies:" << endl;
    for_each(wordFreq.begin(), wordFreq.end(),
             [](const pair<string,int>& p) {
                 cout << "  " << p.first << ": " << p.second << endl;
             });

    return 0;
}
