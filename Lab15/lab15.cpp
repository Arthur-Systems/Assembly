#include <iostream>
#include <string>

using namespace std;

string userInput();

int main()
{

    cout << "Input(Int): ";
    string input = userInput();
    int inputInt = stoi(input);
    string string = to_string(inputInt);
    cout << "converted: " << string << endl;
}

string userInput()
{
    string input;
    cin >> input;
    return input;
}