/**
 * @file mainapp.cpp
 * @author Arthur Wei
 * @brief This is the main file of the program. It passes the User inputted string to the convert function witch returns binary string.  Witch will then call the convert (see main.cpp)
 * @version Lab 1--Printing a hex number as binary
 * @date 2022-06-14
 *
 * @copyright Copyright (c) 2022
 *
 */

#include "HexHead.h"

int main()
{
    cout << "program created by Arthur Wei :)" << endl;
    cout << "This is a Hexadecimal To Binary calculator." << endl;
    cout << setw(50) << setfill('*') << '*' << endl;
    cout << "Please enter a number in hexadecimal: ";
    string hexadecimal;
    cin >> hexadecimal;
    cout << hexadecimal << " Hex to Decimal is: " << convertHtoB(hexadecimal) << endl;
    return 0;
}

/*
! Confirmation that it works, code Output To Console:
arthur@Haichuans-MBP Lab1 % make run
./mainapp

program created by Arthur Wei :)
This is a Hexadecimal To Binary calculator.
**************************************************
Please enter a number in hexadecimal: A1B2C3
A1B2C3 Hex to Decimal is:  101000011011001011000011

arthur@Haichuans-MBP Lab1 %
*/