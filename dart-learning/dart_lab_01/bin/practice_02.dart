void main() {
  String municipality = 'Andes';
  String crop = 'Coffee';
  int observationYear = 2025;
  double plantedArea = 125.5;
  bool isPreliminary = true;

  print(municipality);
  print(crop);
  print(observationYear);
  print(plantedArea);
  print(isPreliminary);

//Cambio de valor
  print(plantedArea);

  plantedArea = 130.0;

  print(plantedArea);

//Prueba cambio
  int cropCount = 3;
  cropCount = 4;

  print(cropCount);


//Ejercicio hectareas 
 num superficie = 80;
 print(superficie);
 superficie = 82.5;
 print(superficie);

//Interferencia Var
  var department = 'Antioquia';
  var cropt = 3;
  var averageArea = 42.5;

  print(department.runtimeType);
  print(cropt.runtimeType);
  print(averageArea.runtimeType);

//Prueba contenedor de cualquier tipo

  var municipa = 'Andes';
  municipa = '2025';
  print(municipa);

//Final y const
 final municipal = 'Andes';
  const areaUnit = 'ha';

  print(municipal);
  print(areaUnit);
  final startedAt = DateTime.now();
  const reportTitle = 'Agricultural observation';

  print(startedAt);
  print(reportTitle);
  String? optionalNote;

  print(municipality);
  print(optionalNote);

  var cropar = 'Beans';
  double area = 12.5;

  print(cropar);
  print(area);

cropar = 'Corn';
  area = 20.0;

  print(crop);
  print(area);

//Declara y muestra department, municipality, crop, observationYear, plantedArea y isPreliminary. Elige tipos apropiados y modifica al 
string department = 'Antioquia';
  String municipality = 'Andes';
  String crop = 'Coffee';
  int observationYear = 2025;
  double plantedArea = 125.5;
  bool isPreliminary = true;

  print(department);
  print(municipality);
  print(crop);
  print(observationYear);
  print(plantedArea);
  print(isPreliminary);

  const String areaUnit = 'ha';
  final DateTime startedAt = DateTime.now();  

}