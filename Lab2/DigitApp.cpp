/**
 * @file DigitApp.cpp
 * @author Haichuan Wei  (arthur.wei50@gmail.com)
 * @brief This is the main file of the DigitApp. It contains the main function. The program will ask the user to input a integer and then call a function to print each ditgit of the integer.
 * @version 1
 * @date 2022-06-15
 *
 * @copyright Copyright (c) 2022
 *
 */

#include "PrtHead.h"

int main()
{

    cout << setw(50) << "Program created by Arthur Wei :)" << endl;
    cout << "Enter A Number For It To Split Up." << endl;
    int number;
    cin >> number;
    splitNumber(number);
    return 0;
}