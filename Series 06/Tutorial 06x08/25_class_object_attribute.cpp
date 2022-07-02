#include <iostream>

using namespace std;

// class (struct)
class Dog
{
    public:
        // attributes (members)
        string name;
        int age;
        string breed;
};

int main()
{
    // object (variable name of struct)
    Dog dog1;

    dog1.name = "eggdog";
    dog1.age = 2;
    dog1.breed = "egg-dog mix";

    cout << "Name:\t" << dog1.name << endl;
    cout << "Age:\t" << dog1.age << endl;
    cout << "Breed:\t" << dog1.breed << endl;

    return 0;
}
