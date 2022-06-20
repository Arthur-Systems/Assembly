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

    int choice, data, count = 0;
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
                count++;
                if (count > 10)
                {
                    cout << "Stack is full!" << endl;
                    break;
                }
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
                    cout << "The value being popped is " << pop() << endl;
                }
                break;
            }
            if (data > 10)
            {
                cout << "The amount of data you entered is too large" << endl;
                break;
            }
            else
            {
                cout << "ERROR!!! Can not remove that amount, try again." << endl;
                break;
            }
            break;
        case 3:
            cout << "The Top Most Layer Of The Stack Is: " << peek() << endl;
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
5
Enter Data: (-1 to exit)
64
Enter Data: (-1 to exit)
34
Enter Data: (-1 to exit)
678
Enter Data: (-1 to exit)
43
Enter Data: (-1 to exit)
654
Enter Data: (-1 to exit)
23
Enter Data: (-1 to exit)
65
Enter Data: (-1 to exit)
457
Enter Data: (-1 to exit)
4
Enter Data: (-1 to exit)
0
Stack is full!    //! Stack was full so this number was ignored
choose the option you want to do:
1.push
2.pop
3.peek
4.exit
3


The Top Most Layer Of The Stack Is: 4
choose the option you want to do:
1.push
2.pop
3.peek
4.exit
2


Enter The Amount Of Data You Want To Pop
6
The value being popped is 4
The value being popped is 457
The value being popped is 65
The value being popped is 23
The value being popped is 654
The value being popped is 43
choose the option you want to do:
1.push
2.pop
3.peek
4.exit
3


The Top Most Layer Of The Stack Is: 678 //! This was the expected output :)
choose the option you want to do:
1.push
2.pop
3.peek
4.exit
2


Enter The Amount Of Data You Want To Pop
1
The value being popped is 678
choose the option you want to do:
1.push
2.pop
3.peek
4.exit
3


The Top Most Layer Of The Stack Is: 34 //! This was the expected output :)
choose the option you want to do:
1.push
2.pop
3.peek
4.exit
4


arthur@Haichuans-MBP lab3 %

*/