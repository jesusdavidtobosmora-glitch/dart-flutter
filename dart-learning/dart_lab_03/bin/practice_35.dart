void main() {
  print('=== PRACTICE 3.5 ===');

  List<double> areas = [10.0, 50.0, 5.0, 80.0];

  // Filtering with a for loop.
  List<double> selectedWithFor = <double>[];
  for (final area in areas) {
    if (area >= 20.0) selectedWithFor.add(area);
  }
  print('For result: $selectedWithFor');

  // Filtering with where.
  final selectedWithWhere =
      areas.where((area) => area >= 20.0).toList();
  print('Where result: $selectedWithWhere');
  print('Greater than 50: ${areas.where((area) => area > 50.0).toList()}');

  List<String> crops = [' coffee ', ' BEANS', 'Cocoa '];
  final normalized = crops
      .map((name) => name.trim().toLowerCase())
      .toList();
  final uppercase = crops
      .map((name) => name.trim().toUpperCase())
      .toList();
  print('Normalized: $normalized');
  print('Uppercase: $uppercase');
  print('Original unchanged: $crops');

  final names = ['Coffee', '', ' Beans ', '   ', 'Rice'];
  final cleanedNames = names
      .map((name) => name.trim())
      .where((name) => name.isNotEmpty)
      .toList();
  print('Cleaned names: $cleanedNames');

  final cleanedInWrongOrder = names
      .where((name) => name.isNotEmpty)
      .map((name) => name.trim())
      .toList();
  print('If filtered before trim, whitespace-only remains: '
      '$cleanedInWrongOrder');

  final sampleAreas = [125.0, 75.0, 50.0];
  double totalWithFor = 0.0;
  for (final area in sampleAreas) {
    totalWithFor += area;
  }
  final totalWithFold = sampleAreas.fold<double>(
    0.0,
    (sum, area) => sum + area,
  );
  print('For total: $totalWithFor');
  print('Fold total: $totalWithFold');

  final smallAreas = [12.5, 7.5, 5.0];
  print('Small total with fold: ${smallAreas.fold<double>(
    0.0,
    (sum, area) => sum + area,
  )}');

  List<String> original = ['Rice', 'Coffee', 'Beans'];
  List<String> sorted = List<String>.from(original);
  sorted.sort();
  print('Original: $original');
  print('Sorted copy: $sorted');

  Map<String, double> cropAreas = {
    'Coffee': 125.0,
    'Beans': 15.0,
    'Rice': 80.0,
    'Cocoa': 50.0,
  };
  final largeCrops = cropAreas.entries
      .where((entry) => entry.value >= 50.0)
      .map((entry) => entry.key)
      .toList();
  largeCrops.sort();
  print('Crops >= 50: $largeCrops');

  final mapTotal = cropAreas.values.fold<double>(
    0.0,
    (sum, area) => sum + area,
  );
  print('Map total with fold: $mapTotal');

  final normalizedUnique = cropAreas.keys
      .map((name) => name.trim().toLowerCase())
      .toSet();
  print('Normalized unique crop names: $normalizedUnique');
}
