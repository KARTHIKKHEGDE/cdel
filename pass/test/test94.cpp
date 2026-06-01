#include <iostream>
#include <vector>

struct DataBlock {
    int id;
    double values[100];
    char name[50];
};

void process_data_94(int size) {
    std::vector<DataBlock> blocks(size);
    for(int j=0; j<size; j++) {
        blocks[j].id = j;
        for(int k=0; k<100; k++) {
            blocks[j].values[k] = j * k * 0.1;
        }
    }
    
    double sum = 0;
    for(const auto& b : blocks) {
        sum += b.values[0];
    }
    std::cout << "Sum: " << sum << std::endl;
}

int main() {
    process_data_94(188);
    return 0;
}
