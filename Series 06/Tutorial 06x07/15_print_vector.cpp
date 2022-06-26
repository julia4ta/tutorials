#include <iostream>
#include <vector>

using namespace std;

int main()
{
    // vector data type requires <vector>
    vector<int> v = {1, 2, 3};

    for (int i : v)
    {
        cout << i << endl;
    }

    return 0;
}
