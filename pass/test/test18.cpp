#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>
#include <cstdlib>

using namespace std;

/* =============================================
 * TEST 18 — C++ OOP: Shape Hierarchy + Polymorphism
 * Abstract base, multiple derived classes, virtual
 * dispatch, operator overloading, templates.
 * ============================================= */

class Shape {
public:
    virtual double area() const = 0;
    virtual double perimeter() const = 0;
    virtual const char* name() const = 0;
    virtual ~Shape() {}
};

class Circle : public Shape {
    double radius;
public:
    Circle(double r) : radius(r) {}
    double area() const override { return 3.14159265 * radius * radius; }
    double perimeter() const override { return 2 * 3.14159265 * radius; }
    const char* name() const override { return "Circle"; }
};

class Rectangle : public Shape {
    double w, h;
public:
    Rectangle(double w, double h) : w(w), h(h) {}
    double area() const override { return w * h; }
    double perimeter() const override { return 2 * (w + h); }
    const char* name() const override { return "Rectangle"; }
};

class Triangle : public Shape {
    double a, b, c;
public:
    Triangle(double a, double b, double c) : a(a), b(b), c(c) {}
    double area() const override {
        double s = (a + b + c) / 2;
        double val = s * (s-a) * (s-b) * (s-c);
        // Newton's method sqrt approximation
        double x = val;
        for (int i = 0; i < 20; i++) x = 0.5 * (x + val / x);
        return x;
    }
    double perimeter() const override { return a + b + c; }
    const char* name() const override { return "Triangle"; }
};

class Pentagon : public Shape {
    double side;
public:
    Pentagon(double s) : side(s) {}
    double area() const override { return 1.720477 * side * side; }
    double perimeter() const override { return 5 * side; }
    const char* name() const override { return "Pentagon"; }
};

/* ---------- Template container ---------- */
template<typename T>
class Container {
    vector<T*> items;
public:
    void add(T* item) { items.push_back(item); }
    int size() const { return items.size(); }
    T* get(int i) const { return items[i]; }

    double totalArea() const {
        double sum = 0;
        for (auto* item : items) sum += item->area();
        return sum;
    }
    double totalPerimeter() const {
        double sum = 0;
        for (auto* item : items) sum += item->perimeter();
        return sum;
    }
    double maxArea() const {
        double mx = 0;
        for (auto* item : items)
            if (item->area() > mx) mx = item->area();
        return mx;
    }
    void sortByArea() {
        sort(items.begin(), items.end(),
             [](T* a, T* b) { return a->area() < b->area(); });
    }
};

int main() {
    Container<Shape> shapes;

    for (int i = 1; i <= 10; i++) shapes.add(new Circle(i * 1.5));
    for (int i = 1; i <= 10; i++) shapes.add(new Rectangle(i * 2.0, i * 1.5));
    for (int i = 1; i <= 5; i++)  shapes.add(new Triangle(i*3, i*4, i*5));
    for (int i = 1; i <= 5; i++)  shapes.add(new Pentagon(i * 2.0));

    cout << "Total shapes: " << shapes.size() << endl;
    cout << "Total area: " << shapes.totalArea() << endl;
    cout << "Total perimeter: " << shapes.totalPerimeter() << endl;
    cout << "Max area: " << shapes.maxArea() << endl;

    shapes.sortByArea();
    cout << "Smallest shape: " << shapes.get(0)->name()
         << " area=" << shapes.get(0)->area() << endl;
    cout << "Largest shape: " << shapes.get(shapes.size()-1)->name()
         << " area=" << shapes.get(shapes.size()-1)->area() << endl;

    for (int i = 0; i < shapes.size(); i++) delete shapes.get(i);
    return 0;
}
