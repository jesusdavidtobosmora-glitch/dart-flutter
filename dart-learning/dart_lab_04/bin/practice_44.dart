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
    if (this.crops.isEmpty) {
      throw ArgumentError.value(crops, 'crops', 'At least one crop is required.');
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

  double get totalArea {
    var total = 0.0;
    for (final crop in crops) {
      total += crop.plantedArea;
    }
    return total;
  }

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

void main() {
  final inputCrops = <CropArea>[
    CropArea(name: 'Coffee', plantedArea: 125.0),
    CropArea(name: 'Plantain', plantedArea: 75.0),
    CropArea(name: 'Avocado', plantedArea: 50.0),
  ];

  final record = AgriculturalRecord(
    municipality: 'Andes',
    year: 2025,
    crops: inputCrops,
  );

  inputCrops.add(CropArea(name: 'Beans', plantedArea: 40.0));

  print('${record.municipality} ${record.year}');
  print('Crops: ${record.crops.length}'); // remains 3
  print('Total: ${record.totalArea.toStringAsFixed(2)} ha');
  print('Average: ${record.averageArea.toStringAsFixed(2)} ha');
  print('Largest: ${record.largestCrop.name}');
  print('Largest share: ${record.largestShare.toStringAsFixed(2)}%');
}
