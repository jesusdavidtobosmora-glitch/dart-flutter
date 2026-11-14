void printCrops(List<String> crops) {
  if (crops.isEmpty) {
    print('No crops available.');
    return;
  }

  for (int index = 0; index < crops.length; index++) {
    print('${index + 1}. ${crops[index]}');
  }
}

void main() {
  print('=== PRACTICE 3.2 ===');

  List<String> crops = ['Coffee', 'Plantain', 'Avocado'];
  print(crops);
  print('Length: ${crops.length}');
  print('First: ${crops[0]}');
  print('Last: ${crops[crops.length - 1]}');

  if (crops.isNotEmpty) {
    print('Safe first item: ${crops.first}');
  }

  crops.add('Cocoa');
  crops[1] = 'Beans';
  crops.insert(1, 'Rice');
  print('After add, replace and insert: $crops');

  print('Contains Rice: ${crops.contains('Rice')}');
  print('Index of Cocoa: ${crops.indexOf('Cocoa')}');
  print('Index of missing crop: ${crops.indexOf('Wheat')}');

  crops.remove('Rice');
  if (crops.contains('Cocoa')) {
    crops.removeAt(crops.indexOf('Cocoa'));
  }
  print('After removals: $crops');

  print('--- for with index ---');
  for (int index = 0; index < crops.length; index++) {
    print('Position $index: ${crops[index]}');
  }

  print('--- for-in with human counter ---');
  int position = 1;
  for (final crop in crops) {
    print('$position. $crop');
    position++;
  }

  List<double> areas = [125.0, 75.0, 50.0, 25.0];
  double total = 0.0;
  double largest = 0.0;

  for (final area in areas) {
    total += area;
    if (area > largest) largest = area;
  }

  print('Total area: $total');
  print('Largest area: $largest');

  final mutableCrops = <String>['Coffee', 'Cocoa'];
  mutableCrops.add('Beans');
  const fixedCrops = <String>['Rice', 'Plantain'];
  print('Mutable final list: $mutableCrops');
  print('Const list: $fixedCrops');

  List<String> original = ['Coffee', 'Beans'];
  List<String> shared = original;
  List<String> separate = List<String>.from(original);
  shared.add('Cocoa');
  separate.add('Rice');
  print('Original (also changed through shared): $original');
  print('Separate copy: $separate');

  print('--- Safe history list demo ---');
  final history = <String>[];
  printCrops(history);
  history.add('Coffee');
  history.add('Beans');
  history.add('Coffee');
  printCrops(history);

  final searchName = 'Rice';
  final foundIndex = history.indexOf(searchName);
  if (foundIndex >= 0) {
    history.removeAt(foundIndex);
  } else {
    print('$searchName was not found; no removal attempted.');
  }
  printCrops(history);
}
