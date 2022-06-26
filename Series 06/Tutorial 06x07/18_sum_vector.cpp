#include <iostream>
#include <vector>
#include <numeric>

using namespace std;

int main()
{
    // vector data type requires <vector>
    vector<int> v = {1, 2, 3, 4, 5};

    // accumulate() requires <numeric>
    int sum = accumulate(v.begin(), v.end(), 0);

    cout << sum << endl;

    return 0;
}
