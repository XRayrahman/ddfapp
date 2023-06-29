import 'package:flutter/foundation.dart';

void main() {
  // Define the dimensions of the array
  const int rows = 20;
  const int columns = 10;

  // Create an array
  var array = List.generate(
      rows, (i) => List.generate(columns, (j) => i * columns + j + 1));
  if (kDebugMode) {
    print(array);
  }

  // Search for the value 6
  var found = false;
  var row = -1;
  var column = -1;
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < columns; j++) {
      if (array[i][j] == 200) {
        found = true;
        row = i;
        column = j;
        break;
      }
    }
    if (found) {
      break;
    }
  }

  // Print the result
  if (kDebugMode) {
    if (found) {
      print("Found value 6 at array[$row][$column]");
    } else {
      print("Value 6 not found in the array");
    }
  }
}
