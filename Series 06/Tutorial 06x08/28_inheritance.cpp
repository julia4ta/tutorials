#include <iostream>

using namespace std;

// base class (parent)
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

// derived class (child)
class Puppy : public Dog
{
    public:
        // required to inherit constructor
        using Dog::Dog;
        // method
        void minispeak();
};

// base class method definition
void Dog::speak()
{
    cout << "henlo hooman!" << endl;
    cout << name << " is my name." << endl;
    cout << "i am " << age << " year(s) old and" << endl;
    cout << breed << " is my breed." << endl;
}

// derived class method definition
void Puppy::minispeak()
{
    cout << "i'm smol" << endl;
}

int main()
{
    // constructor from base class
    Puppy puppy1("pupper", 1, "munchkin");

    // method from base class
    puppy1.speak();

    cout << endl;

    // method from derived class
    puppy1.minispeak();

    return 0;
}
