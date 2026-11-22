// Práctica 5.2 - Null safety, invariantes y excepciones.
// Ejecutar: dart run bin/practice_52.dart

// Clase de ejemplo local. La versión de producción está en
// lib/src/model/crop_area.dart; esta solo vive en este archivo.
class CropArea {
  final String name;
  final double plantedArea;

  CropArea({required String name, required this.plantedArea})
      : name = name.trim() {
    if (this.name.isEmpty) {
      throw FormatException('El nombre del cultivo no puede estar vacío.');
    }
    if (!plantedArea.isFinite || plantedArea <= 0) {
      throw FormatException('El área sembrada debe ser positiva y finita.');
    }
  }
}

// 1. Valor ausente y valor predeterminado con ??
void section1MissingData() {
  String? note;
  String? reviewedNote = 'Verificado manualmente';

  print(note ?? 'No hay nota disponible');
  print(reviewedNote ?? 'No hay nota disponible');

  // Ejercicio.
  String? municipality = 'Andes';
  print(municipality);
  municipality = null;
  print(municipality ?? 'Municipio desconocido');
}

// 2. Comprobación de null y promoción de tipos
void showMunicipality(String? municipality) {
  if (municipality == null) {
    print('Falta el municipio.');
    return;
  }

  // Aquí Dart trata municipality como String (promoción).
  print(municipality.trim().toLowerCase());
}

// 3. Convertir no es validar
void checkAreaText(String text) {
  double? area = double.tryParse(text);

  if (area == null || !area.isFinite || area <= 0) {
    print("'$text' -> Ingresa un área positiva y finita.");
  } else {
    print("'$text' -> Área aceptada: $area");
  }
}

// 4 y 5. Validación en el modelo y captura de la excepción esperada
void section4And5Model() {
  CropArea crop = CropArea(name: ' Coffee ', plantedArea: 125.0);
  print('Nombre sin espacios: "${crop.name}"');

  try {
    CropArea invalid = CropArea(name: '', plantedArea: 12.5);
    print(invalid.name);
  } on FormatException catch (error) {
    print('Cultivo inválido: ${error.message}');
  }
}

// 6. finally
void parseYear(String text) {
  try {
    print(int.parse(text));
  } on FormatException {
    print('Formato de año inválido.');
  } finally {
    print('Intento de conversión finalizado.');
  }
}

// 6. rethrow
void validateArea(double area) {
  if (!area.isFinite || area <= 0) {
    throw FormatException('Área inválida.');
  }
}

void processArea(double area) {
  try {
    validateArea(area);
  } on FormatException {
    print('La validación falló.');
    rethrow; // conserva la traza original del error
  }
}

// Reto: intentar crear cinco cultivos, capturando solo FormatException.
void tryCreateCrops() {
  List<(String, double)> attempts = [
    ('Coffee', 125.0),
    ('   ', 10.0),
    ('Beans', 0.0),
    ('Cocoa', -3.0),
    ('Avocado', double.nan),
  ];

  for (final (name, area) in attempts) {
    try {
      CropArea crop = CropArea(name: name, plantedArea: area);
      print('Creado ${crop.name} con ${crop.plantedArea} ha.');
    } on FormatException catch (error) {
      print('Rechazado ("$name", $area): ${error.message}');
    }
  }
}

// Depuración: versión corregida del "catch silencioso".
void parseYearWithoutHidingErrors() {
  try {
    int year = int.parse('invalid');
    print(year);
  } on FormatException catch (error) {
    // Correcto: solo se captura el error esperado y se informa.
    print('Error esperado: el año no es un número entero: ${error.message}');
  }

  print('Operación completada.');
}

void main() {
  print('--- 1. Datos ausentes ---');
  section1MissingData();

  print('--- 2. Promoción de tipos ---');
  showMunicipality(null);
  showMunicipality(' Andes ');

  print('--- 3. Convertir vs validar ---');
  for (final text in ['NaN', 'abc', '-3', '0', 'Infinity', '12.5']) {
    checkAreaText(text);
  }

  print('--- 4 y 5. Validación en el modelo ---');
  section4And5Model();

  print('--- 6. finally ---');
  parseYear('2025');
  parseYear('invalid');

  print('--- 6. rethrow ---');
  try {
    processArea(-1.0);
  } on FormatException {
    print('Quien llamó manejó el error.');
  }

  print('--- Reto: cinco cultivos ---');
  tryCreateCrops();

  print('--- Depuración: sin catch silencioso ---');
  parseYearWithoutHidingErrors();
}
