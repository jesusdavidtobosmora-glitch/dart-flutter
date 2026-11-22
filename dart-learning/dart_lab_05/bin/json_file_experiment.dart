// Práctica 5.4, secciones 6 y 7 - Leer un archivo sin mezclarlo con
// el codec, y exportar a otro archivo.
// Ejecutar desde la raíz del proyecto: dart run bin/json_file_experiment.dart
import 'dart:io';

import 'package:dart_lab_05/agrodiversa.dart';

void main() {
  File inputFile = File('data/observations.json');
  RecordJsonCodec codec = RecordJsonCodec();

  try {
    String source = inputFile.readAsStringSync();
    List<AgriculturalRecord> records = codec.decodeRecords(source);

    print('Observaciones: ${records.length}');

    for (final record in records) {
      print('${record.municipality}: ${record.totalArea}');
    }

    // Sección 7: nunca escribir sobre el archivo de origen.
    String normalizedJson = codec.encodeRecords(records);

    File outputFile = File('data/normalized_observations.json');
    outputFile.writeAsStringSync(normalizedJson);

    print('Archivo normalizado escrito: ${outputFile.path}');
  } on FileSystemException catch (error) {
    print('Error de archivo: ${error.message}');
  } on FormatException catch (error) {
    print('Datos inválidos: ${error.message}');
  }
}
