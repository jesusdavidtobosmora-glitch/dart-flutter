// Reto de aplicación - Procesador de pedidos de una librería.
//
// Ejecutar desde la raíz del proyecto:
//   dart run bin/bookstore_cli.dart            (compact por defecto)
//   dart run bin/bookstore_cli.dart detailed
import 'dart:io';

import 'package:dart_lab_05/bookstore.dart';

const String sourcePath = 'data/orders.json';
const String outputPath = 'data/normalized_orders.json';

void main(List<String> arguments) {
  OrderFormatter? formatter = selectOrderFormatter(arguments);

  if (formatter == null) {
    stderr.writeln('Uso: dart run bin/bookstore_cli.dart [compact|detailed]');
    exitCode = 2;
    return;
  }

  File sourceFile = File(sourcePath);
  File outputFile = File(outputPath);
  OrderJsonCodec codec = OrderJsonCodec();

  try {
    List<Order> orders = codec.decodeOrders(sourceFile.readAsStringSync());

    double grandTotal = orders.fold<double>(
      0.0,
      (sum, order) => sum + order.total,
    );

    if (!grandTotal.isFinite) {
      throw FormatException('El total de ventas no es finito.');
    }

    print('Pedidos válidos: ${orders.length}');

    if (orders.isEmpty) {
      print('No hay pedidos disponibles.');
    } else {
      for (final order in orders) {
        print(formatter.formatOrder(order));
      }
      print(formatter.formatGrandTotal(grandTotal));
    }

    // Se escribe solo después de validar todo; nunca sobre el archivo de origen.
    outputFile.writeAsStringSync(codec.encodeOrders(orders));
    print('Archivo normalizado escrito: ${outputFile.path}');
  } on FileSystemException catch (error) {
    stderr.writeln('Error de archivo: ${error.message} (${error.path})');
    exitCode = 1;
  } on FormatException catch (error) {
    stderr.writeln('Datos de pedido inválidos: ${error.message}');
    exitCode = 1;
  }
}
