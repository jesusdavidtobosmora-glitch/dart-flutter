
import 'dart:io';

// 1. Validar que el nombre no esté vacío.
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

// 2. Validar que el año sea un entero entre 2000 y 2100.
int? readIntInRange(String prompt, int minimum, int maximum) {
  while (true) {
    stdout.write(prompt);

    String? rawInput = stdin.readLineSync();

    if (rawInput == null) {
      print('Input ended.');
      return null;
    }

    int? value = int.tryParse(rawInput.trim());

    if (value == null) {
      print('Please enter a valid integer.');
      continue;
    }

    if (value < minimum || value > maximum) {
      print('Year must be between $minimum and $maximum.');
      continue;
    }

    return value;
  }
}

// 3. Validar que el área sea positiva y finita.
double? readPositiveArea(String prompt) {
  while (true) {
    stdout.write(prompt);

    String? rawInput = stdin.readLineSync();

    if (rawInput == null) {
      print('Input ended.');
      return null;
    }

    double? area = double.tryParse(rawInput.trim());

    if (area == null) {
      print('Please enter a valid number.');
      continue;
    }

    if (!area.isFinite || area <= 0) {
      print('Area must be positive and finite.');
      continue;
    }

    return area;
  }
}

// 4. Programa principal.
void main() {
  print('=== VALIDATED CROP OBSERVATION ===');

  while (true) {
    // Solicitar nombre del cultivo.
    String? cropName = readRequiredText('Crop name: ');

    if (cropName == null) {
      return;
    }

    // Solicitar año.
    int? year = readIntInRange(
      'Year (2000-2100): ',
      2000,
      2100,
    );

    if (year == null) {
      return;
    }

    // Solicitar área.
    double? area = readPositiveArea('Area (ha): ');

    if (area == null) {
      return;
    }

    // Mostrar registro únicamente si todo es válido.
    print('\n=== CROP REGISTRATION ===');
    print('Crop name: $cropName');
    print('Year: $year');
    print('Area: $area ha');

    break;
  }
}
