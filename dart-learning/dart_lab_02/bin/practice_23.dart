import 'dart:io';
void main() {
//Selección por valor
print('Selección por valor:');
  int option = 9;

  switch (option) {
    case 1:
      print('Register observation.');
    case 2:
      print('View summary.');
    case 0:
      print('Exit.');
    default:
      print('Unknown option.');
  }

//Elegir la estructura correcta
print('Elegir la estructura correcta:');
String format = 'compact';

  switch (format) {
    case 'compact':
      print('One-line summary.');
    case 'detailed':
      print('Detailed summary.');
    default:
      print('Unsupported format.');
  }

//Selección desde la terminal
print('Selección desde la terminal:');
print('1. Register');
  print('2. Summary');
  print('0. Exit');
  stdout.write('Option: ');

  String option2 = (stdin.readLineSync() ?? '').trim();

  switch (option2) {
    case '1':
      print('Register selected.');
    case '2':
      print('Summary selected.');
    case '0':
      print('Exit selected.');
    default:
      print('Invalid option.');
  }

//Separar la elección de su presentación
print('Separar la elección de su presentación:');
  String getOptionName(String option3) {
  switch (option3) {
    case '1':
      return 'Register';
    case '2':
      return 'Summary';
    case '0':
      return 'Exit';
    default:
      return 'Unknown';
  }
}
 print(getOptionName('1'));
 print(getOptionName('2'));
 print(getOptionName('8'));

//Reto Menú de seccciones
print('Reto Menú de secciones:');
  String getSectionName(String section) {
  switch (section) {
    case 'A':
      return 'Carne de res';
    case 'B':
      return 'Carne de cerdo';
    case 'C':
      return 'Carne de pollo';
    case 'Q':
      return 'No quiero carne';
    default:
      return 'Unknown section';
  }
}
 print(getSectionName('A'));
 print(getSectionName('B'));
 print(getSectionName('D'));
}
