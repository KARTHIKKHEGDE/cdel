#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <queue>

using namespace std;

/* =============================================
 * TEST 19 — C++ STL-heavy: Priority Queue Scheduler
 * Simulates a task scheduler with priority queues,
 * multiple data structures, exception handling.
 * ============================================= */

struct Task {
    int id;
    int priority;
    string name;
    int burstTime;
    int waitTime;

    bool operator<(const Task& other) const {
        return priority < other.priority;  // max-heap by priority
    }
};

class Scheduler {
    priority_queue<Task> readyQueue;
    vector<Task> completed;
    int clock;
    int totalTasks;

public:
    Scheduler() : clock(0), totalTasks(0) {}

    void addTask(const string& name, int priority, int burst) {
        Task t;
        t.id = ++totalTasks;
        t.priority = priority;
        t.name = name;
        t.burstTime = burst;
        t.waitTime = 0;
        readyQueue.push(t);
    }

    void runAll() {
        while (!readyQueue.empty()) {
            Task t = readyQueue.top();
            readyQueue.pop();
            t.waitTime = clock;
            clock += t.burstTime;
            completed.push_back(t);
        }
    }

    double avgWaitTime() const {
        if (completed.empty()) return 0;
        double total = 0;
        for (const auto& t : completed) total += t.waitTime;
        return total / completed.size();
    }

    double avgTurnaround() const {
        if (completed.empty()) return 0;
        double total = 0;
        for (const auto& t : completed) total += t.waitTime + t.burstTime;
        return total / completed.size();
    }

    int totalTime() const { return clock; }

    void printStats() const {
        cout << "=== Scheduler Stats ===" << endl;
        cout << "Total tasks: " << completed.size() << endl;
        cout << "Total clock time: " << totalTime() << endl;
        cout << "Avg wait time: " << avgWaitTime() << endl;
        cout << "Avg turnaround: " << avgTurnaround() << endl;
        cout << "\nCompleted tasks (order):" << endl;
        for (const auto& t : completed) {
            cout << "  [" << t.id << "] " << t.name
                 << " | prio=" << t.priority
                 << " | burst=" << t.burstTime
                 << " | wait=" << t.waitTime << endl;
        }
    }
};

/* ---------- Template statistics ---------- */
template<typename T>
class Stats {
    vector<T> data;
public:
    void add(T val) { data.push_back(val); }

    T sum() const {
        T s = 0;
        for (auto v : data) s += v;
        return s;
    }
    double mean() const { return (double)sum() / data.size(); }
    T minVal() const { return *min_element(data.begin(), data.end()); }
    T maxVal() const { return *max_element(data.begin(), data.end()); }
    T range() const { return maxVal() - minVal(); }
};

int main() {
    Scheduler sched;

    sched.addTask("Compile", 10, 50);
    sched.addTask("LinkEdit", 8, 30);
    sched.addTask("UnitTest", 9, 40);
    sched.addTask("Deploy", 7, 20);
    sched.addTask("Monitor", 3, 10);
    sched.addTask("Backup", 5, 25);
    sched.addTask("Cleanup", 2, 5);
    sched.addTask("Analytics", 6, 35);
    sched.addTask("Indexing", 4, 15);
    sched.addTask("Notify", 1, 8);
    sched.addTask("Archive", 8, 22);
    sched.addTask("Validate", 9, 18);
    sched.addTask("Transform", 7, 28);
    sched.addTask("Encrypt", 6, 12);
    sched.addTask("Sync", 5, 16);

    sched.runAll();
    sched.printStats();

    Stats<int> burstStats;
    int bursts[] = {50,30,40,20,10,25,5,35,15,8,22,18,28,12,16};
    for (int b : bursts) burstStats.add(b);

    cout << "\nBurst time stats:" << endl;
    cout << "  Sum: " << burstStats.sum() << endl;
    cout << "  Mean: " << burstStats.mean() << endl;
    cout << "  Min: " << burstStats.minVal() << endl;
    cout << "  Max: " << burstStats.maxVal() << endl;
    cout << "  Range: " << burstStats.range() << endl;

    return 0;
}
