double totalAreas(Map<String, double> cropAreas) {
  double total = 0.0;
  for (final area in cropAreas.values) {
    total += area;
  }
  return total;
}

void main() {
  print('=== PRACTICE 3.4 ===');

  Map<String, double> cropAreas = {
    'Coffee': 125.0,
    'Plantain': 75.0,
    'Avocado': 50.0,
  };
  print(cropAreas);
  print('Entries: ${cropAreas.length}');
  print('Coffee area: ${cropAreas['Coffee']}');

  double? existingArea = cropAreas['Coffee'];
  double? missingArea = cropAreas['Rice'];
  print('Existing: $existingArea');
  print('Missing: $missingArea');

  final areaOrZero = cropAreas['Rice'] ?? 0.0;
  print('Rice or zero: $areaOrZero');

  final coffeeArea = cropAreas['Coffee'];
  if (coffeeArea != null) {
    print('Coffee exists with area $coffeeArea');
  } else {
    print('Coffee was not found.');
  }

  cropAreas['Beans'] = 40.0;
  cropAreas['Coffee'] = 130.0;
  print('After add/update: $cropAreas');
  cropAreas.remove('Beans');
  print('After removal: $cropAreas');

  print('--- Keys ---');
  for (final name in cropAreas.keys) {
    print(name);
  }
  print('--- Values ---');
  for (final area in cropAreas.values) {
    print(area);
  }
  print('--- Entries ---');
  for (final entry in cropAreas.entries) {
    print('${entry.key}: ${entry.value} ha');
  }
  print('Total area: ${totalAreas(cropAreas)}');

  final cropNames = ['Coffee', 'Beans', 'Coffee', 'Rice', 'Beans'];
  final appearances = <String, int>{};
  for (final name in cropNames) {
    final previousCount = appearances[name] ?? 0;
    appearances[name] = previousCount + 1;
  }
  print('Appearances: $appearances');

  Map<String, Map<String, double>> observations = {
    'Andes (2025)': {'Coffee': 125.0, 'Plantain': 75.0},
    'Andes (2024)': {'Coffee': 110.0, 'Beans': 40.0},
    'La Mesa (2025)': {'Cocoa': 20.0, 'Plantain': 30.0},
  };

  print('Observation identifiers: ${observations.keys}');
  print('Andes 2025: ${observations['Andes (2025)']}');

  final Map<String, double>? selected = observations['Unknown (2025)'];
  if (selected == null) {
    print('Observation not found.');
  } else {
    print(selected);
  }

  for (final entry in observations.entries) {
    print('${entry.key}: ${entry.value.length} crops, '
        'total ${totalAreas(entry.value).toStringAsFixed(2)} ha');
  }

  // A shallow outer-map copy still shares the inner maps.
  final shallowCopy =
      Map<String, Map<String, double>>.of(observations);
  final sharedInner = shallowCopy['Andes (2025)'];
  if (sharedInner != null) {
    sharedInner['Coffee'] = 150.0;
  }
  print('Original after changing shared inner map: $observations');

  // Copying the inner map creates an independent crop map.
  final inputCrops = <String, double>{'Coffee': 125.0};
  final savedCrops = Map<String, double>.from(inputCrops);
  inputCrops['Coffee'] = 200.0;
  print('Independent saved value: ${savedCrops['Coffee']}');
}
