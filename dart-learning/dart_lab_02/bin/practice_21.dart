void main() {

//Comparar, no asignar
print('Comparaciones:');
  double cropArea = 75.0;
  double totalArea = 250.0;

  print(cropArea > 100.0);
  print(cropArea < totalArea);
  print(cropArea == totalArea);
  print(cropArea != totalArea);
  print(cropArea >= 75.0);
  print(cropArea <= 74.0);

//Guardar el resultado de la comparación
print('Guardar el resultado de la comparación:');
  double area = 150.0;

  bool isPositive = area > 0;
  bool isAtLeastOneHundred = area >= 100;

  print('Positive: $isPositive');
  print('At least 100 ha: $isAtLeastOneHundred');

//Igualdad de cadenas
print('Igualdad de cadenas:');
  String firstCrop = 'Coffee';
  String secondCrop = 'coffee';

  print(firstCrop == secondCrop);
  print(firstCrop.toLowerCase() == secondCrop.toLowerCase());

//Combinar condciones
print('Combinar condciones:');
  double area2 = 120.0;
  int year = 2025;
  bool isPreliminary = false;

  bool meetsBoth = area2 > 0 && year >= 2000;
  bool requiresReview = area2 <= 0 || isPreliminary;
  bool isFinal = !isPreliminary;

  print(meetsBoth);
  print(requiresReview);
  print(isFinal);

//Laboratorio de errores
  int observationYear = 2025;
  bool matchesYear = observationYear == 2025;
  

  print(matchesYear);

//Registro utilizable
print('Registro utilizable:');
  String municipality = 'Armenia';
  double plantedArea = 100.0;
  double observationYear2 = 2025;

  bool isUsable = municipality == 'armenia';
  print(isUsable);
  isUsable = plantedArea >= 0;
  print(isUsable);
  isUsable = observationYear2 > 0;
  print(isUsable);
}