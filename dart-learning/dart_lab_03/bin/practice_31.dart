double calculateShare(double cropArea, double totalArea) {
  if (totalArea <= 0) return 0.0;
  return cropArea / totalArea * 100;
}

double calculateTotal(double first, double second) => first + second;

void showObservation({
  required String municipality,
  required int year,
  String unit = 'ha',
  bool preliminary = false,
}) {
  print('Municipality: $municipality');
  print('Year: $year');
  print('Unit: $unit');
  print('Preliminary: $preliminary');
}

double calculateAverage(double total, int count) {
  if (count <= 0) return 0.0;
  return total / count;
}

double doubleArea(double area) => area * 2;

double calculateTotalArea(List<double> areas) {
  double total = 0.0;
  for (final area in areas) {
    total += area;
  }
  return total;
}

double calculateAverageArea(List<double> areas) {
  if (areas.isEmpty) return 0.0;
  return calculateTotalArea(areas) / areas.length;
}

void showSummary({
  required String municipality,
  required double total,
  required double average,
}) {
  print('Municipality: $municipality');
  print('Total area: ${total.toStringAsFixed(2)} ha');
  print('Average area: ${average.toStringAsFixed(2)} ha');
}

void main() {
  print('=== PRACTICE 3.1 ===');

  print('Share: ${calculateShare(75.0, 300.0).toStringAsFixed(2)}%');
  print('Share with zero total: ${calculateShare(75.0, 0.0)}');

  final firstTotal = calculateTotal(30.0, 20.0);
  final secondTotal = calculateTotal(10.0, 5.0);
  print('Sum of returned totals: ${firstTotal + secondTotal}');

  showObservation(municipality: 'Andes', year: 2025);
  showObservation(
    year: 2024,
    municipality: 'La Mesa',
    unit: 'hectares',
    preliminary: true,
  );

  print('Average: ${calculateAverage(45.0, 3)}');
  print('Double area: ${doubleArea(12.5)}');

  final areasOne = <double>[20.0, 30.0];
  final areasTwo = <double>[10.0, 20.0, 30.0];

  showSummary(
    municipality: 'Andes',
    total: calculateTotalArea(areasOne),
    average: calculateAverageArea(areasOne),
  );
  showSummary(
    municipality: 'La Mesa',
    total: calculateTotalArea(areasTwo),
    average: calculateAverageArea(areasTwo),
  );

  // Correct relation: individual area / total area.
  print('Corrected share: ${calculateShare(50.0, 200.0)}%');
}
