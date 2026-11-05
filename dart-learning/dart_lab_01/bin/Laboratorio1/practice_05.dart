void showTitle() {
  print('============================');
  print('     AGRICULTURAL REPORT');
  print('============================');
 }

void main() {
  showTitle();
  print('First observation');
  showTitle();


void showCrop(String crop, double plantedArea) {
  print('Crop: $crop');
  print('Area: $plantedArea ha');
 }

  showCrop('Coffee', 125.5);
  showCrop('Plantain', 74.5);


double calculateTotalArea(double firstArea, double secondArea) {
  return firstArea + secondArea;

 }

  double total = calculateTotalArea(125.5, 74.5);

  print(total);

  void showTotalArea(double firstArea, double secondArea) {
  print(firstArea + secondArea);
}
double calculateShare(double cropArea, double totalArea) {
  return cropArea / totalArea * 100;
}

 double share = calculateShare(50.0, 250.0);
  print(share.toStringAsFixed(1));

double calculateAverage(double totalArea, int cropCount) {
  double result = totalArea / cropCount;
  return result;
}


  double average = calculateAverage(250.0, 3);

  print(average.toStringAsFixed(2));

  double calculateTotalAreas(double first, double second, double third) {
  return first + second + third;
}

  double totalArea = calculateTotalAreas(120.0, 80.0, 50.0);
  print(totalArea.toStringAsFixed(2));

 calculateAverageArea(double total, int count) {
  return total / count;
   }
  print(calculateAverageArea(250.0, 3).toStringAsFixed(2));

 showObservation(String municipality, String crop, double area) {
  print('Municipality: $municipality');
  print('Crop: $crop');
  print('Area: $area ha');
 }

  showObservation('San Pedro', 'Coffee', 125.5);
}

//error

double calculateTotal(double first, double second) {
  double total = first + second;
  return total;
}

void main() {
  print(calculateTotal(20.0, 30.0));
}