#include <iostream>

using namespace std;

int main()
{
    int matrix[2][3] =
    {
        {1, 2, 3},
        {4, 5, 6}
    };

    cout << matrix[0][0] << " ";
    cout << matrix[0][1] << " ";
    cout << matrix[0][2] << endl;
    cout << matrix[1][0] << " ";
    cout << matrix[1][1] << " ";
    cout << matrix[1][2] << endl;

    return 0;
}
