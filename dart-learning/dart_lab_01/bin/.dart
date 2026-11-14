import 'dart:io';

// Cálculos (devuelven resultados)
double calculoDeNoches(int noches, double costoPorNoche) {
  return noches * costoPorNoche;
}

double calculoDeAlimentacion(int viajeros, int dias, double comidaDiariaPorPersona) {
  return viajeros * dias * comidaDiariaPorPersona;
}

double calculoDePresupuesto(double transporte, double alojamiento, double alimentacion) {
  return transporte + alojamiento + alimentacion;
}

double calculoPorViajero(double presupuesto, int viajeros) {
  return presupuesto / viajeros;
}

double calculoParte(double parte, double total) {
  return parte / total * 100;
}

//Presentación-
void showReport({
  required String destino,
  required int viajeros,
  required int dias,
  required int noches,
  required double transporte,
  required double alojamiento,
  required double alimentacion,
  required double presupuesto,
  required double porViajero,
  required double transporteSobreTotal,
}) {
  print('============================');
  print('   PRESUPUESTO DE EXCURSIÓN');
  print('============================');
  print('Destino: $destino');
  print('Viajeros: $viajeros');
  print('Días: $dias');
  print('Noches: $noches');
  print('----------------------------');
  print('Transporte: ${transporte.toStringAsFixed(2)}');
  print('Alojamiento: ${alojamiento.toStringAsFixed(2)}');
  print('Alimentación: ${alimentacion.toStringAsFixed(2)}');
  print('----------------------------');
  print('Presupuesto general: ${presupuesto.toStringAsFixed(2)}');
  print('Valor por persona: ${porViajero.toStringAsFixed(2)}');
  print('Transporte sobre el total: ${transporteSobreTotal.toStringAsFixed(2)}%');
}

void main() {
  stdout.write('Destino: ');
  String destino = stdin.readLineSync() ?? '';

  stdout.write('Cantidad de viajeros: ');
  int viajeros = int.parse(stdin.readLineSync() ?? '');

  stdout.write('Días de viaje: ');
  int dias = int.parse(stdin.readLineSync() ?? '');

  stdout.write('Noches de alojamiento: ');
  int noches = int.parse(stdin.readLineSync() ?? '');

  stdout.write('Costo total de transporte: ');
  double transporte = double.parse(stdin.readLineSync() ?? '');

  stdout.write('Costo de alojamiento por noche (todo el grupo): ');
  double costoPorNoche = double.parse(stdin.readLineSync() ?? '');

  stdout.write('Costo diario de alimentación por persona: ');
  double comidaDiariaPorPersona = double.parse(stdin.readLineSync() ?? '');

  double noche = calculoDeNoches(noches, costoPorNoche);
  double comida = calculoDeAlimentacion(viajeros, dias, comidaDiariaPorPersona);
  double presupuesto = calculoDePresupuesto(transporte, noche, comida);
  double porViajero = calculoPorViajero(presupuesto, viajeros);
  double transporteSobreTotal = calculoParte(transporte, presupuesto);

  showReport(
    destino: destino,
    viajeros: viajeros,
    dias: dias,
    noches: noches,
    transporte: transporte,
    alojamiento: noche,
    alimentacion: comida,
    presupuesto: presupuesto,
    porViajero: porViajero,
    transporteSobreTotal: transporteSobreTotal,
  );
}