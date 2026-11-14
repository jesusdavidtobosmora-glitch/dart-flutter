import 'dart:io';

class CropArea {
  final String name;
  final double plantedArea;

  CropArea({
    required String name,
    required this.plantedArea,
  }) : name = name.trim() {
    if (this.name.isEmpty) {
      throw ArgumentError.value(name, 'name', 'Name is required.');
    }
    if (!plantedArea.isFinite || plantedArea <= 0) {
      throw ArgumentError.value(
        plantedArea,
        'plantedArea',
        'Area must be positive and finite.',
      );
    }
  }
}

class AgriculturalRecord {
  final String municipality;
  final int year;
  final List<CropArea> crops;

  AgriculturalRecord({
    required String municipality,
    required this.year,
    required List<CropArea> crops,
  })  : municipality = municipality.trim(),
        crops = List<CropArea>.unmodifiable(crops) {
    if (this.municipality.isEmpty) {
      throw ArgumentError.value(
        municipality,
        'municipality',
        'Municipality is required.',
      );
    }
    if (year < 2000 || year > 2100) {
      throw ArgumentError.value(year, 'year', 'Invalid year.');
    }
    if (this.crops.isEmpty || this.crops.length > 5) {
      throw ArgumentError.value(crops, 'crops', 'Use between 1 and 5 crops.');
    }

    final names = <String>{};
    for (final crop in this.crops) {
      if (!names.add(crop.name.toLowerCase())) {
        throw ArgumentError.value(crop.name, 'crop', 'Duplicate crop name.');
      }
    }
    if (!totalArea.isFinite) {
      throw ArgumentError('Total area must be finite.');
    }
  }

  double get totalArea =>
      crops.fold(0.0, (total, crop) => total + crop.plantedArea);

  double get averageArea => totalArea / crops.length;

  CropArea get largestCrop {
    var largest = crops.first;
    for (final crop in crops.skip(1)) {
      if (crop.plantedArea > largest.plantedArea) {
        largest = crop;
      }
    }
    return largest;
  }

  double get largestShare => largestCrop.plantedArea / totalArea * 100;
}

class ObservationCatalog {
  final Map<String, AgriculturalRecord> _records = {};

  String _buildKey(String municipality, int year) =>
      '${municipality.trim().toLowerCase()} ($year)';

  int get count => _records.length;

  bool add(AgriculturalRecord record) {
    final key = _buildKey(record.municipality, record.year);
    if (_records.containsKey(key)) return false;
    _records[key] = record;
    return true;
  }

  AgriculturalRecord? find(String municipality, int year) =>
      _records[_buildKey(municipality, year)];

  bool remove(String municipality, int year) =>
      _records.remove(_buildKey(municipality, year)) != null;

  List<AgriculturalRecord> listRecords() {
    final records = _records.values.toList();
    records.sort((a, b) => _buildKey(a.municipality, a.year)
        .compareTo(_buildKey(b.municipality, b.year)));
    return List<AgriculturalRecord>.unmodifiable(records);
  }

  List<String> get uniqueCropNames {
    final names = <String>{};
    for (final record in _records.values) {
      for (final crop in record.crops) {
        names.add(crop.name.toLowerCase());
      }
    }
    final sorted = names.toList()..sort();
    return List<String>.unmodifiable(sorted);
  }
}

String? readRequiredText(String prompt) {
  while (true) {
    stdout.write(prompt);
    final value = stdin.readLineSync();
    if (value == null) return null;
    if (value.trim().isNotEmpty) return value.trim();
    print('Value cannot be empty.');
  }
}

int? readIntInRange(String prompt, int minimum, int maximum) {
  while (true) {
    stdout.write(prompt);
    final line = stdin.readLineSync();
    if (line == null) return null;
    final value = int.tryParse(line.trim());
    if (value == null || value < minimum || value > maximum) {
      print('Enter an integer between $minimum and $maximum.');
      continue;
    }
    return value;
  }
}

double? readPositiveArea(String prompt) {
  while (true) {
    stdout.write(prompt);
    final line = stdin.readLineSync();
    if (line == null) return null;
    final value = double.tryParse(line.trim());
    if (value == null || !value.isFinite || value <= 0) {
      print('Enter a positive finite number.');
      continue;
    }
    return value;
  }
}

