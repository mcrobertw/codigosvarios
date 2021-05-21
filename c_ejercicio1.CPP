 #include <stdio.h>
 #include <conio.h>
 #include <iostream.h>

 int suma(int a, int b)
 {
 	return a+b;
 }
 void main(){
  clrscr();
  int valor1, valor2;
  printf("Ingrese número 1: ");
  cin>>valor1;
  printf("Ingrese número 2: ");
  cin>>valor2;
  printf("El resultado de la suma es: %d",suma(valor1,valor2));
  getch();
 }