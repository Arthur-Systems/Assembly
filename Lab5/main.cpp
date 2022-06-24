
#include <iostream>

using namespace std;

int main()
{

    int array[5] = {1, 2, 3, 4, 0};
    int sum = 0, addition = 0;

    for (int i = 0; array[i] != 0; i++)
    {
        addition += array[i];
    }
    sum = addition;
    cout << sum << endl;
}