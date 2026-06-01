#include <iostream>
#include <stdexcept>
#include <string>

class Object_29 {
public:
    virtual void doWork(int val) {
        if (val % 2 == 0) throw std::runtime_error("Even number exception");
        std::cout << "Working: " << val << std::endl;
    }
};

class Child_29 : public Object_29 {
public:
    void doWork(int val) override {
        if (val % 3 == 0) throw std::invalid_argument("Div by 3 exception");
        Object_29::doWork(val);
    }
};

int main() {
    Child_29 c;
    for(int j=1; j<20; j++) {
        try {
            c.doWork(j);
        } catch(const std::exception& e) {
            std::cerr << "Caught: " << e.what() << std::endl;
        }
    }
    return 0;
}
