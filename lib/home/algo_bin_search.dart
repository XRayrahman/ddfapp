// import 'dart:math';

import 'package:flutter/foundation.dart';

void main() {
  // Define the dimensions of the array
  const int rows = 20;
  const int columns = 10;

  // Create a sorted array
  var array = List.generate(
      rows, (i) => List.generate(columns, (j) => i * columns + j + 1));
  if (kDebugMode) {
    print(array);
  }

  // Flatten the array into a one-dimensional list
  var flatArray = array.expand((i) => i).toList();

  // Sort the array
  flatArray.sort();

  // Perform a binary search for the value 6
  var index = binarySearch(flatArray, 200);

  // Convert the index into 2-dimensional coordinates
  var row = index ~/ columns;
  var column = index % columns;

  if (kDebugMode) {
    print("Found value 77 at array[$row][$column]");
  }
}

int binarySearch(List<int> array, int value) {
  var low = 0;
  var high = array.length - 1;
  while (low <= high) {
    var mid = (low + high) ~/ 2;
    if (array[mid] == value) {
      return mid;
    } else if (array[mid] < value) {
      low = mid + 1;
    } else {
      high = mid - 1;
    }
  }
  return -1;
}
