#include <ccomplex>
#include <cstdint>

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


/*
function polyspeak(animal::Int32)
    res = ccall(("polyspeak_tR8l_void_int32_t", "libPolySpeak"), Nothing, (Int32,), animal)
    return res::Nothing
end
*/
extern "C" void polyspeak_tR8l_void_int32_t(
    int32_t animal
) {
    Pet pet1;
Dog dog1;
Cat cat1;

switch (animal)
{
case 1:
    dog1.speak();
    break;
case 2:
    cat1.speak();
    break;
default:
    pet1.speak();
    break;
}

}

