#include <iostream>

using namespace std;

int main()
{
    int ans = 1;

    cout << "variable value = " << ans << endl;
    cout << "variable address = " << &ans << endl;

    int *pAns = &ans;

    cout << endl;

    cout << "pointer value = " << pAns << endl;
    cout << "value stored at that address = " << *pAns << endl;

    *pAns = 42;

    cout << endl;

    cout << "variable value = " << ans << endl;
    cout << "variable address = " << &ans << endl;

    cout << endl;

    cout << "pointer value = " << pAns << endl;
    cout << "value stored at that address = " << *pAns << endl;

    return 0;
}
