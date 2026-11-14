void main() {
  print('=== PRACTICE 3.3 ===');

  Set<String> crops = {'Coffee', 'Cocoa', 'Beans'};
  crops.add('Coffee');
  print('Unique count: ${crops.length}');
  print('Contains Coffee: ${crops.contains('Coffee')}');

  List<String> reportedCrops = [
    'Coffee',
    'Cocoa',
    'Coffee',
    'Beans',
    'Rice',
    'Rice',
  ];
  Set<String> uniqueCrops = reportedCrops.toSet();
  print('Original records: ${reportedCrops.length}');
  print('Unique names: ${uniqueCrops.length}');
  print(uniqueCrops);

  Set<String> emptyCrops = <String>{};
  emptyCrops.add('Coffee');
  emptyCrops.add('Beans');
  emptyCrops.add('Coffee');
  print('Empty set after additions: $emptyCrops');

  List<String> rawNames = [
    'Coffee',
    'coffee',
    ' COFFEE ',
    'Cocoa',
    ' Cocoa ',
    'Beans',
  ];
  Set<String> normalizedNames = <String>{};
  for (final name in rawNames) {
    normalizedNames.add(name.trim().toLowerCase());
  }
  print('Normalized unique names: $normalizedNames');
  print('Normalized count: ${normalizedNames.length}');

  Set<String> firstYear = {'Coffee', 'Cocoa', 'Beans'};
  Set<String> secondYear = {'Coffee', 'Rice', 'Beans'};
  print('Union: ${firstYear.union(secondYear)}');
  print('Intersection: ${firstYear.intersection(secondYear)}');
  print('Difference: ${firstYear.difference(secondYear)}');

  List<String> sortedCrops = normalizedNames.toList();
  sortedCrops.sort();
  print('Sorted unique names: $sortedCrops');
  print('Contains coffee: ${normalizedNames.contains('coffee')}');
}
