class AreaCounter {
  double _totalArea = 0.0;

  double get totalArea => _totalArea;

  bool addArea(double area) {
    if (!area.isFinite || area <= 0) return false;

    final nextTotal = _totalArea + area;
    if (!nextTotal.isFinite) return false;

    _totalArea = nextTotal;
    return true;
  }

  void reset() {
    _totalArea = 0.0;
  }
}

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

void main() {
  final first = AreaCounter();
  final second = AreaCounter();

  print(first.addArea(25.0)); // true
  print(first.addArea(-3.0)); // false
  print(first.addArea(0.0)); // false
  print(first.addArea(double.nan)); // false
  print(first.addArea(double.infinity)); // false
  print(first.totalArea); // 25.0
  print(second.totalArea); // 0.0

  first.reset();
  print(first.totalArea); // 0.0

  final crop = CropArea(name: ' Coffee ', plantedArea: 125.0);
  print('${crop.name}: ${crop.plantedArea} ha');

  // Dart privacy is library-wide. A leading underscore is not class-private.
}
