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
        // constructor
        Dog(string a, int b, string c)
        {
            name = a;
            age = b;
            breed = c;
        }
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
    Dog dog1("eggdog", 2, "egg-dog mix");
    Dog dog2("martha", 30, "average dog");

    dog1.speak();

    cout << endl;

    dog2.speak();

    return 0;
}
