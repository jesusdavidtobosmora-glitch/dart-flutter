
import 'dart:io';

// 1. Read required text
String? readRequiredText(String prompt) {
  while (true) {
    stdout.write(prompt);

    String? rawInput = stdin.readLineSync();

    if (rawInput == null) {
      print('Input ended.');
      return null;
    }

    String value = rawInput.trim();

    if (value.isNotEmpty) {
      return value;
    }

    print('A non-empty value is required.');
  }
}

// 2. Read an integer within a range
int? readIntInRange(String prompt, int minimum, int maximum) {
  while (true) {
    stdout.write(prompt);

    String? rawInput = stdin.readLineSync();

    if (rawInput == null) {
      print('Input ended.');
      return null;
    }

    int? value = int.tryParse(rawInput.trim());

    if (value != null && value >= minimum && value <= maximum) {
      return value;
    }

    print('Enter an integer from $minimum to $maximum.');
  }
}

// 3. Read a positive finite area
double? readPositiveArea(String prompt) {
  while (true) {
    stdout.write(prompt);

    String? rawInput = stdin.readLineSync();

    if (rawInput == null) {
      print('Input ended.');
      return null;
    }

    double? value = double.tryParse(rawInput.trim());

    if (value != null && value.isFinite && value > 0) {
      return value;
    }

    print('Enter a positive finite area.');
  }
}

// 4. Calculate the percentage share
double calculateShare(double area, double totalArea) {
  return area / totalArea * 100;
}

// 5. Main program
void main() {
  bool hasSummary = false;

  String latestMunicipality = '';
  int latestYear = 0;
  int latestCropCount = 0;
  double latestTotalArea = 0.0;
  double latestLargestArea = 0.0;
  String latestLargestCrop = '';

  while (true) {
    print('\n=== AGRICULTURAL EXPLORER ===');
    print('1. Register observation');
    print('2. View latest summary');
    print('0. Exit');

    int? option = readIntInRange('Option: ', 0, 2);

    if (option == null || option == 0) {
      print('Goodbye!');
      return;
    }

    switch (option) {
      case 1:
        print('\n=== REGISTER OBSERVATION ===');

        String? municipality =
            readRequiredText('Enter municipality: ');

        if (municipality == null) {
          print('Registration cancelled.');
          return;
        }

        int? year = readIntInRange('Enter year: ', 2000, 2100);

        if (year == null) {
          print('Registration cancelled.');
          return;
        }

        int? cropCount =
            readIntInRange('Number of crops (1-5): ', 1, 5);

        if (cropCount == null) {
          print('Registration cancelled.');
          return;
        }

        // Temporary variables for the new observation
        double totalArea = 0.0;
        double largestArea = 0.0;
        String largestCrop = '';

        // Read each crop
        for (int index = 1; index <= cropCount; index++) {
          print('\nCrop $index');

          String? cropName =
              readRequiredText('Enter crop name: ');

          if (cropName == null) {
            print('Registration cancelled.');
            return;
          }

          double? area =
              readPositiveArea('Enter crop area (ha): ');

          if (area == null) {
            print('Registration cancelled.');
            return;
          }

          totalArea += area;

          // Keep the first crop in case of a tie
          if (area > largestArea) {
            largestArea = area;
            largestCrop = cropName;
          }
        }

        // Save the completed observation
        latestMunicipality = municipality;
        latestYear = year;
        latestCropCount = cropCount;
        latestTotalArea = totalArea;
        latestLargestArea = largestArea;
        latestLargestCrop = largestCrop;

        hasSummary = true;

        print('\nObservation registered successfully!');
        break;

      case 2:
        if (!hasSummary) {
          print('\nNo observation has been registered.');
        } else {
          double averageArea =
              latestTotalArea / latestCropCount;

          double largestShare =
              calculateShare(latestLargestArea, latestTotalArea);

          print('\n=== LATEST SUMMARY ===');
          print('Municipality: $latestMunicipality');
          print('Year: $latestYear');
          print('Number of crops: $latestCropCount');
          print('Total area: ${latestTotalArea.toStringAsFixed(2)} ha');
          print('Average area: ${averageArea.toStringAsFixed(2)} ha');
          print('Largest crop: $latestLargestCrop');
          print('Largest crop area: ${latestLargestArea.toStringAsFixed(2)} ha');
          print('Largest crop share: ${largestShare.toStringAsFixed(2)}%');
        }
        break;
    }
  }
}
