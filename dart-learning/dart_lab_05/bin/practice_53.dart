// Práctica 5.3 - Módulos, imports y responsabilidades separadas.
// Ejecutar: dart run bin/practice_53.dart
//
// Importa la API pública del paquete en lugar de rutas internas.
import 'package:dart_lab_05/agrodiversa.dart';

// Sección 6: un consumidor que recibe su dependencia por el constructor.
// Es solo una demostración; no hace parte del producto final.
class CropPresenter {
  final ReportFormatter formatter;

  CropPresenter(this.formatter);

  String present(CropArea crop) {
    return formatter.format(crop.name, crop.plantedArea);
  }
}

void main() {
  CropArea crop = CropArea(name: 'Beans', plantedArea: 40.0);

  // Reto: el mismo consumidor funciona con tres implementaciones
  // sin cambiar su lógica.
  List<ReportFormatter> formatters = [
    CompactFormatter(),
    DetailedFormatter(),
    MinimalFormatter(),
  ];

  for (final formatter in formatters) {
    CropPresenter presenter = CropPresenter(formatter);
    print(presenter.present(crop));
  }

  // Ejercicio de la sección 7 - dónde va cada operación:
  // - Calcular una suma de áreas -> model/ (AgriculturalRecord.totalArea)
  // - Leer un archivo JSON       -> bin/ lee, storage/ convierte
  // - Mostrar un menú            -> bin/
  // - Probar un constructor      -> test/
}
