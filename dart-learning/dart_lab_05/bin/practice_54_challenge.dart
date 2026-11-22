// Práctica 5.4 - Reto breve: leer el archivo, mostrar estadísticas de
// cada observación y escribir una copia normalizada. Ningún número se escribe
// a mano: todo sale de los modelos.
// Ejecutar: dart run bin/practice_54_challenge.dart
import 'dart:io';

import 'package:dart_lab_05/agrodiversa.dart';

void main() {
  File inputFile = File('data/observations.json');
  File outputFile = File('data/normalized_observations.json');
  RecordJsonCodec codec = RecordJsonCodec();

  try {
    List<AgriculturalRecord> records =
        codec.decodeRecords(inputFile.readAsStringSync());

    for (final record in records) {
      CropArea largest = record.largestCrop;
      print('${record.municipality} | ${record.year} | '
          '${record.crops.length} cultivos | '
          'total ${record.totalArea.toStringAsFixed(2)} ha | '
          'mayor ${largest.name} '
          '(${largest.plantedArea.toStringAsFixed(2)} ha)');
    }

    outputFile.writeAsStringSync(codec.encodeRecords(records));
    print('Archivo normalizado escrito: ${outputFile.path}');
  } on FileSystemException catch (error) {
    print('Error de archivo: ${error.message}');
  } on FormatException catch (error) {
    print('Datos inválidos: ${error.message}');
  }
}
