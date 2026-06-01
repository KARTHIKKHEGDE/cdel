#include <iostream>
using namespace std;

class Demo {
public:
    int add(int a, int b) {
        return a + b;
    }

    double add(double a, double b) {
        return a + b;
    }
};

int main() {
    Demo d;

    cout << d.add(10, 20) << endl;
    cout << d.add(5.5, 2.3);

    return 0;
}
