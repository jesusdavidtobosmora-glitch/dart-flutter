
import 'dart:io';

void main() {
  String municipality = 'Andes';
  String crop = 'Coffee';
  double plantedArea = 125.5;

  print('Municipality: $municipality');
  print('Crop: $crop');
  print('Planted area: $plantedArea ha');

  print(crop.toUpperCase());
  print(crop.toLowerCase());
  print(crop.length);

  stdout.write('Enter a municipality: ');
  municipality = stdin.readLineSync() ?? '';

  print('Selected municipality: $municipality');

  stdout.write('Enter observation year: ');
  String yearText = stdin.readLineSync() ?? '';
  int observationYear = int.parse(yearText);

  stdout.write('Enter planted area (ha): ');
  String areaText = stdin.readLineSync() ?? '';
  plantedArea = double.parse(areaText);

  print('Year: $observationYear');
  print('Area: $plantedArea ha');

  municipality = '  Andes  ';
  String cleanMunicipality = municipality.trim();

  print(municipality);
  print(cleanMunicipality);

}
