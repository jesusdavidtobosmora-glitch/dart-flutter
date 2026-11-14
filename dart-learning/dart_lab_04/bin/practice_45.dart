class CropArea {
  final String name;
  final double plantedArea;

  CropArea({required String name, required this.plantedArea})
      : name = name.trim() {
    if (this.name.isEmpty) {
      throw ArgumentError.value(name, 'name', 'Name is required.');
    }
    if (!plantedArea.isFinite || plantedArea <= 0) {
      throw ArgumentError.value(plantedArea, 'plantedArea', 'Area must be positive and finite.');
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
      throw ArgumentError.value(municipality, 'municipality', 'Municipality is required.');
    }
    if (year < 2000 || year > 2100) {
      throw ArgumentError.value(year, 'year', 'Invalid year.');
    }
    if (this.crops.isEmpty) {
      throw ArgumentError.value(crops, 'crops', 'At least one crop is required.');
    }
    final names = <String>{};
    for (final crop in this.crops) {
      if (!names.add(crop.name.toLowerCase())) {
        throw ArgumentError.value(crop.name, 'crop', 'Duplicate crop name.');
      }
    }
    if (!totalArea.isFinite) throw ArgumentError('Total area must be finite.');
  }

  double get totalArea => crops.fold(0.0, (sum, crop) => sum + crop.plantedArea);
  double get averageArea => totalArea / crops.length;

  CropArea get largestCrop {
    var largest = crops.first;
    for (final crop in crops.skip(1)) {
      if (crop.plantedArea > largest.plantedArea) largest = crop;
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
    final result = _records.values.toList();
    result.sort((a, b) => _buildKey(a.municipality, a.year)
        .compareTo(_buildKey(b.municipality, b.year)));
    return List<AgriculturalRecord>.unmodifiable(result);
  }

  List<String> get uniqueCropNames {
    final names = <String>{};
    for (final record in _records.values) {
      for (final crop in record.crops) {
        names.add(crop.name.toLowerCase());
      }
    }
    final result = names.toList()..sort();
    return List<String>.unmodifiable(result);
  }
}

void main() {
  final catalog = ObservationCatalog();

  final first = AgriculturalRecord(
    municipality: 'Andes',
    year: 2025,
    crops: [
      CropArea(name: 'Coffee', plantedArea: 125),
      CropArea(name: 'Plantain', plantedArea: 75),
    ],
  );
  final second = AgriculturalRecord(
    municipality: 'Andes',
    year: 2024,
    crops: [
      CropArea(name: 'Coffee', plantedArea: 110),
      CropArea(name: 'Beans', plantedArea: 40),
    ],
  );

  print(catalog.add(first)); // true
  print(catalog.add(second)); // true
  print(catalog.add(first)); // false: duplicate key
  print('Count: ${catalog.count}');

  final found = catalog.find(' ANDES ', 2025);
  print('Found total: ${found?.totalArea}');

  print('Unique crops: ${catalog.uniqueCropNames.join(', ')}');
  print('Removed: ${catalog.remove('Andes', 2024)}');
  print('Removed again: ${catalog.remove('Andes', 2024)}');
}
