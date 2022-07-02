#include <iostream>

using namespace std;

int main()
{
    int direction = 5;

    switch (direction)
    {
    case 1:
        cout << "Go North" << endl;
        break;
    case 2:
        cout << "Go South" << endl;
        break;
    case 3:
        cout << "Go West" << endl;
        break;
    case 4:
        cout << "Go East" << endl;
        break;
    
    default:
        cout << "Stay Still" << endl;
        break;
    }

    return 0;
}
