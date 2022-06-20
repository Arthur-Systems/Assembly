/**
 * @file StackApp.cpp
 * @author Haichuan Wei  (arthur.wei50@gmail.com)
 * @brief This program uses basic C++ to create a STACK which means only the top layer of the array is accessible. The user can push data into the stack and pop data out of the stack as well as peek at the top most layer of the stack.
 * @version Lab 3
 * @date 2022-06-16
 *
 * @function main() - This function is the main function of the program.
 * *param none
 *
 * @copyright Copyright (c) 2022
 *
 */

#include "StackHead.h"

//! I added extra features to the program that wasnt listed in the instructions. It makes using the program much better and understandable. All the other functions are the same as the ones in the instructions.

int main()
{
    cout << "Program Created By Arthur Wei :)" << endl;
    cout << setw(50) << setfill('*') << '*' << endl;
    cout << "This program is a demo of STACKS in c++" << endl;
    cout << setw(50) << setfill('*') << '*' << endl;

    cout << "choose the option you want to do: " << endl;
    cout << "1.push" << endl;
    cout << "2.pop" << endl;
    cout << "3.peek" << endl;
    cout << "4.exit" << endl;

    int choice, data, count;
    cin >> choice;
    if (cin.fail())
    {
        cout << "Invalid input" << endl;
        return 0;
    }
    while (choice != 4)
    {

        switch (choice)
        {
        case 1:
            cout << "Please Enter Numbers To Push Into Stack" << endl;
            cout << "Enter -1 To Stop Entering" << endl;
            while (true)
            {
                cout << "Enter Data: (-1 to exit)" << endl;
                cin >> data;
                if (cin.fail())
                {
                    cin.clear();
                    cin.ignore(256, '\n');
                }
                if (data == -1)
                {
                    data = 0;
                    break;
                }
                push(data);
                count++;
            }
            break;
        case 2:
            cout << "Enter The Amount Of Data You Want To Pop" << endl;
            cin >> data;
            if (cin.fail())
            {
                cin.clear();
                cin.ignore(256, '\n');
            }
            if (data >= 0 && data < 10)
            {
                for (int i = 0; i < data; i++)
                {
                    peek();
                    cout << "Popping Data!" << endl;
                    pop();
                }
                break;
            }
            if (data > count)
            {
                cout << "Stack is too small to pop " << count << " elements" << endl;
            }
            else
            {
                cout << "ERROR!!! Can not remove that amount, try again." << endl;
            }
            break;
        case 3:
            peek();
            break;

        default:
            cout << "Invalid choice" << endl;
            break;
        }
        cout << "choose the option you want to do: " << endl;
        cout << "1.push" << endl;
        cout << "2.pop" << endl;
        cout << "3.peek" << endl;
        cout << "4.exit" << endl;
        cin >> choice;
        cout << "\n"
             << endl;
    }
    return 0;
}

/*
! This is the proof of output of the program:
arthur@Haichuans-MBP lab3 % make run
./Stack

Program Created By Arthur Wei :)
**************************************************
This program is a demo of STACKS in c++
**************************************************
choose the option you want to do:
1.push
2.pop
3.peek
4.exit
1
Please Enter Numbers To Push Into Stack
Enter -1 To Stop Entering
Enter Data: (-1 to exit)
34
Enter Data: (-1 to exit)
54
Enter Data: (-1 to exit)
24
Enter Data: (-1 to exit)
35
Enter Data: (-1 to exit)
23
Enter Data: (-1 to exit)
76
Enter Data: (-1 to exit)
-1
choose the option you want to do:
1.push
2.pop
3.peek
4.exit
3


The top element is 76  //! This is the correct expected output
choose the option you want to do:
1.push
2.pop
3.peek
4.exit
2


Enter The Amount Of Data You Want To Pop
5
The top element is 76
Popping Data!
The top element is 23
Popping Data!
The top element is 35
Popping Data!
The top element is 24
Popping Data!
The top element is 54
Popping Data!
choose the option you want to do:
1.push
2.pop
3.peek
4.exit
3


The top element is 34 //! This is the correct expected output
choose the option you want to do:
1.push
2.pop
3.peek
4.exit
4


arthur@Haichuans-MBP lab3 %
*/