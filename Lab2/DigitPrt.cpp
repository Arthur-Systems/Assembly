/**
 * @file DigitPrt.cpp
 * @author Haichuan Wei  (Arthur)
 * @brief This is where all the function definitions are. The program will take the passed data from the main function and print each digit of the number.
 * @function splitNumber Uses the passed data from the main function then sets a temp variable inorder to perserve the original data which then will be devided by 10 to get the digit count. Then the number will be devided by the power of the amount of digits and the remainder will be printed.
 * @variable number passed from the main function
 * @variable remainder is the remainder of the number after each digit is divided by the power of 10 and the amount of digits
 * @variable digits the total number of digits
 * @variable count just counts up.
 * @version Lab 2-Printing an integer
 * @date 2022-06-15
 *
 * @copyright Copyright (c) 2s022
 *
 */
#include "PrtHead.h"

void splitNumber(int number)
{
    int remainder = 0, digits = 0, count = 0;

    for (int temp = number; temp > 0; temp /= 10)
    {
        digits++;
    }

    for (int temp; digits > 0; digits--)
    {

        temp = pow(10, digits - 1);
        remainder = number / temp;
        number -= remainder * temp;
        count++;
        cout << "Digit # " << count << ": " << remainder << endl;
    }
}