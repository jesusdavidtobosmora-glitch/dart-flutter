import 'dart:io';
void showTitle() {
  print('============================');
  print('     AGRICULTURAL REPORT');
  print('============================');
 }
void main() {
    showTitle();
  String department;
  String municipality;
  int observationYear;

  stdout.write('Enter a department: ');
  department = stdin.readLineSync() ?? '';

  stdout.write('Enter a municipality: ');
  municipality = stdin.readLineSync() ?? '';

  stdout.write('Enter observation year: ');
  String yearText = stdin.readLineSync() ?? '';
  observationYear = int.parse(yearText);

  print('Selected department: $department');
  print('Selected municipality: $municipality');
  print('Year: $observationYear');

  String crop1;
  double area1;
  String crop2;
  double area2;
  String crop3;
  double area3;

  stdout.write('Enter first crop: ');
  crop1 = stdin.readLineSync() ?? '';

  stdout.write('Enter area for $crop1 (ha): ');
  String area1Text = stdin.readLineSync() ?? '';
  area1 = double.parse(area1Text);
    
  stdout.write('Enter second crop: ');
  crop2 = stdin.readLineSync() ?? '';

  stdout.write('Enter area for $crop2 (ha): ');
  String area2Text = stdin.readLineSync() ?? '';
  area2 = double.parse(area2Text);

  stdout.write('Enter third crop: ');
  crop3 = stdin.readLineSync() ?? '';

  stdout.write('Enter area for $crop3 (ha): ');
  String area3Text = stdin.readLineSync() ?? '';
  area3 = double.parse(area3Text);

    print('Crop 1: $crop1, Area: $area1 ha');
    print('Crop 2: $crop2, Area: $area2 ha');
    print('Crop 3: $crop3, Area: $area3 ha');

 double calculateTotalArea(double first, double second, double third) {
  return first + second + third;
}

print('Total area: ${calculateTotalArea(area1, area2, area3)} ha');

double calculateAverageArea(double total, int count) {
  return total / count;
}
print('Average area: ${calculateAverageArea(calculateTotalArea(area1, area2, area3), 3).toStringAsFixed(2)} ha');

double calculateShare(double cropArea, double totalArea) {
  return cropArea / totalArea * 100;
}

print('Share of $crop1: ${calculateShare(area1, calculateTotalArea(area1, area2, area3)).toStringAsFixed(2)}%');
print('Share of $crop2: ${calculateShare(area2, calculateTotalArea(area1, area2, area3)).toStringAsFixed(2)}%');
print('Share of $crop3: ${calculateShare(area3, calculateTotalArea(area1, area2, area3)).toStringAsFixed(2)}%');

showTitle();
}

