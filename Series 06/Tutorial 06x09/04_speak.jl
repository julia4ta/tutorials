##################################################
# Example: Calling a Method
##################################################

# assign variable names

filename = "Speak.cxx"

lib = "libSpeak"

func = :speak

# write c++ code

using CxxCall

eval(cxxsetup())

# add header(s)

eval(cxxnewfile(filename,
    """
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
    """
))

# add function declaration(s) & definition(s)

@cxx lib function $func()::Cvoid
    """
    Dog dog1;

    dog1.name = "eggdog";
    dog1.age = 2;
    dog1.breed = "egg-dog mix";

    dog1.speak();
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

speak()
