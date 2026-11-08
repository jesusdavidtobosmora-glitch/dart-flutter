 void main() {
  
  int a = 10;
  int b = 3;

  print(a + b);
  print(a - b);
  print(a * b);
  print(a / b);
  print(a ~/ b);
  print(a % b);

  double coffeeArea = 125.5;
  double plantainArea = 74.5;
  double avocadoArea = 50.0;

  double totalArea = coffeeArea + plantainArea + avocadoArea;

  print(totalArea);
  
  coffeeArea = 125.0;
  double coffeeShare = coffeeArea / totalArea * 100;

  print(coffeeShare);

//Ordenar operadores

  print(10 + 5 * 2);
  print((10 + 5) * 2);

//enteros, decimales y conversionales
  int espacios = 3;
  double areaTotal = 75.0;

  double averageArea = areaTotal / espacios;

  print(averageArea);
  print(averageArea.toStringAsFixed(2));

  String areaText = '125.5';
  double plantedArea = double.parse(areaText);

  print(plantedArea + 10.0);


//Depurar error
  double firstArea = 20.0;
  double secondArea = 30.0;

  averageArea = (firstArea + secondArea) / 2;

  print(averageArea);

  double PrimeraArea = 120.0;
  double SegundaArea = 80.0;
  double TerceraArea = 50.0;
  double totaldelasAreas = PrimeraArea + SegundaArea + TerceraArea;
  print (totaldelasAreas.toStringAsFixed(2));

  double promedioCultivos = totaldelasAreas / 3;
  print(promedioCultivos.toStringAsFixed(2));

  double participacionPrimeraArea = PrimeraArea / totaldelasAreas * 100;
  print(participacionPrimeraArea);
  }