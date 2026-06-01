#include <iostream>
#include <string>
using namespace std;

class Book {
public:
    int bookId;
    string title;
    string author;
};

int main() {

    Book books[100];
    int count = 0;
    int choice;

    while(true) {

        cout << "\n===== LIBRARY MANAGEMENT =====\n";
        cout << "1. Add Book\n";
        cout << "2. Display Books\n";
        cout << "3. Search Book\n";
        cout << "4. Exit\n";
        cout << "Enter Choice: ";
        cin >> choice;

        switch(choice) {

        case 1:
            cout << "Enter Book ID: ";
            cin >> books[count].bookId;

            cin.ignore();

            cout << "Enter Title: ";
            getline(cin, books[count].title);

            cout << "Enter Author: ";
            getline(cin, books[count].author);

            count++;

            cout << "Book Added Successfully\n";
            break;

        case 2:

            cout << "\nBook Records\n";

            for(int i = 0; i < count; i++) {
                cout << "\nBook ID : "
                     << books[i].bookId;

                cout << "\nTitle : "
                     << books[i].title;

                cout << "\nAuthor : "
                     << books[i].author << endl;
            }

            break;

        case 3: {

            int id;
            bool found = false;

            cout << "Enter Book ID: ";
            cin >> id;

            for(int i = 0; i < count; i++) {

                if(books[i].bookId == id) {

                    cout << "\nBook Found\n";
                    cout << "Title : "
                         << books[i].title << endl;

                    cout << "Author : "
                         << books[i].author << endl;

                    found = true;
                    break;
                }
            }

            if(!found)
                cout << "Book Not Found\n";

            break;
        }

        case 4:
            return 0;

        default:
            cout << "Invalid Choice\n";
        }
    }
}
