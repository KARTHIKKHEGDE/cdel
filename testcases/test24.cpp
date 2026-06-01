#include <iostream>
#include <vector>
#include <string>
#include <cstdlib>

using namespace std;

/* =============================================
 * TEST 24 — C++ Design Patterns
 * Singleton, Factory, Observer, Strategy patterns
 * in one comprehensive program.
 * ============================================= */

/* ---------- Singleton: Logger ---------- */
class Logger {
    vector<string> logs;
    int errorCount, warnCount, infoCount;
    Logger() : errorCount(0), warnCount(0), infoCount(0) {}
public:
    static Logger& instance() {
        static Logger inst;
        return inst;
    }
    void info(const string& msg) { logs.push_back("[INFO] " + msg); infoCount++; }
    void warn(const string& msg) { logs.push_back("[WARN] " + msg); warnCount++; }
    void error(const string& msg) { logs.push_back("[ERROR] " + msg); errorCount++; }
    void printAll() {
        for (auto& l : logs) cout << l << endl;
        cout << "Stats: " << infoCount << " info, " << warnCount << " warn, "
             << errorCount << " error" << endl;
    }
    int totalLogs() const { return logs.size(); }
};

/* ---------- Factory: Animal ---------- */
class Animal {
public:
    virtual void speak() const = 0;
    virtual string type() const = 0;
    virtual ~Animal() {}
};

class Dog : public Animal {
public:
    void speak() const override { cout << "Woof!" << endl; }
    string type() const override { return "Dog"; }
};

class Cat : public Animal {
public:
    void speak() const override { cout << "Meow!" << endl; }
    string type() const override { return "Cat"; }
};

class Bird : public Animal {
public:
    void speak() const override { cout << "Tweet!" << endl; }
    string type() const override { return "Bird"; }
};

class Fish : public Animal {
public:
    void speak() const override { cout << "..." << endl; }
    string type() const override { return "Fish"; }
};

class AnimalFactory {
public:
    static Animal* create(const string& type) {
        if (type == "dog") return new Dog();
        if (type == "cat") return new Cat();
        if (type == "bird") return new Bird();
        if (type == "fish") return new Fish();
        return nullptr;
    }
};

/* ---------- Observer: Event System ---------- */
class Observer {
public:
    virtual void onEvent(const string& event) = 0;
    virtual ~Observer() {}
};

class EventEmitter {
    vector<Observer*> observers;
public:
    void subscribe(Observer* obs) { observers.push_back(obs); }
    void emit(const string& event) {
        for (auto* obs : observers) obs->onEvent(event);
    }
};

class ConsoleObserver : public Observer {
    string name;
public:
    ConsoleObserver(const string& n) : name(n) {}
    void onEvent(const string& event) override {
        Logger::instance().info(name + " received: " + event);
    }
};

/* ---------- Strategy: Sorting ---------- */
class SortStrategy {
public:
    virtual void sort(vector<int>& data) = 0;
    virtual string name() const = 0;
    virtual ~SortStrategy() {}
};

class BubbleStrategy : public SortStrategy {
public:
    void sort(vector<int>& data) override {
        for (int i = 0; i < (int)data.size(); i++)
            for (int j = 0; j < (int)data.size()-i-1; j++)
                if (data[j] > data[j+1]) swap(data[j], data[j+1]);
    }
    string name() const override { return "Bubble"; }
};

class SelectionStrategy : public SortStrategy {
public:
    void sort(vector<int>& data) override {
        for (int i = 0; i < (int)data.size(); i++) {
            int min = i;
            for (int j = i+1; j < (int)data.size(); j++)
                if (data[j] < data[min]) min = j;
            swap(data[i], data[min]);
        }
    }
    string name() const override { return "Selection"; }
};

class Sorter {
    SortStrategy* strategy;
public:
    Sorter(SortStrategy* s) : strategy(s) {}
    void setStrategy(SortStrategy* s) { strategy = s; }
    void doSort(vector<int>& data) {
        Logger::instance().info("Sorting with " + strategy->name());
        strategy->sort(data);
    }
};

int main() {
    Logger& log = Logger::instance();
    log.info("Program started");

    /* Factory */
    vector<Animal*> animals;
    string types[] = {"dog","cat","bird","fish","dog","cat","bird"};
    for (auto& t : types) {
        Animal* a = AnimalFactory::create(t);
        if (a) {
            animals.push_back(a);
            log.info("Created " + a->type());
        }
    }
    for (auto* a : animals) a->speak();

    /* Observer */
    EventEmitter emitter;
    ConsoleObserver obs1("Observer-A"), obs2("Observer-B"), obs3("Observer-C");
    emitter.subscribe(&obs1);
    emitter.subscribe(&obs2);
    emitter.subscribe(&obs3);
    emitter.emit("user_login");
    emitter.emit("data_update");
    emitter.emit("shutdown");

    /* Strategy */
    vector<int> data1, data2;
    srand(42);
    for (int i = 0; i < 30; i++) { data1.push_back(rand()%100); data2.push_back(rand()%100); }

    BubbleStrategy bubble;
    SelectionStrategy selection;
    Sorter sorter(&bubble);
    sorter.doSort(data1);
    sorter.setStrategy(&selection);
    sorter.doSort(data2);

    cout << "\nFirst 10 sorted (bubble): ";
    for (int i = 0; i < 10; i++) cout << data1[i] << " ";
    cout << endl;

    log.info("Program finished");
    cout << "\n=== Full Log ===" << endl;
    log.printAll();

    for (auto* a : animals) delete a;
    return 0;
}
