#include <iostream>
#include <map>

using namespace std;

int main()
{
    // key-value pair data types cannot change
    map<string, string> dog =
    {
        {"name", "eggdog"},
        {"age", "2"},
        {"breed", "egg-dog mix"}
    };

    cout << "Name:\t" << dog["name"] << endl;
    cout << "Age:\t" << dog["age"] << endl;
    cout << "Breed:\t" << dog["breed"] << endl;

    dog["name"] = "Doggo";

    cout << endl;

    cout << "Name:\t" << dog["name"] << endl;
    cout << "Age:\t" << dog["age"] << endl;
    cout << "Breed:\t" << dog["breed"] << endl;

    dog.insert(pair<string, string>("email", "dog@dog.dog"));

    cout << endl;

    cout << "Name:\t" << dog["name"] << endl;
    cout << "Age:\t" << dog["age"] << endl;
    cout << "Breed:\t" << dog["breed"] << endl;
    cout << "Email:\t" << dog["email"] << endl;

    dog.erase("email");

    cout << endl;

    cout << "Name:\t" << dog["name"] << endl;
    cout << "Age:\t" << dog["age"] << endl;
    cout << "Breed:\t" << dog["breed"] << endl;
    cout << "Email:\t" << dog["email"] << endl;

    dog["email"] = "new@new.new";

    cout << endl;

    cout << "Name:\t" << dog["name"] << endl;
    cout << "Age:\t" << dog["age"] << endl;
    cout << "Breed:\t" << dog["breed"] << endl;
    cout << "Email:\t" << dog["email"] << endl;

    return 0;
}
