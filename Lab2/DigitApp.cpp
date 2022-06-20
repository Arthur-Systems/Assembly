/**
 * @file DigitApp.cpp
 * @author Haichuan Wei  (Arthur)
 * @brief  The program will ask the user to input a integer and then passes it to the SplitNumber Function(see DigitPrt.cpp) and then call a function to print each digit of the integer.
 * @version Lab 2-Printing an integer in digits
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

/*
!Confirmation of the program:

arthur@Haichuans-MBP lab2 % make run
./mainapp
                  Program created by Arthur Wei :)
Enter A Number For It To Split Up.
69054                               //* This is the number that I want to split up
Digit # 1: 6
Digit # 2: 9
Digit # 3: 0
Digit # 4: 5
Digit # 5: 4
arthur@Haichuans-MBP lab2 %

*/