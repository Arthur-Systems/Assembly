/**
 * @file main.cpp
 * @author Arthur Wei
 * @brief This is the file with the prototype definitions of the functions.
 * @version Lab 1--Printing a hex number as binary
 * @date 2022-06-14
 * @function convertHtoB converts the hexadecimal number to binary. By breaking the inputted string into individual characters and then converting each character to its binary equivalent.
 *
 *
 * @param hexadecimal the hexadecimal input from the user
 * @return hexadecimal
 * @param binary the binary output
 * @return binary
 * @copyright Copyright (c) 2022
 *
 */
#include "HexHead.h"

string convertHtoB(string hexadecimal)
{
    string binary = " ";

    for (int i = 0; i < hexadecimal.length(); i++)
    {
        switch (hexadecimal[i])
        {
        case '0':
            binary += "0000";
            break;
        case '1':
            binary += "0001";
            break;
        case '2':
            binary += "0010";
            break;
        case '3':
            binary += "0011";
            break;
        case '4':
            binary += "0100";
            break;
        case '5':
            binary += "0101";
            break;
        case '6':
            binary += "0110";
            break;
        case '7':
            binary += "0111";
            break;
        case '8':
            binary += "1000";
            break;
        case '9':
            binary += "1001";
            break;
        case 'A':
            binary += "1010";
            break;
        case 'B':
            binary += "1011";
            break;
        case 'C':
            binary += "1100";
            break;
        case 'D':
            binary += "1101";
            break;
        case 'E':
            binary += "1110";
            break;
        case 'F':
            binary += "1111";
            break;
        default:
            cout << "You Entered An Invalid HEX, Clearing!" << endl;
            binary = " ";
            break;
        }
    }
    return binary;
}
