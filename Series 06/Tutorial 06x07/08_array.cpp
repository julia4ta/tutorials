#include <iostream>
#include <vector>

using namespace std;

int main()
{
    int scalar[] = {1};

    cout << scalar[0] << endl;

    // vector data type requires <vector>
    vector<int> v = {1, 2, 3};

    cout << endl;

    cout << v[0] << endl;
    cout << v[1] << endl;
    cout << v[2] << endl;

    int ans = v[1] * 5;

    cout << endl;

    cout << "2 * 5 = " << ans << endl;

    // size() requires <vector>
    // int length = size(v);
    int length = v.size();

    cout << endl;

    cout << "elements in vector = " << length << endl;

    // push_back() requires <vector>
    v.push_back(4);

    cout << endl;

    cout << v[0] << endl;
    cout << v[1] << endl;
    cout << v[2] << endl;
    cout << v[3] << endl;

    // size() requires <vector>
    length = v.size();

    cout << endl;

    cout << "elements in vector = " << length << endl;

    // pop_back() requires <vector>
    v.pop_back();

    cout << endl;

    cout << v[0] << endl;
    cout << v[1] << endl;
    cout << v[2] << endl;
    cout << v[3] << endl;

    // size() requires <vector>
    length = v.size();

    cout << endl;

    cout << "elements in vector = " << length << endl;

    return 0;
}
