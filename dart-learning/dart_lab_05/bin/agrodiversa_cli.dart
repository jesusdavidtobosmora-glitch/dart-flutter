// Práctica 5.6 - Reto integrador: procesador agrícola con JSON.
//
// Ejecutar desde la raíz del proyecto:
//   dart run bin/agrodiversa_cli.dart            (compact por defecto)
//   dart run bin/agrodiversa_cli.dart compact
//   dart run bin/agrodiversa_cli.dart detailed
//
// bin/ solo coordina: las reglas viven en los modelos, la conversión
// en el codec y la presentación en los formateadores.
import 'dart:io';

import 'package:dart_lab_05/agrodiversa.dart';

const String sourcePath = 'data/observations.json';
const String outputPath = 'data/normalized_observations.json';

/// Elige un formateador según los argumentos. No lee archivos ni
/// imprime: solo escoge una implementación. Devuelve null cuando los
/// argumentos no son válidos.
ReportFormatter? selectFormatter(List<String> arguments) {
  String format = arguments.isEmpty ? 'compact' : arguments.first;

  if (arguments.length > 1) {
    return null;
  }

  switch (format) {
    case 'compact':
      return CompactFormatter();
    case 'detailed':
      return DetailedFormatter();
    default:
      return null;
  }
}

/// Construye el bloque de texto de una observación. Los números vienen del
/// modelo; el formateador solo decide cómo se ve el encabezado.
String describeRecord(AgriculturalRecord record, ReportFormatter formatter) {
  double total = record.totalArea;
  double average = record.averageArea;
  CropArea largest = record.largestCrop;
  // Porcentaje del cultivo mayor sobre SU PROPIA observación, no sobre el archivo.
  double largestShare = largest.plantedArea / total * 100;

  String title = '${record.municipality} (${record.year})';

  return [
    formatter.format(title, total),
    '  Cultivos: ${record.crops.length}',
    '  Área promedio: ${average.toStringAsFixed(2)} ha',
    '  Cultivo mayor: ${largest.name}: '
        '${largest.plantedArea.toStringAsFixed(2)} ha '
        '(${largestShare.toStringAsFixed(2)}%)',
  ].join('\n');
}

void main(List<String> arguments) {
  ReportFormatter? formatter = selectFormatter(arguments);

  if (formatter == null) {
    stderr.writeln('Uso: dart run bin/agrodiversa_cli.dart [compact|detailed]');
    exitCode = 2;
    return;
  }

  File sourceFile = File(sourcePath);
  File outputFile = File(outputPath);
  RecordJsonCodec codec = RecordJsonCodec();

  try {
    // 1. Leer y decodificar. Cualquier dato inválido se detiene aquí.
    String source = sourceFile.readAsStringSync();
    List<AgriculturalRecord> records = codec.decodeRecords(source);

    // 2. Comprobar el total combinado ANTES de imprimir o escribir algo.
    double grandTotal = records.fold<double>(
      0.0,
      (sum, record) => sum + record.totalArea,
    );

    if (!grandTotal.isFinite) {
      throw FormatException('El área combinada no es finita.');
    }

    // 3. Mostrar el informe.
    print('Observaciones válidas: ${records.length}');

    if (records.isEmpty) {
      print('No hay observaciones disponibles.');
    } else {
      int cropRecords = 0;

      for (final record in records) {
        print('');
        print(describeRecord(record, formatter));
        cropRecords += record.crops.length;
      }

      print('');
      print('Registros de cultivo en el archivo: $cropRecords');
      print('Área combinada de los registros de observación: '
          '${grandTotal.toStringAsFixed(2)} ha');
    }

    // 4. Exportar solo después de validar todo, y nunca sobre el
    //    archivo de origen.
    String normalizedJson = codec.encodeRecords(records);
    outputFile.writeAsStringSync(normalizedJson);

    print('Archivo normalizado escrito: ${outputFile.path}');
  } on FileSystemException catch (error) {
    stderr.writeln('Error de archivo: ${error.message} (${error.path})');
    exitCode = 1;
  } on FormatException catch (error) {
    stderr.writeln('Datos agrícolas inválidos: ${error.message}');
    exitCode = 1;
  }
}
