
import 'dart:io';

void main() {
  // Cinema configuration
  const int capacity = 40;
  const int generalPrice = 18000;
  const int studentPrice = 12000;

  // Sales information
  int soldGeneral = 0;
  int soldStudent = 0;
  double totalRevenue = 0.0;

  // Main menu
  while (true) {
    print('=== CINEMA TICKET SYSTEM ===');
    print('1. Sell tickets');
    print('2. View sales summary');
    print('0. Exit');

    stdout.write('Select an option: ');
    String? input = stdin.readLineSync();

    int? option = int.tryParse(input ?? '');

    if (option == null) {
      print('Please enter a valid number.');
      continue;
    }

    switch (option) {
      case 1:
        // Check available seats
        int availableSeats = capacity - soldGeneral - soldStudent;

        if (availableSeats == 0) {
          print('Sorry, all seats are sold out.');
          break;
        }

        print('=== SELL TICKETS ===');
        print('1. General - 18,000');
        print('2. Student - 12,000');

        // Validate ticket type
        int ticketType = 0;

        while (true) {
          stdout.write('Select ticket type: ');
          String? ticketInput = stdin.readLineSync();

          int? parsedType = int.tryParse(ticketInput ?? '');

          if (parsedType != null &&
              (parsedType == 1 || parsedType == 2)) {
            ticketType = parsedType;
            break;
          }

          print('Invalid ticket type. Choose 1 or 2.');
        }

        // Validate ticket quantity
        int quantity = 0;

        while (true) {
          stdout.write('How many tickets do you want? ');
          String? quantityInput = stdin.readLineSync();

          int? parsedQuantity = int.tryParse(quantityInput ?? '');

          if (parsedQuantity != null && parsedQuantity > 0) {
            quantity = parsedQuantity;
            break;
          }

          print('Enter a valid positive quantity.');
        }

        // Check ticket availability
        if (quantity > availableSeats) {
          print('Not enough seats available.');
          print('Available seats: $availableSeats');
          break;
        }

        // Calculate ticket price
        int price = 0;

        if (ticketType == 1) {
          price = generalPrice;
        } else {
          price = studentPrice;
        }

        // Calculate sale total
        int saleTotal = price * quantity;

        // Update sales counters
        if (ticketType == 1) {
          soldGeneral += quantity;
        } else {
          soldStudent += quantity;
        }

        // Update total revenue
        totalRevenue += saleTotal;

        print('Sale completed!');
        print('Tickets purchased: $quantity');
        print('Total to pay: \$${saleTotal}');

        break;

      case 2:
        // Calculate sales summary
        int soldTotal = soldGeneral + soldStudent;
        int availableSeats = capacity - soldTotal;

        print('=== SALES SUMMARY ===');
        print('Initial capacity: $capacity');
        print('Tickets sold: $soldTotal');
        print('Available seats: $availableSeats');
        print('General tickets sold: $soldGeneral');
        print('Student tickets sold: $soldStudent');
        print('Total revenue: ${totalRevenue.toStringAsFixed(0)}');

        break;

      case 0:
        print('Goodbye!');
        return;

      default:
        print('Invalid option.');
    }
  }
}
