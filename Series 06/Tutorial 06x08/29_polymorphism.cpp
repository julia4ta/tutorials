#include <iostream>

using namespace std;

// base class
class Pet
{
    public:
        void speak()
        {
            cout << "I am a petto." << endl;
        }
};

// derived class
class Dog : public Pet
{
    public:
        void speak()
        {
            cout << "I am a doggo and a petto." << endl;
        }
};

// derived class
class Cat : public Pet
{
    public:
        void speak()
        {
            cout << "I am a catto and a petto." << endl;
        }
};

int main()
{
    Pet pet1;
    Dog dog1;
    Cat cat1;

    pet1.speak();
    dog1.speak();
    cat1.speak();

    return 0;
}
