/**
 * @file StackHead.h
 * @author Haichuan Wei  (arthur.wei50@gmail.com)
 * @brief This is the file that links the Stack App together (!see stackapp.cpp for program details)
 * @version Lab 3
 * @date 2022-06-16
 *
 * @function Push() - This function pushes the data into the stack. (See stack.cpp for details)
 * *param data - The data the user enters
 *  @function Pop() - This function Pops the data out of the stack. (See stack.cpp for details)
 * *param none
 *  @function peek() - This function Looks at the top most layer of the stack. (See stack.cpp for details)
 * *param none
 *
 * @copyright Copyright (c) 2022
 *
 */

#ifndef _STACK_HEAD_H_
#define _STACK_HEAD_H_
#include <iostream>
#include <string>
#include <iomanip>

using namespace std;

void push(int data);
void pop();
void peek();

#endif // ! _STACK_HEAD_H_
