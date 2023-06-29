// import 'package:fluent_ui/fluent_ui.dart';
import 'dart:typed_data';

import 'package:get/get.dart';

class SideController extends GetxController {
  var readRPM = 0.obs;
  var readTPS = 0.obs;
  var readMAP = 0.obs;
  var readTEMP = 0.obs;
  var ports = [].obs;
  var isConnected = false.obs;

  List<int> byteToInt(Uint8List value) {
    String hexString =
        value.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join(',');

    List<String> listString = hexString.split(",");
    List<String> transformedList = [];
    // print(listString);

    for (int i = 0; i < listString.length; i += 2) {
      if (i + 1 < listString.length) {
        String combinedValue = listString[i + 1] + listString[i];
        transformedList.add(combinedValue);
      }
    }

    List<int> intList = [];

    for (String hexValue in transformedList) {
      int intValue = int.parse(hexValue, radix: 16);
      intList.add(intValue);
    }
    return intList;
  }
}
