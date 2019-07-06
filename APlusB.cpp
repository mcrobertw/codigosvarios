#include <iostream.h>
#include <conio.h>
//Author: Robert Moreira; Country: Ecuador; Language: Spanish

int sum_of_two_digits(int first_digit, int second_digit) {
    return first_digit + second_digit;
}

int main() {
    int a = 0;
    int b = 0;
    cout<<"Ingrese valor 1: ";
    cin >> a;
    cout<<"Ingrese valor 2: ";
    cin >> b;
    cout << sum_of_two_digits(a, b);
    getch();
    return 0;
}