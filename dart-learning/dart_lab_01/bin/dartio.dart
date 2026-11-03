import 'dart:io';

void main() {
  stdout.write('Enter a municipality: ');
  String municipality = stdin.readLineSync() ?? '';

  print('Selected municipality: $municipality');
}