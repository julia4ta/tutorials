#include <iostream>

using namespace std;

int myadd(int x, int y)
{
    return x + y;
}

// function overloading
double myadd(double x, double y)
{
    return x + y;
}

int main()
{
    int ans1 = myadd(2, 3);
    cout << "2 + 3 = " << ans1 << endl;

    cout << endl;

    double ans2 = myadd(2.2, 3.3);
    cout << "2.2 + 3.3 = " << ans2 << endl;

    return 0;
}
