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

    if (x > y)
    {
        cout << x << " is greater than " << y << endl;
    }
    else if (x < y)
    {
        cout << x << " is less than " << y << endl;
    }
    else
    {
        cout << x << " is equal to " << y << endl;
    }

    return 0;
}
