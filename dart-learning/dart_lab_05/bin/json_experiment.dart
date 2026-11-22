// Práctica 5.4, sección 2 - Primer experimento con jsonDecode.
// Ejecutar: dart run bin/json_experiment.dart
import 'dart:convert';

void main() {
  const source = '{"name":"Coffee","plantedArea":125.0}';
  // Cámbialo a 'not json' para ver la FormatException que lanza
  // jsonDecode; después recupera el texto válido.

  Object? decoded = jsonDecode(source);

  if (decoded is! Map<String, dynamic>) {
    print('Se esperaba un objeto JSON.');
    return;
  }

  print(decoded['name']); // Coffee
  print(decoded['plantedArea']); // 125.0
  print(decoded.runtimeType); // un Map, no un CropArea
}
