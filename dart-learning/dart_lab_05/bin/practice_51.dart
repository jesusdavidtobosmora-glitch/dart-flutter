// Práctica 5.1 - Herencia, interfaces, polimorfismo y composición.
// Ejecutar: dart run bin/practice_51.dart
//
// La guía muestra cada sección como un programa separado. Aquí están
// unidas en un solo archivo: cada sección tiene su propia función y main()
// las llama en orden. Las secciones 2 y 3 comparten una sola clase Report.

// ---------------------------------------------------------------------
// 1. Clases y constructores
// ---------------------------------------------------------------------
class CropArea {
  final String name;
  final double plantedArea;

  CropArea({required this.name, required this.plantedArea});

  String describe() {
    return '$name: $plantedArea ha';
  }
}

void section1Classes() {
  CropArea coffee = CropArea(name: 'Coffee', plantedArea: 125.0);
  CropArea beans = CropArea(name: 'Beans', plantedArea: 40.0);
  // Ejercicio: un objeto Cocoa.
  CropArea cocoa = CropArea(name: 'Cocoa', plantedArea: 20.0);

  print(coffee.describe());
  print(beans.describe());
  print(cocoa.describe());

  // Depuración intencional: si escribes CropArea(nombre: 'Cocoa', ...)
  // el analizador informa "The named parameter 'nombre' isn't defined"
  // y "The named parameter 'name' is required".
}

// ---------------------------------------------------------------------
// 2 y 3. Herencia (extends), sobrescritura y polimorfismo
// ---------------------------------------------------------------------
abstract class Report {
  String get title;

  // Implementación heredada: las subclases la reciben sin escribirla.
  String describe() {
    return 'Reporte: $title';
  }
}

class MunicipalReport extends Report {
  @override
  final String title;

  MunicipalReport(this.title);
}

// Ejercicio de la sección 2.
class DepartmentReport extends Report {
  @override
  final String title;
  final int municipalities;

  DepartmentReport(this.title, this.municipalities);

  @override
  String describe() {
    // super.describe() reutiliza la implementación de la clase madre.
    return '${super.describe()} ($municipalities municipios)';
  }
}

class CompactReport extends Report {
  @override
  String get title => 'Compacto';

  @override
  String describe() => 'Reporte compacto';
}

class DetailedReport extends Report {
  @override
  String get title => 'Detallado';

  @override
  String describe() => 'Reporte detallado';
}

// Ejercicio de la sección 3: una tercera implementación.
class SummaryReport extends Report {
  @override
  String get title => 'Resumen';

  @override
  String describe() => 'Reporte resumen: solo totales';
}

// Usa el contrato común; nunca revisa el tipo concreto con if.
void showDescription(Report report) {
  print(report.describe());
}

void section2And3Inheritance() {
  // Una variable del tipo base puede referirse a una instancia hija.
  Report report = MunicipalReport('Andes 2025');
  print(report.describe()); // Reporte: Andes 2025

  Report department = DepartmentReport('Antioquia 2025', 125);
  print(department.describe());

  showDescription(CompactReport());
  showDescription(DetailedReport());
  showDescription(SummaryReport()); // funciona sin cambios
}

// ---------------------------------------------------------------------
// 4. Interfaces en Dart 3 (implements)
// ---------------------------------------------------------------------
abstract interface class ReportFormatter {
  String format(String title, double area);
}

class CompactFormatter implements ReportFormatter {
  @override
  String format(String title, double area) {
    String value = area.toStringAsFixed(2);
    return '$title: $value ha';
  }
}

class VerboseFormatter implements ReportFormatter {
  @override
  String format(String title, double area) {
    String value = area.toStringAsFixed(2);
    return 'La observación $title reporta $value hectáreas.';
  }
}

void section4Interfaces() {
  ReportFormatter formatter = CompactFormatter();
  print(formatter.format('Andes 2025', 125.0));

  formatter = VerboseFormatter();
  print(formatter.format('Andes 2025', 125.0));

  // Depuración intencional:
  // - ReportFormatter()  -> error: una clase abstracta no se puede instanciar.
  // - Quitar format de CompactFormatter -> error: "Missing concrete
  //   implementation of 'ReportFormatter.format'" (falta la implementación).
  // - Renombrarlo a formatted -> el mismo error: el contrato exige un
  //   miembro llamado format con esa firma exacta, y @override sobre
  //   formatted informa "doesn't override an inherited method" (no sobrescribe nada).
}

// ---------------------------------------------------------------------
// 5. Composición e inyección por constructor
// ---------------------------------------------------------------------
class ReportPrinter {
  // "tiene un" ReportFormatter: composición, no herencia.
  final ReportFormatter formatter;

  ReportPrinter(this.formatter);

  void printReport(String title, double area) {
    print(formatter.format(title, area));
  }
}

void section5Composition() {
  // Reto: dos impresores con implementaciones diferentes.
  ReportPrinter compactPrinter = ReportPrinter(CompactFormatter());
  ReportPrinter verbosePrinter = ReportPrinter(VerboseFormatter());

  compactPrinter.printReport('Andes 2025', 125.0);
  verbosePrinter.printReport('Andes 2025', 125.0);
}

// ---------------------------------------------------------------------
// 6. ¿Por qué no una clase por cultivo?
// ---------------------------------------------------------------------
// CoffeeArea, BeansArea y CocoaArea solo se diferenciarían en un valor
// (el nombre). Eso es un dato, no otro tipo de objeto, así que basta
// con un solo CropArea. Una observación *contiene* varios
// objetos CropArea (composición); no es un tipo de cultivo.

void main() {
  print('--- 1. Clases ---');
  section1Classes();
  print('--- 2 y 3. Herencia y polimorfismo ---');
  section2And3Inheritance();
  print('--- 4. Interfaces ---');
  section4Interfaces();
  print('--- 5. Composición ---');
  section5Composition();
}
