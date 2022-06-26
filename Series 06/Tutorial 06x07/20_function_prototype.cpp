#include <iostream>

using namespace std;

// function declaration
int myadd(int, int);
double myadd(double, double);

int main()
{
    int ans1 = myadd(2, 3);
    cout << "2 + 3 = " << ans1 << endl;

    cout << endl;

    double ans2 = myadd(2.2, 3.3);
    cout << "2.2 + 3.3 = " << ans2 << endl;

    return 0;
}

// function definition

int myadd(int x, int y)
{
    return x + y;
}

double myadd(double x, double y)
{
    return x + y;
}
