#include <iostream>
#include <tuple>

using namespace std;

int main()
{
    int x = 1;
    int y = 2;

    // swap() requires <tuple>
    swap(x, y);

    x = y;

    x > y ? cout << x << " > " << y : cout << x << " <= " << y;

    return 0;
}
