/**
 * @file DigitPrt.cpp
 * @author Haichuan Wei  (arthur.wei50@gmail.com)
 * @brief This is where all the function definitions are. The program will take the passed data from the main function and print each digit of the number.
 * @version 1
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