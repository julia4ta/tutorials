#include <iostream>
#include <string>

using namespace std;

int main()
{
    // char ans = 'a';
    // cout << ans << endl;

    // string data type included in standard library
    // string ans = "Hello";
    // cout << ans << endl;

    // cout << "This is \"great\"." << endl;
    // cout << "\n1\n2\n3" << endl;
    // cout << "\n1\t2\t3" << endl;

    // string s1 = "Hello";
    // string s2 = ", ";
    // string s3 = "World!";

    // no need to use strcat() function
    // use + operator to concatenate
    // cout << s1 + s2 + s3 << endl;

    // string s4 = "Dabbling";
    // cout << "My name is " << s4 << " Doggo." << endl;

    // to_string() requires <string>
    // int number123 = 123;
    // string ans = to_string(number123);
    // cout << ans << endl;

    // stoi() requires <string>
    // string string123 = "123";
    // int ans = stoi(string123);
    // cout << ans << endl;

    // stof() requires <string>
    string stringPI = "3.14159";
    float ans = stof(stringPI);
    cout << ans << endl;

    return 0;
}
