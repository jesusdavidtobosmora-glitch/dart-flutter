
import 'dart:io';
String? readRequiredText(String prompt) {
  while (true) {
    stdout.write(prompt);

    String? input = stdin.readLineSync();

    if (input == null) {
      return null;
    }

    input = input.trim();

    if (input.isEmpty) {
      print('Este espacio no puede estar vacío.');
      continue;
    }

    return input;
  }
}


int? readIntInRange(String prompt, int minimum, int maximum) {
  while (true) {
    stdout.write(prompt);

    String? input = stdin.readLineSync();

    if (input == null) {
      return null;
    }

    int? number = int.tryParse(input.trim());

    if (number == null) {
      print('Por favor ingrese un número valido.');
      continue;
    }

    if (number < minimum || number > maximum) {
      print('El número debe estar entre $minimum y $maximum.');
      continue;
    }

    return number;
  }
}

void main() {
  print('=== Explorador de agricultor ===');

  while (true) {
  print('1. Registrar un cultivo');
  print('2. Ultimo resumen');
  print('0. Exit');

  stdout.write('Selecciona una opcion: ');
  String? input = stdin.readLineSync();

   int? option = int.tryParse(input ?? '');

  if (option == null) {
  print('Ingresa un número valido');
  continue;
}

switch (option) {
case 1:
  print('=== Registro de Cultivo===');

  String? municipality = readRequiredText('Ingresa un municipio: ');

  if (municipality == null) {
    print('Registro cancelado.');
    return;
  }

int? year = readIntInRange('Ingrese un año: ', 2000, 2100);

if (year == null) {
  print('Registro cancelado.');
  return;
}

print('Año registrado: $year');

  print('Municipo registrado: $municipality');
  break;

  case 2:
    print('Ultimo resumen...');
    break;

  case 0:
    print('Adiós!');
    return;

      default:
        print('Opción no valida. Selecciona 0, 1 o 2.');
}

  print('Seleccionaste el: $input');
  }

}
