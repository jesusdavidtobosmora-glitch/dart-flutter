import 'dart:io';
void main() {
//Repetir sin duplicar código
print('Repetir sin duplicar código:');
  for (int index = 1; index <= 3; index++) {
    print('Observation $index');
  }

//Contoladores y acumuladores
print('Contoladores y acumuladores:');
  int processedCrops = 0;
  double totalArea = 0.0;

  for (int index2 = 1; index2 <= 4; index2++) {
    processedCrops++;
    totalArea += 12.5;
  }

  print('Crops: $processedCrops');
  print('Total area: $totalArea ha');

//Leer varias superficies desde la terminal
print('Leer varias superficies desde la terminal:');
double totalArea2 = 0.0;

  for (int index3 = 1; index3 <= 3; index3++) {
    stdout.write('Area for crop $index3 (ha): ');
    double area = double.parse(stdin.readLineSync() ?? '');
    totalArea2 += area;
  }

  String formattedTotal = totalArea2.toStringAsFixed(2);
  print('Total area: $formattedTotal ha');

//Promedio
print('Promedio:');
    const int cropCount = 4;
  double totalArea3 = 0.0;

  for (int index4 = 1; index4 <= cropCount; index4++) {
    totalArea3 += 12.5;
  }

  double averageArea = totalArea3 / cropCount;

  print('Total area: $totalArea3');
  print('Average area: $averageArea');

//Encontrar el mayor valor
print('Encontrar el mayor valor:');
double largestArea = 0.0;

  for (int index5 = 1; index5 <= 4; index5++) {
    double currentArea = index5 * 12.5;

    if (currentArea > largestArea) {
      largestArea = currentArea;
    }

    print('Area $index5: $currentArea ha');
  }

  print('Largest area: $largestArea ha');
}
