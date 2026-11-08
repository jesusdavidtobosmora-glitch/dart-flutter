import 'dart:io';
void showTitle() {
  print('============================');
  print('     AGRICULTURAL REPORT');
  print('============================');
 }
void main() {
    showTitle();
  String department;
  String municipality;
  int observationYear;

  stdout.write('Ingresa el departamento: ');
  department = stdin.readLineSync() ?? '';

  stdout.write('Ingresa el municipio: ');
  municipality = stdin.readLineSync() ?? '';

  stdout.write('Ingresa el año de observación: ');
  String yearText = stdin.readLineSync() ?? '';
  observationYear = int.parse(yearText);

  print('De: $department');
  print('Municipio: $municipality');
  print('Año: $observationYear');

  String crop1;
  double area1;
  String crop2;
  double area2;
  String crop3;
  double area3;

  stdout.write('Ingresa el primer cultivo: ');
  crop1 = stdin.readLineSync() ?? '';

  stdout.write('Ingresa el área para $crop1 (ha): ');
  String area1Text = stdin.readLineSync() ?? '';
  area1 = double.parse(area1Text);

  stdout.write('Ingresa el segundo cultivo: ');
  crop2 = stdin.readLineSync() ?? '';

  stdout.write('Ingresa el área para $crop2 (ha): ');
  String area2Text = stdin.readLineSync() ?? '';
  area2 = double.parse(area2Text);

  stdout.write('Ingresa el tercer cultivo: ');
  crop3 = stdin.readLineSync() ?? '';

  stdout.write('Ingresa el área para $crop3 (ha): ');
  String area3Text = stdin.readLineSync() ?? '';
  area3 = double.parse(area3Text);

    print('Crop 1: $crop1, Area: $area1 ha');
    print('Crop 2: $crop2, Area: $area2 ha');
    print('Crop 3: $crop3, Area: $area3 ha');

 double calculateTotalArea(double first, double second, double third) {
  return first + second + third;
}

print('Area total: ${calculateTotalArea(area1, area2, area3)} ha');

double calculateAverageArea(double total, int count) {
  return total / count;
}
print('Area promedio: ${calculateAverageArea(calculateTotalArea(area1, area2, area3), 3).toStringAsFixed(2)} ha');

double calculateShare(double cropArea, double totalArea) {
  return cropArea / totalArea * 100;
}

print('Area de $crop1: ${calculateShare(area1, calculateTotalArea(area1, area2, area3)).toStringAsFixed(2)}%');
print('Area de $crop2: ${calculateShare(area2, calculateTotalArea(area1, area2, area3)).toStringAsFixed(2)}%');
print('Area de $crop3: ${calculateShare(area3, calculateTotalArea(area1, area2, area3)).toStringAsFixed(2)}%');

showTitle();
}

