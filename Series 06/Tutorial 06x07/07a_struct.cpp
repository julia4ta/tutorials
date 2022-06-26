#include <iostream>

using namespace std;

// string data type included in standard library
struct Dog
{
    string name;
    int age;
    string breed;
};

int main()
{
    // no need to use keyword struct
    Dog dog1;

    // no need to use strcpy()
    dog1.name = "eggdog";
    dog1.age = 2;
    dog1.breed = "egg-dog mix";

    cout << "Name:\t" << dog1.name << endl;
    cout << "Age:\t" << dog1.age << endl;
    cout << "Breed:\t" << dog1.breed << endl;

    dog1.name = "Doggo";

    cout << endl;

    cout << "Name:\t" << dog1.name << endl;
    cout << "Age:\t" << dog1.age << endl;
    cout << "Breed:\t" << dog1.breed << endl;

    return 0;
}
