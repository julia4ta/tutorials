##################################################
# Example: Polymorphism
##################################################

# assign variable names

filename = "PolySpeak.cxx"

lib = "libPolySpeak"

func = :polyspeak

# write c++ code

using CxxCall

eval(cxxsetup())

# add header(s)

eval(cxxnewfile(filename,
    """
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
    """
))

# add function declaration(s) & definition(s)

@cxx lib function $func(animal::Cint)::Cvoid
    """
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
    """
end

# create cxx file

cxx_write_code!()

# create shared library (windows)

run(`g++ -fpic -shared $filename -o $lib.dll`)

# use julia's dynamic link standard library

using Libdl

# create pointer to shared library

dlopen(lib)

# test c++ function(s) in julia

polyspeak(Cint(1))

polyspeak(Cint(2))

polyspeak(Cint(3))

polyspeak(Cint(4))
