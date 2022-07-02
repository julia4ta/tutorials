#include <iostream>

using namespace std;

int main()
{
    int value = 1;
    int array[5];
    int *pArray = array;

    // fill array using a pointer
    for (; pArray < &array[5]; pArray++)
    {
        *pArray = value;
        value++;
    }
    
    // reset pointer
    pArray -= 5;

    // print array using a pointer
    for (; pArray < &array[5]; pArray++)
    {
        cout << *pArray << endl;
    }
    
    return 0;
}
