#include <iostream>

using namespace std;

int main()
{
    int matrix[2][3] =
    {
        {1, 2, 3},
        {4, 5, 6}
    };

    for (auto& row : matrix)
    {
        for (auto& col : row)
        {
            cout << col << " ";
        }
        cout << endl;
    }

    return 0;
}