String? readUniqueCropName(String prompt, Set<String> usedNames) {
  while (true) {
    final rawName = readRequiredText(prompt);
    if (rawName == null) return null;
    final normalized = rawName.trim().toLowerCase();
    if (!usedNames.add(normalized)) {
      print('Crop already registered in this observation.');
      continue;
    }
    return rawName.trim();
  }
}

bool registerObservation(ObservationCatalog catalog) {
  final municipality = readRequiredText('Municipality: ');
  if (municipality == null) return false;

  final year = readIntInRange('Year (2000-2100): ', 2000, 2100);
  if (year == null) return false;

  if (catalog.find(municipality, year) != null) {
    print('Observation already exists.');
    return true;
  }

  final cropCount = readIntInRange('Number of crops (1-5): ', 1, 5);
  if (cropCount == null) return false;

  final currentCrops = <CropArea>[];
  final usedNames = <String>{};

  for (var index = 1; index <= cropCount; index++) {
    final cropName = readUniqueCropName('Crop $index name: ', usedNames);
    if (cropName == null) return false;

    final area = readPositiveArea('Crop $index area (ha): ');
    if (area == null) return false;

    currentCrops.add(CropArea(name: cropName, plantedArea: area));
  }

  final record = AgriculturalRecord(
    municipality: municipality,
    year: year,
    crops: currentCrops,
  );

  if (catalog.add(record)) {
    print('Observation registered.');
  } else {
    print('Observation already exists.');
  }
  return true;
}

void listObservations(ObservationCatalog catalog) {
  final records = catalog.listRecords();
  if (records.isEmpty) {
    print('No observations registered.');
    return;
  }

  for (final record in records) {
    print(
      '${record.municipality} (${record.year}): ${record.crops.length} crops',
    );
  }
}

void showObservation(AgriculturalRecord record) {
  print('Municipality: ${record.municipality}');
  print('Year: ${record.year}');

  for (final crop in record.crops) {
    print('${crop.name}: ${crop.plantedArea.toStringAsFixed(2)} ha');
  }

  print('Crops processed: ${record.crops.length}');
  print('Total area: ${record.totalArea.toStringAsFixed(2)} ha');
  print('Average area: ${record.averageArea.toStringAsFixed(2)} ha');
  print('Largest crop: ${record.largestCrop.name}');
  print('Largest area: ${record.largestCrop.plantedArea.toStringAsFixed(2)} ha');
  print('Largest share: ${record.largestShare.toStringAsFixed(2)}%');
}

bool viewObservation(ObservationCatalog catalog) {
  final municipality = readRequiredText('Municipality: ');
  if (municipality == null) return false;
  final year = readIntInRange('Year (2000-2100): ', 2000, 2100);
  if (year == null) return false;

  final record = catalog.find(municipality, year);
  if (record == null) {
    print('Observation not found.');
  } else {
    showObservation(record);
  }
  return true;
}

bool removeObservation(ObservationCatalog catalog) {
  final municipality = readRequiredText('Municipality: ');
  if (municipality == null) return false;
  final year = readIntInRange('Year (2000-2100): ', 2000, 2100);
  if (year == null) return false;

  if (catalog.remove(municipality, year)) {
    print('Observation removed.');
  } else {
    print('Observation not found.');
  }
  return true;
}

void main() {
  final catalog = ObservationCatalog();

  while (true) {
    print('\n================================');
    print('       AGRODIVERSA OOP');
    print('================================');
    print('1. Register observation');
    print('2. List observations');
    print('3. View observation');
    print('4. Show unique crops');
    print('5. Remove observation');
    print('0. Exit');

    final option = readIntInRange('Option: ', 0, 5);
    if (option == null || option == 0) {
      print('Goodbye!');
      return;
    }

    switch (option) {
      case 1:
        if (!registerObservation(catalog)) return;
      case 2:
        listObservations(catalog);
      case 3:
        if (!viewObservation(catalog)) return;
      case 4:
        final names = catalog.uniqueCropNames;
        if (names.isEmpty) {
          print('No crops available.');
        } else {
          for (final name in names) {
            print(name);
          }
        }
      case 5:
        if (!removeObservation(catalog)) return;
    }
  }
}
