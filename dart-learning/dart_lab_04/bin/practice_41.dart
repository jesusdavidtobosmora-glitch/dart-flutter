class CropArea {
  String name = '';
  double plantedArea = 0.0;

  void showDescription() {
    print('$name: $plantedArea ha');
  }

  double shareOf(double totalArea) {
    if (totalArea <= 0) return 0.0;
    return plantedArea / totalArea * 100;
  }

  String describe() => '$name: $plantedArea ha';

  double doubledArea() => plantedArea * 2;
}

double calculateAverage(double total, int count) {
  if (count <= 0) return 0.0;
  return total / count;
}

void main() {
  final coffee = CropArea()
    ..name = 'Coffee'
    ..plantedArea = 125.0;

  final beans = CropArea()
    ..name = 'Beans'
    ..plantedArea = 75.0;

  final cocoa = CropArea()
    ..name = 'Cocoa'
    ..plantedArea = 50.0;

  final total = coffee.plantedArea + beans.plantedArea + cocoa.plantedArea;

  for (final crop in [coffee, beans, cocoa]) {
    print('${crop.describe()} | ${crop.shareOf(total).toStringAsFixed(2)}%');
  }

  print('Doubled cocoa area: ${cocoa.doubledArea()}');
  print('Average: ${calculateAverage(total, 3).toStringAsFixed(2)} ha');

  // The three objects are independent instances of the same CropArea class.
  beans.plantedArea = 80.0;
  print('After changing Beans:');
  coffee.showDescription();
  beans.showDescription();
  cocoa.showDescription();
}
