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
        // method (function)
        void speak();
};

void Dog::speak()
{
    cout << "henlo hooman!" << endl;
    cout << name << " is my name." << endl;
    cout << "i am " << age << " year(s) old and" << endl;
    cout << breed << " is my breed." << endl;
}

int main()
{
    // object (variable name of struct)
    Dog dog1;

    dog1.name = "eggdog";
    dog1.age = 2;
    dog1.breed = "egg-dog mix";

    dog1.speak();

    return 0;
}
