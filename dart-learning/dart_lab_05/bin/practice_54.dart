// Práctica 5.4, sección 3 - Ejercicio con las invariantes de AgriculturalRecord.
// Ejecutar: dart run bin/practice_54.dart
import 'package:dart_lab_05/agrodiversa.dart';

void tryRecord(String label, AgriculturalRecord Function() build) {
  try {
    AgriculturalRecord record = build();
    print('$label -> creado ${record.municipality} (${record.year})');
  } on FormatException catch (error) {
    print('$label -> rechazado: ${error.message}');
  }
}

void main() {
  AgriculturalRecord record = AgriculturalRecord(
    municipality: 'Andes',
    year: 2025,
    crops: [
      CropArea(name: 'Coffee', plantedArea: 125.0),
      CropArea(name: 'Plantain', plantedArea: 75.0),
      CropArea(name: 'Avocado', plantedArea: 50.0),
    ],
  );

  print('Área total: ${record.totalArea.toStringAsFixed(2)} ha');
  print('Área promedio: ${record.averageArea.toStringAsFixed(2)} ha');
  print('Cultivo mayor: ${record.largestCrop.name}');

  tryRecord('Sin cultivos', () {
    return AgriculturalRecord(municipality: 'Andes', year: 2025, crops: []);
  });

  tryRecord('Nombres duplicados', () {
    return AgriculturalRecord(
      municipality: 'Andes',
      year: 2025,
      crops: [
        CropArea(name: 'Coffee', plantedArea: 10.0),
        CropArea(name: 'COFFEE', plantedArea: 20.0),
      ],
    );
  });

  tryRecord('Año 1999', () {
    return AgriculturalRecord(
      municipality: 'Andes',
      year: 1999,
      crops: [CropArea(name: 'Coffee', plantedArea: 10.0)],
    );
  });

  // La lista es inmodificable: el código externo no puede romper las invariantes.
  try {
    record.crops.add(CropArea(name: 'Coffee', plantedArea: 1.0));
  } on UnsupportedError {
    print('La lista de cultivos no se puede modificar después de construir el registro.');
  }
}
