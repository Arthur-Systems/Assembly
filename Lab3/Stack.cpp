/**
 * @file Stack.cpp
 * @author Haichuan Wei  (arthur.wei50@gmail.com)
 * @brief This file is the implementation of the Stack class.
 * @version Lab 3
 * @date 2022-06-16
 *
 * @function Push(data) - This function pushes data passed by the main function into the stack. It makes sure that the stack is not full and if it isnt it moves up the array and adds the data into it.
 * *param data - The data the user enters
 * @function Pop() - This function Pops the data out of the stack. It makes sure that the stack is not empty and if it isnt it moves down the array and removes the data from it.
 * *param none
 * @function peek() - This function Looks at the top most layer of the stack.
 * *param none
 *
 * @copyright Copyright (c) 2022
 *
 */

#include "StackHead.h"

int top = -1;
int MAX_SIZE = 10;
int stack[10];

void push(int data)
{
    if (top != MAX_SIZE - 1)
    {
        top++;
        stack[top] = data;
    }
}

int pop()
{
    if (top == -1)
    {
        return 0;
    }
    int data = stack[top];
    top--;
    return data;
}

int peek()
{
    if (top == -1)
    {
        return 0;
    }
    return stack[top];
}