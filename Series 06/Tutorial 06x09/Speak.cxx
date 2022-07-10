#include <ccomplex>
#include <cstdint>

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
    cout << "I am " << age << " year(s) old and" << endl;
    cout << breed << " is my breed." << endl;
}


/*
function speak()
    res = ccall(("speak_tR8l_void", "libSpeak"), Nothing, ())
    return res::Nothing
end
*/
extern "C" void speak_tR8l_void(
    
) {
    Dog dog1;

dog1.name = "eggdog";
dog1.age = 2;
dog1.breed = "egg-dog mix";

dog1.speak();

}

