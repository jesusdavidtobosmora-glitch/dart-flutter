import 'dart:io';

String? readRequiredText(String prompt) {
  while (true) {
    stdout.write(prompt);
    final String? rawInput = stdin.readLineSync();

    if (rawInput == null) {
      print('Input ended.');
      return null;
    }

    final value = rawInput.trim();
    if (value.isNotEmpty) return value;

    print('A non-empty value is required.');
  }
}

int? readIntInRange(String prompt, int minimum, int maximum) {
  while (true) {
    stdout.write(prompt);
    final String? rawInput = stdin.readLineSync();

    if (rawInput == null) {
      print('Input ended.');
      return null;
    }

    final value = int.tryParse(rawInput.trim());
    if (value != null && value >= minimum && value <= maximum) {
      return value;
    }

    print('Enter an integer from $minimum to $maximum.');
  }
}

double? readPositiveArea(String prompt) {
  while (true) {
    stdout.write(prompt);
    final String? rawInput = stdin.readLineSync();

    if (rawInput == null) {
      print('Input ended.');
      return null;
    }

    final value = double.tryParse(rawInput.trim());
    if (value != null && value.isFinite && value > 0) {
      return value;
    }

    print('Enter a positive finite area.');
  }
}

String createObservationKey(String municipality, int year) {
  final normalized = municipality.trim().toLowerCase();
  return '$normalized ($year)';
}

String? readUniqueCropName(
  String prompt,
  Map<String, double> currentCrops,
) {
  while (true) {
    final name = readRequiredText(prompt);
    if (name == null) return null;

    final normalized = name.trim().toLowerCase();
    if (!currentCrops.containsKey(normalized)) return normalized;

    print('Crop already registered in this observation.');
  }
}

bool registerObservation(
  Map<String, Map<String, double>> observations,
) {
  final municipality = readRequiredText('Municipality: ');
  if (municipality == null) return false;

  final year = readIntInRange('Year (2000-2100): ', 2000, 2100);
  if (year == null) return false;

  final key = createObservationKey(municipality, year);
  if (observations.containsKey(key)) {
    print('Observation already exists.');
    return true;
  }

  final cropCount = readIntInRange('Number of crops (1-5): ', 1, 5);
  if (cropCount == null) return false;

  final currentCrops = <String, double>{};

  for (int index = 1; index <= cropCount; index++) {
    final cropName = readUniqueCropName(
      'Crop $index name: ',
      currentCrops,
    );
    if (cropName == null) return false;

    final area = readPositiveArea('Crop $index area (ha): ');
    if (area == null) return false;

    currentCrops[cropName] = area;
  }

  // Save only after the complete observation has been entered.
  observations[key] = Map<String, double>.from(currentCrops);
  print('Observation saved in memory.');
  return true;
}

void listObservations(
  Map<String, Map<String, double>> observations,
) {
  if (observations.isEmpty) {
    print('No observations registered.');
    return;
  }

  final keys = observations.keys.toList()..sort();
  print('\n=== SAVED OBSERVATIONS ===');
  for (final key in keys) {
    print(key);
  }
}

double calculateTotalArea(Map<String, double> crops) {
  return crops.values.fold<double>(
    0.0,
    (total, area) => total + area,
  );
}

void showObservationSummary(
  String key,
  Map<String, double> crops,
) {
  if (crops.isEmpty) {
    print('No crops available.');
    return;
  }

  final sortedNames = crops.keys.toList()..sort();
  print('\n=== OBSERVATION DETAILS ===');
  print('Observation: $key');
  print('Crops:');

  for (final name in sortedNames) {
    print('  $name: ${crops[name]!.toStringAsFixed(2)} ha');
  }

  final totalArea = calculateTotalArea(crops);
  final averageArea = totalArea / crops.length;

  String largestCrop = '';
  double largestArea = 0.0;

  for (final entry in crops.entries) {
    // Strict > preserves the first crop in case of a tie.
    if (entry.value > largestArea) {
      largestArea = entry.value;
      largestCrop = entry.key;
    }
  }

  final largestShare =
      totalArea > 0 ? largestArea / totalArea * 100 : 0.0;

  print('Total area: ${totalArea.toStringAsFixed(2)} ha');
  print('Average area: ${averageArea.toStringAsFixed(2)} ha');
  print('Largest crop: $largestCrop (${largestArea.toStringAsFixed(2)} ha)');
  print('Largest crop participation: ${largestShare.toStringAsFixed(2)}%');
}

bool viewObservation(
  Map<String, Map<String, double>> observations,
) {
  final municipality = readRequiredText('Municipality: ');
  if (municipality == null) return false;

  final year = readIntInRange('Year (2000-2100): ', 2000, 2100);
  if (year == null) return false;

  final key = createObservationKey(municipality, year);
  final crops = observations[key];

  if (crops == null) {
    print('Observation not found.');
    return true;
  }

  showObservationSummary(key, crops);
  return true;
}

void showUniqueCrops(
  Map<String, Map<String, double>> observations,
) {
  final uniqueCrops = <String>{};

  for (final crops in observations.values) {
    uniqueCrops.addAll(crops.keys);
  }

  if (uniqueCrops.isEmpty) {
    print('No crops available.');
    return;
  }

  final sortedNames = uniqueCrops.toList()..sort();
  print('Unique crop names: ${sortedNames.length}');

  for (final name in sortedNames) {
    print(name);
  }
}

void main() {
  final observations = <String, Map<String, double>>{};

  while (true) {
    print('\n==================================');
    print('        AGRODIVERSA CATALOG');
    print('==================================');
    print('1. Register observation');
    print('2. List observations');
    print('3. View observation details');
    print('4. Show unique crop names');
    print('0. Exit');

    final option = readIntInRange('Option: ', 0, 4);
    if (option == null || option == 0) {
      print('Goodbye!');
      return;
    }

    switch (option) {
      case 1:
        if (!registerObservation(observations)) {
          print('Goodbye!');
          return;
        }
        break;
      case 2:
        listObservations(observations);
        break;
      case 3:
        if (!viewObservation(observations)) {
          print('Goodbye!');
          return;
        }
        break;
      case 4:
        showUniqueCrops(observations);
        break;
    }
  }
}
