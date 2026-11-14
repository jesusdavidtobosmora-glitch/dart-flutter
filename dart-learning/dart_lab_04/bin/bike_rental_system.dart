import 'dart:io';

class Bicycle {
  final String id;
  final String description;
  final double hourlyRate;
  bool _available = true;

  Bicycle({
    required String id,
    required String description,
    required this.hourlyRate,
  })  : id = id.trim().toUpperCase(),
        description = description.trim() {
    if (this.id.isEmpty) {
      throw ArgumentError.value(id, 'id', 'Identifier is required.');
    }
    if (this.description.isEmpty) {
      throw ArgumentError.value(description, 'description', 'Description is required.');
    }
    if (!hourlyRate.isFinite || hourlyRate <= 0) {
      throw ArgumentError.value(hourlyRate, 'hourlyRate', 'Rate must be positive and finite.');
    }
  }

  bool get isAvailable => _available;

  bool _startRental() {
    if (!_available) return false;
    _available = false;
    return true;
  }

  void _finishRental() {
    _available = true;
  }
}

class Rental {
  final String id;
  final Bicycle bicycle;
  final String customerName;
  final DateTime startedAt;
  double? _hours;
  double? _amount;

  Rental({
    required this.id,
    required this.bicycle,
    required String customerName,
  })  : customerName = customerName.trim(),
        startedAt = DateTime.now() {
    if (this.customerName.isEmpty) {
      throw ArgumentError.value(customerName, 'customerName', 'Customer name is required.');
    }
  }

  bool get isActive => _hours == null;
  double? get hours => _hours;
  double? get amount => _amount;

  bool finish(double hours) {
    if (!isActive || !hours.isFinite || hours <= 0) return false;
    final amount = hours * bicycle.hourlyRate;
    if (!amount.isFinite) return false;
    _hours = hours;
    _amount = amount;
    bicycle._finishRental();
    return true;
  }
}

class RentalManager {
  final Map<String, Bicycle> _bicycles = {};
  final Map<String, Rental> _rentals = {};
  int _nextRentalNumber = 1;

  bool addBicycle(Bicycle bicycle) {
    final key = bicycle.id.toUpperCase();
    if (_bicycles.containsKey(key)) return false;
    _bicycles[key] = bicycle;
    return true;
  }

  bool startRental(String bicycleId, String customerName) {
    final bicycle = _bicycles[bicycleId.trim().toUpperCase()];
    if (bicycle == null || !bicycle.isAvailable || customerName.trim().isEmpty) {
      return false;
    }
    if (!bicycle._startRental()) return false;

    final rentalId = 'R${_nextRentalNumber.toString().padLeft(4, '0')}';
    _nextRentalNumber++;
    _rentals[rentalId] = Rental(
      id: rentalId,
      bicycle: bicycle,
      customerName: customerName,
    );
    return true;
  }

  bool finishRental(String rentalId, double hours) {
    final rental = _rentals[rentalId.trim().toUpperCase()];
    if (rental == null) return false;
    return rental.finish(hours);
  }

  List<Bicycle> get bicycles =>
      List<Bicycle>.unmodifiable(_bicycles.values.toList());

  List<Rental> get rentals =>
      List<Rental>.unmodifiable(_rentals.values.toList());

  List<Bicycle> get availableBicycles =>
      List<Bicycle>.unmodifiable(_bicycles.values.where((b) => b.isAvailable).toList());

  List<Rental> get activeRentals =>
      List<Rental>.unmodifiable(_rentals.values.where((r) => r.isActive).toList());

  List<Rental> get completedRentals =>
      List<Rental>.unmodifiable(_rentals.values.where((r) => !r.isActive).toList());

  double get totalRevenue => completedRentals.fold(
        0.0,
        (total, rental) => total + (rental.amount ?? 0.0),
      );
}

String? readText(String prompt) {
  stdout.write(prompt);
  final value = stdin.readLineSync();
  if (value == null) return null;
  if (value.trim().isEmpty) {
    print('Value cannot be empty.');
    return readText(prompt);
  }
  return value.trim();
}

double? readPositiveNumber(String prompt) {
  while (true) {
    stdout.write(prompt);
    final line = stdin.readLineSync();
    if (line == null) return null;
    final value = double.tryParse(line.trim());
    if (value != null && value.isFinite && value > 0) return value;
    print('Enter a positive finite number.');
  }
}

void main() {
  final manager = RentalManager();
  manager.addBicycle(Bicycle(id: 'B-01', description: 'Mountain bike', hourlyRate: 8000));
  manager.addBicycle(Bicycle(id: 'B-02', description: 'City bike', hourlyRate: 6000));

  while (true) {
    print('\nBIKE RENTAL SYSTEM');
    print('1. Register bicycle');
    print('2. Start rental');
    print('3. Finish rental');
    print('4. Show bicycles');
    print('5. Show rentals and revenue');
    print('0. Exit');
    final optionText = readText('Option: ');
    if (optionText == null || optionText == '0') return;

    switch (optionText) {
      case '1':
        final id = readText('Bicycle ID: ');
        if (id == null) return;
        final description = readText('Description: ');
        if (description == null) return;
        final rate = readPositiveNumber('Hourly rate: ');
        if (rate == null) return;
        final added = manager.addBicycle(
          Bicycle(id: id, description: description, hourlyRate: rate),
        );
        print(added ? 'Bicycle registered.' : 'Identifier already exists.');
      case '2':
        final id = readText('Bicycle ID: ');
        if (id == null) return;
        final customer = readText('Customer name: ');
        if (customer == null) return;
        print(manager.startRental(id, customer)
            ? 'Rental started.'
            : 'Cannot start rental. Check bicycle and customer.');
      case '3':
        final id = readText('Rental ID: ');
        if (id == null) return;
        final hours = readPositiveNumber('Duration in hours: ');
        if (hours == null) return;
        print(manager.finishRental(id, hours)
            ? 'Rental completed.'
            : 'Rental not found, already completed, or duration invalid.');
      case '4':
        for (final bike in manager.bicycles) {
          print('${bike.id} | ${bike.description} | ${bike.hourlyRate} per hour | '
              '${bike.isAvailable ? 'Available' : 'Rented'}');
        }
      case '5':
        print('Active rentals:');
        for (final rental in manager.activeRentals) {
          print('${rental.id} | ${rental.bicycle.id} | ${rental.customerName}');
        }
        print('Completed rentals:');
        for (final rental in manager.completedRentals) {
          print('${rental.id} | ${rental.hours} hours | ${rental.amount}');
        }
        print('Total revenue: ${manager.totalRevenue.toStringAsFixed(2)}');
      default:
        print('Unknown option.');
    }
  }
}
