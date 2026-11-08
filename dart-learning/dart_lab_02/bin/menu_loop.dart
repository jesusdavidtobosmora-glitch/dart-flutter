import 'dart:io';

void main() {
  while (true) {
    print('1. Say hello');
    print('0. Exit');
    stdout.write('Option: ');

    String? option = stdin.readLineSync();

    if (option == null) {
      print('Input ended.');
      return;
    }

    switch (option.trim()) {
      case '1':
        print('Hello!');
      case '0':
        print('Goodbye!');
        return;
      default:
        print('Unknown option.');
    }
  }
}