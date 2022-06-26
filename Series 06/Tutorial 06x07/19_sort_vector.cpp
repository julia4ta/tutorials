#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

int main()
{
    // vector data type requires <vector>
    vector<int> v = {4, 2, 5, 3, 1};

    // sort ascending
    // sort() requires <algorithm>
    // sort(v.begin(), v.end());

    // sort descending
    // sort(v.begin(), v.end(), greater<int>());

    // sort descending with lambda expression
    sort(v.begin(), v.end(), [](int a, int b){return a > b;});

    // print vector
    for (int i : v)
    {
        cout << i << endl;
    }

    return 0;
}
