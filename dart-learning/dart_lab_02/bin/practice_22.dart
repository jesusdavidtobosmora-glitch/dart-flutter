import 'dart:io';
void main() {

//Decisiones
print('Decisiones:');
  double area = -2.0;

  if (area >= 0) {
    print('Area is non-negative.');
  } else {
    print('Area cannot be negative.');
  }

//Leer nombre y comprobarlo 
print('Leer nombre y comprobarlo:');
  stdout.write('Municipality: ');
  String municipality = (stdin.readLineSync() ?? '').trim();

  if (municipality.isEmpty) {
    print('Municipality is required.');
  } else {
    print('Municipality: $municipality');
  }

//Varias decisiones y prioridad
print('Varias decisiones y prioridad:');
  double largestShare = 62.5;

  if (largestShare >= 75) {
    print('Very high share.');
  } else if (largestShare >= 50) {
    print('High share.');
  } else if (largestShare >= 25) {
    print('Moderate share.');
  } else {
    print('Low share.');
  }

//Proteger una división
print('Proteger una división:');
  double cropArea = 40.0;
  double totalArea = 100.0;

  if (totalArea > 0) {
    double share = cropArea / totalArea * 100;
    String formattedShare = share.toStringAsFixed(2);
    print('Share: $formattedShare%');
  } else {
    print('Total area must be positive.');
  }

  //Condiciones anidadas y condiciones compuestas
  print('Condiciones anidadas y condiciones compuestas:');
  String municipality2 = 'Andes';
  double area2 = 30.0;

  if (municipality2.isNotEmpty) {
    if (area2 > 0) {
      print('Accepted.');
    }
  }

//Punto y coma
  double area3 = -1;

  if (area3 > 0);
  {
    print('Area accepted.');
  }

//Reto clasificación con función
print ('Reto clasificación con función:');
double share = 62.5;
String classifyShare(double share)
{

  if (share >= 75) {
    return 'Su puntuación es muy alta.';
  } else if (share >= 50) {
    return 'Su puntuación es alta.';
  } else if (share >= 25) {
    return 'Su puntuación es moderada.';
  } else if (share >= 0) {
    return 'Su puntuación es baja.';
  } else if (share.isFinite && share < 0) {
    return 'Su puntuación es inválida.';
  } else {
    return 'Puntuación inválida.';
  }
}
print(classifyShare(share));
}