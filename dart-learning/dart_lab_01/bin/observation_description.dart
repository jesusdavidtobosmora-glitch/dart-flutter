import 'dart:io';

void main() {
    /*Debe solicitar:

Departamento.
Municipio.
Cultivo.
Año.
Área sembrada en hectáreas.*/

  stdout.write('Ingresa el departamento: ');
  String department = stdin.readLineSync() ?? '';

  stdout.write('Ingresa el municipio: ');
  String municipality = stdin.readLineSync() ?? '';

  stdout.write('Ingresa el cultivo: ');
  String crop = stdin.readLineSync() ?? '';

  stdout.write('Ingresa el año: ');
  String yearText = stdin.readLineSync() ?? '';
  int observationYear = int.parse(yearText);

  stdout.write('Ingresa el área sembrada (ha): ');
  String areaText = stdin.readLineSync() ?? '';
  double plantedArea = double.parse(areaText);

  print('Departamento: $department');
  print('Municipio: $municipality');
  print('Cultivo: $crop');
  print('Year: $observationYear');
  print('Area: $plantedArea ha');

//Explica la diferencia entre mostrar un dato con print y recibirlo con stdin.readLineSync(). ¿Por qué utilizas int.parse o double.parse antes de calcular? ¿Qué problema podría ocasionar una entrada numérica inválida?

//La diferencia entre mostrar un dato con print y recibirlo con stdin.readLineSync() es que print se utiliza para mostrar información en la consola, mientras que stdin.readLineSync() se utiliza para recibir entrada del usuario desde la consola.
//Se utiliza int.parse o double.parse antes de calcular para convertir la entrada del usuario, que es una cadena de texto, en un número entero o decimal, respectivamente. Esto es necesario para poder realizar operaciones matemáticas con esos valores.
//Un problema que podría ocasionar una entrada numérica inválida es que si el usuario ingresa un valor que no se puede convertir a un número (por ejemplo, letras o símbolos), el programa lanzará una excepción y se detendrá.
}