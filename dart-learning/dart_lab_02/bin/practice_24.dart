
import 'dart:io';

void main() {
  // Repetir sin duplicar código
  print('Repetir sin duplicar código:');
  for (int index = 1; index <= 3; index++) {
    print('Observation $index');
  }

  // Controladores y acumuladores
  print('Controladores y acumuladores:');
  int processedCrops = 0;
  double totalArea = 0.0;

  for (int index2 = 1; index2 <= 4; index2++) {
    processedCrops++;
    totalArea += 12.5;
  }

  print('Crops: $processedCrops');
  print('Total area: $totalArea ha');

  // Leer varias superficies desde la terminal
  print('Leer varias superficies desde la terminal:');
  double totalArea2 = 0.0;

  for (int index3 = 1; index3 <= 3; index3++) {
    stdout.write('Area for crop $index3 (ha): ');
    double area = double.parse(stdin.readLineSync() ?? '');
    totalArea2 += area;
  }

  String formattedTotal = totalArea2.toStringAsFixed(2);
  print('Total area: $formattedTotal ha');

  // Promedio
  print('Promedio:');
  const int cropCount = 4;
  double totalArea3 = 0.0;

  for (int index4 = 1; index4 <= cropCount; index4++) {
    totalArea3 += 12.5;
  }

  double averageArea = totalArea3 / cropCount;

  print('Total area: $totalArea3');
  print('Average area: $averageArea');

  // Encontrar el mayor valor
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

  // Terminar u omitir una iteración
  print('Terminar u omitir una iteración:');
  for (int index6 = 1; index6 <= 5; index6++) {
    if (index6 == 2) {
      continue;
    }

    if (index6 == 5) {
      break;
    }

    print(index6);
  }

  // Un error en el límite
  print('Un error en el límite:');
  int cropCount2 = 3;
  int processed = 0;

  for (int index = 1; index <= cropCount2; index++) {
    processed++;
  }

  print(processed);

  // Reto registro con cantidad variable
  int cropCount3 = 0;
  double totalArea4 = 0.0;
  double largestArea2 = 0.0;

  stdout.write('Ingresa la cantidad de cultivos (1-5): ');
  cropCount3 = int.parse(stdin.readLineSync() ?? '');

  for (int index7 = 1; index7 <= cropCount3; index7++) {
    stdout.write('Ingresa la superficie para el cultivo $index7 (ha): ');
    double areaCultivo = double.parse(stdin.readLineSync() ?? '');
    totalArea4 += areaCultivo;

    if (areaCultivo > largestArea2) {
      largestArea2 = areaCultivo;
    }
  }

  double averageArea2 = totalArea4 / cropCount3;

  print('Crops processed: $cropCount3');
  print('Total area: ${totalArea4.toStringAsFixed(2)} ha');
  print('Average area: ${averageArea2.toStringAsFixed(2)} ha');
  print('Largest area: ${largestArea2.toStringAsFixed(2)} ha');
}
