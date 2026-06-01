#include <iostream>
using namespace std;

class Rectangle {
private:
    int length, width;

public:
    Rectangle(int l, int w) {
        length = l;
        width = w;
    }

    int area() {
        return length * width;
    }
};

int main() {
    Rectangle r(10, 5);

    cout << "Area = " << r.area();

    return 0;
}
