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

  CropArea.example()
      : name = 'Coffee',
        plantedArea = 125.0;

  double get areaInSquareMeters => plantedArea * 10000.0;

  String describe() => '$name: ${plantedArea.toStringAsFixed(2)} ha';
}

void main() {
  final coffee = CropArea(name: '  Coffee  ', plantedArea: 1.0);
  final beans = CropArea(name: 'Beans', plantedArea: 2.5);
  final cocoa = CropArea(name: 'Cocoa', plantedArea: 3.0);
  final sample = CropArea.example();

  for (final crop in [coffee, beans, cocoa, sample]) {
    print(crop.describe());
    print('Square meters: ${crop.areaInSquareMeters.toStringAsFixed(2)}');
  }
}
