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

    for (auto const& [key, val] : dog)
    {
        cout << key << ":\t" << val << endl;
    }

    return 0;
}
