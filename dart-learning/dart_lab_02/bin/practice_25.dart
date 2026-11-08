import 'dart:io';
void main() {
//while
print('While');
  int attempts = 1;

  while (attempts <= 3) {
    print('Attempt $attempts');
    attempts++;
  }

//do while
print('Do While');
 int attempts1 = 1;

  do {
    print('Attempt $attempts1');
    attempts1++;
  } while (attempts1 <= 3);

//Validar conversiones con tryParse
print('Validar conversiones con tryParse:');
 int? validNumber = int.tryParse('12');
  int? invalidNumber = int.tryParse('-4.5');

  print(validNumber);
  print(invalidNumber);

double? area = double.tryParse('42.5');

  if (area == null) {
    print('Invalid number.');
  } else {
    print('Area: $area ha');
  }

//No aceptar NaN
print('No aceptar NaN:');
 double? area1 = double.tryParse('NaN');

  if (area1 == null || !area1.isFinite || area1 <= 0) {
    print('Enter a positive finite area.');
  } else {
    print('Accepted area: $area1');
  }

// Primera función reutilizable: texto obligatorio
print('Primera función reutilizable: texto obligatorio:');
String? readRequiredText(String prompt) {
  while (true) {
    stdout.write(prompt);
    String? rawInput = stdin.readLineSync();

    if (rawInput == null) {
      print('Input ended.');
      return null;
    }

    String value = rawInput.trim();

    if (value.isNotEmpty) {
      return value;
    }

    print('A non-empty value is required.');
  }
}
  String? municipality = readRequiredText('Municipality: ');

  if (municipality == null) {
    return;
  }

  print('Municipality: $municipality');

//Segunda función: entero dentro de límites
print('Segunda función: entero dentro de límites:');
int? readIntInRange(String prompt2, int minimum, int maximum) {
  while (true) {
    stdout.write(prompt2);
    String? rawInput2 = stdin.readLineSync();

    if (rawInput2 == null) {
      print('Input ended.');
      return null;
    }

    int? value2 = int.tryParse(rawInput2.trim());

    if (value2 != null && value2 >= minimum && value2 <= maximum) {
      return value2;
    }

    print('Enter an integer from $minimum to $maximum.');
  }
}

int? cropCount = readIntInRange('Crop count (1-5): ', 1, 5);

  if (cropCount == null) {
    return;
  }

  print('Accepted crop count: $cropCount');

//Tercera función: área positiva y finita
print('Tercera función: área positiva y finita:');
double? readPositiveArea(String prompt3) {
  while (true) {
    stdout.write(prompt3);
    String? rawInput = stdin.readLineSync();

    if (rawInput == null) {
      print('Input ended.');
      return null;
    }

    double? value = double.tryParse(rawInput.trim());

    if (value != null && value.isFinite && value > 0) {
      return value;
    }

    print('Enter a positive finite area.');
  }
}
double? area2 = readPositiveArea('Planted area (ha): ');

  if (area2 == null) {
    return;
  }

  String formattedArea = area2.toStringAsFixed(2);
  print('Accepted area: $formattedArea ha');

//Ciclo que nunca lee otro dato
  String? input = '';

  while (input != '0') {
    stdout.write('Enter 0 to exit: ');
    input = stdin.readLineSync();

    if (input != '0') {
      print('Waiting for 0...');
    }
  }

  print('You entered 0. Goodbye!');
}
