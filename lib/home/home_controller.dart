import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var indx = 80.obs;
  var ix = 80.obs;
  RxBool isSended = false.obs;
  var logSended = "";
  var slotData = 80.obs;
  var maxInjectorValue = 65000.obs;
  var baudrate = "115200".obs;
  var maxCOM = "15".obs;
  List loadData = List.generate(80, (index) => "").obs;
  // List intRPM = [].obs;
  List hexInjector = List.generate(80, (index) => "").obs;
  List hexRPM = List.generate(80, (index) => "").obs;
  List hexTPS = List.generate(80, (index) => "").obs;
  // List strRPM = List.generate(80, (index) => "").obs;
  List decINJ = List.generate(
      80,
      (index) => [
            [""]
          ]).obs;
  List decRPM = List.generate(
      80,
      (index) => [
            [""]
          ]).obs;
  List decTPS = List.generate(
      80,
      (index) => [
            // [""]
          ]).obs;
  List listPoint = List.generate(80, (index) => ["", "", ""]).obs;
  Map map = {"injector": 80, "RPM": 8, "TPS": 10};

  onSave(List valueTPS, List valueRPM, List valueInjector) {
    listPoint = List.generate(slotData.value,
        (index) => [valueRPM[index], valueTPS[index], valueInjector[index]]);
    // print(listPoint);
    update();
  }

  logData(var results) {
    List logSplit = [];
    List trySplit = [];
    String tryString = "";
    logSplit = results.toString().split('\n');

    tryString = logSplit[logSplit.length - 1];
    tryString = tryString.replaceAll(RegExp('[^A-Za-z0-9 ]'), ' ');
    trySplit = tryString.toString().split('                             ');

    // return "${logSplit[2]} \n ${logSplit[3]} \n ${logSplit[4]} \n ${trySplit[trySplit.length - 2]} \n ${trySplit[trySplit.length - 1]}";

    return "${logSplit[2]} \n ${logSplit[3]} \n ${logSplit[4]} \n ${trySplit[0]}";
  }

  // onSaveHex(List hexTPS, List hexRPM, List hexInjector) {
  //   // decINJ = hexInjector.map((e) => HEX.decode(e)).toList();
  //   // decRPM = hexRPM.map((y) => HEX.decode(y)).toList();
  //   // decTPS = hexTPS.map((x) => HEX.decode(x)).toList();
  //   // // listPoint = List.generate(80, (index) => [decINJ[index][1]]);
  //   // listPoint = List.generate(
  //   //     80, (index) => [decRPM[index][0], decTPS[index][0], decINJ[index][0]]);
  //   // HEX.decode(hexInjector.map.toString()).toList();
  //   // List<String> strINJ =
  //   //     List.generate(hexInjector.length, (index) => hexInjector[index]);
  //   // // List<nt> intINJ = hexInjector.map((e) => e.toRadixString(16)).toList();
  //   // decINJ = Int64List.fromList(strINJ.map(int.parse).toList());
  //   // // decINJ = hexInjector.map((e) => int.parse(e)).toList();
  //   // List<String> strRPM =
  //   //     List.generate(hexInjector.length, (index) => hexInjector[index]);
  //   // decRPM = Int64List.fromList(strRPM.map(int.parse).toList());

  //   // List<String> strTPS =
  //   //     List.generate(hexInjector.length, (index) => hexInjector[index]);
  //   // decTPS = Int64List.fromList(strTPS.map(int.parse).toList());
  //   // listPoint = List.generate(80, (index) => [decINJ[index][1]]);
  //   listPoint = List.generate(
  //       80, (index) => [hexRPM[index], hexTPS[index], hexInjector[index]]);
  //   update();
  // }

  onDecreaseIndex() {
    indx.value = indx.value - 1;
    hexInjector = List.generate(indx.value, (index) => 0);
    update();
  }

  onSetInjectorValue(var data) {
    for (int i = 0; i < 80; i++) {
      listPoint[i][2] = data;
    }

    update();
  }

  onSetAllDefaultValue() {
    for (int i = 0; i < 80; i++) {
      listPoint[i][2] = "0";
      listPoint[i][1] = i == 0 || (i - 0) % 10 == 0
          ? "100"
          : i == 1 || (i - 1) % 10 == 0
              ? "200"
              : i == 2 || (i - 2) % 10 == 0
                  ? "300"
                  : i == 3 || (i - 3) % 10 == 0
                      ? "400"
                      : i == 4 || (i - 4) % 10 == 0
                          ? "500"
                          : i == 5 || (i - 5) % 10 == 0
                              ? "600"
                              : i == 6 || (i - 6) % 10 == 0
                                  ? "700"
                                  : i == 7 || (i - 7) % 10 == 0
                                      ? "800"
                                      : i == 8 || (i - 8) % 10 == 0
                                          ? "900"
                                          : "1000";
      listPoint[i][0] = i < 10
          ? "300"
          : i < 20
              ? "600"
              : i < 30
                  ? "900"
                  : i < 40
                      ? "1200"
                      : i < 50
                          ? "1500"
                          : i < 60
                              ? "1800"
                              : i < 70
                                  ? "2100"
                                  : "2400";
    }

    update();
  }

  onClearInjector() {
    for (int i = 0; i < 80; i++) {
      listPoint[i][2] = "0";
    }
    update();
  }

  onClearRow() {
    for (int i = 0; i < 80; i++) {
      listPoint[i][1] = "0";
    }
    update();
  }

  onClearColumn() {
    for (int i = 0; i < 80; i++) {
      listPoint[i][0] = "0";
    }
    update();
  }

  onIncreaseIndex() {
    indx.value = indx.value + 1;
    hexInjector = List.generate(indx.value, (index) => 0);
    update();
  }

  ctrlToHex(List data, var choice) {
    String dataStr = "";
    var x = 0;
    List<String> strData =
        List.generate(data.length, (index) => data[index].text);

    x = map[choice] ?? 0;

    List intData = strData.map(int.parse).toList();
    for (var i = 0; i < x; i++) {
      dataStr = "$dataStr ${intData[i].toRadixString(16)}";
    }
    return dataStr;
  }

  ctrlToString(List data, var choice) {
    String dataStr = "";
    var x = 0;
    List<String> strData =
        List.generate(data.length, (index) => data[index].text);

    x = map[choice] ?? 0;
    List intData = List.from(strData.map(int.parse).toList());
    for (var i = 0; i < x; i++) {
      dataStr = "$dataStr ${intData[i].toString()}";
    }
    return dataStr;
  }

  intToStringList(List data, var choice) {}

  ctrlToStringList(List data, var choice) {
    List dataStr = List.generate(80, (index) => "");
    List<String> strData = [];
    strData = List.generate(data.length, (index) => data[index].text);
    // Map origin = {
    //   "controller": strData =
    //       List.generate(data.length, (index) => data[index].text),
    // };
    List intData = List.from(strData.map(int.parse).toList());
    if (choice == "injector") {
      dataStr = intData;
    } else if (choice == "RPM") {
      for (var index = 0; index < 80; index++) {
        dataStr[index] = index < 10
            ? intData[0]
            : index < 20
                ? intData[1]
                : index < 30
                    ? intData[2]
                    : index < 40
                        ? intData[3]
                        : index < 50
                            ? intData[4]
                            : index < 60
                                ? intData[5]
                                : index < 70
                                    ? intData[6]
                                    : intData[7];
      }
    } else {
      for (var index = 0; index < 80; index++) {
        dataStr[index] = index == 0 || (index - 0) % 10 == 0
            ? intData[0]
            : index == 1 || (index - 1) % 10 == 0
                ? intData[1]
                : index == 2 || (index - 2) % 10 == 0
                    ? intData[2]
                    : index == 3 || (index - 3) % 10 == 0
                        ? intData[3]
                        : index == 4 || (index - 4) % 10 == 0
                            ? intData[4]
                            : index == 5 || (index - 5) % 10 == 0
                                ? intData[5]
                                : index == 6 || (index - 6) % 10 == 0
                                    ? intData[6]
                                    : index == 7 || (index - 7) % 10 == 0
                                        ? intData[7]
                                        : index == 8 || (index - 8) % 10 == 0
                                            ? intData[8]
                                            : intData[9];
      }
    }
    return dataStr;
  }

  listToHex(List data) {
    List hexData = [];
    List<String> strData =
        List.generate(data.length, (index) => data[index].text);
    List intData = List.from(strData.map(int.parse).toList());
    // Int64List intData = Int64List.fromList(strData.map(int.parse).toList());
    hexData = intData.map((e) => e.toRadixString(16)).toList();

    return hexData;
  }

  rawToHexLittle(List<int> hexRawData) {
    int values;
    int x = 0;
    Uint16List uint16Data = Uint16List.fromList(hexRawData);
    ByteData byteData = ByteData.sublistView(uint16Data);
    List hexLittleData = List.generate(slotData.value, (index) => "x");
    for (int i = 0; i < slotData.value * 2; i += 2) {
      values = byteData.getUint16(i);
      // hexsRPM[i] = values;\
      if (values.toString().length == 1) {
        values = 0000;
      }
      String parseString = values.toRadixString(16).padLeft(4, "0");
      hexLittleData[x] = r"\x" +
          parseString.substring(0, 2) +
          r"\x" +
          parseString.substring(2, 4);
      // hexLittleData[x] = r"\x" + parseString;
      x++;
    }
    return hexLittleData;
  }

  ctrlToHexListAll(List isTPS, List isRPM, List isInjector) {
    // int values;
    // int x = 0;
    List<String> hexData = [];
    List<int> hexRawTPS = ctrlToHexList(isTPS, "");
    List<int> hexRawRPM = ctrlToHexList(isRPM, "RPM");
    List<int> hexRawInjector = ctrlToHexList(isInjector, "injector");
    List hexLittleTPS = rawToHexLittle(hexRawTPS);
    List hexLittleRPM = rawToHexLittle(hexRawRPM);
    List hexLittleInjector = rawToHexLittle(hexRawInjector);

    // print(hexLittleTPS);
    // print(hexLittleRPM);
    // print(hexLittleInjector);

    // Uint16List hexRPM = Uint16List.fromList(hexRawRPM);
    // ByteData byteData = ByteData.sublistView(hexRPM);
    // List hexsRPM = List.generate(slotData.value, (index) => "x");
    // for (int i = 0; i < slotData.value * 2; i += 2) {
    //   values = byteData.getUint16(i);
    //   // hexsRPM[i] = values;\
    //   hexsRPM[x] = values.toRadixString(16).padLeft(5, r"\x");
    //   x++;
    // }
    // print(hexsRPM);

    // for (int i = 0; i < slotData.value; i++) {
    //   if (hexRawRPM[i] == 4) {
    //     hexRawRPM[i] = (r"\x" + hexRawRPM[i]) as int;
    //   } else if (hexRawRPM[i] == 3) {
    //     hexRawRPM[i] = r"\x0" + hexRawRPM[i];
    //   } else if (hexRawRPM[i] == 2) {
    //     hexRawRPM[i] = r"\x00" + hexRawRPM[i];
    //   }
    // }
    // hexData = List.generate(
    //     slotData.value,
    //     (index) => hexRawTPS[index] == 4 &&
    //             hexRawRPM[index] == 4 &&
    //             hexRawInjector[index] == 4
    //         ? r"\x"
    //                 "${hexRawTPS[index]}"
    //                 "${byteData.getUint16(index, Endian.little)}" +
    //             r"\x" "${hexRawInjector[index]}"
    //         : r"\x0" "${hexRawTPS[index]}" "${hexRawRPM[index]}" +
    //             r"\x0" "${hexRawInjector[index]}");
    // hexData = List.generate(
    //     // slotData.value,
    //     slotData.value,
    //     (index) => index == 0
    //         ? "${hexLittleTPS[0]}"
    //         : index % 3 == 0
    //             ? "${hexLittleTPS[(index / 2).round()]}"
    //             : index == 1
    //                 ? "${hexLittleRPM[((index - 1) / 2).round()]}"
    //                 : (index - 1) % 3 == 0
    //                     ? "${hexLittleRPM[((index - 1) / 2).round()]}"
    //                     : index == 2
    //                         ? "${hexLittleInjector[index - 2]}"
    //                         : "${hexLittleInjector[((index - 2) / 2).round()]}");
    hexData = List.generate(
        // slotData.value,
        slotData.value,
        (index) => index == 0
            ? "${hexLittleTPS[0]}"
            : index % 3 == 0
                ? "${hexLittleTPS[(index / 3).round()]}"
                : index == 1
                    ? "${hexLittleRPM[index - 1]}"
                    : (index - 1) % 3 == 0
                        ? "${hexLittleRPM[((index - 1) / 3).round() + 8]}"
                        : index == 2
                            ? "${hexLittleInjector[index - 2]}"
                            : "${hexLittleInjector[((index - 2) / 3).round()]}");

    // hexData = List.generate(
    //     // slotData.value,
    //     slotData.value,
    //     (index) => index == 0
    //         ? "${hexLittleTPS[0]}"
    //         : index % 3 == 0
    //             ? "${hexLittleTPS[index]}"
    //             : index == 1 || (index - 1) % 3 == 0
    //                 ? "${hexLittleRPM[index + index + 1]}"
    //                 : index == 2
    //                     ? "${hexLittleInjector[index - 2]}"
    //                     : "${hexLittleInjector[index + index + 2]}");
    // print(hexData); bagi dua kurang satu

    return hexData;
  }

  ctrlToHexList(List data, var choice) {
    List<int> hexData = [];
    List<String> strData =
        List.generate(data.length, (index) => data[index].text);

    List<int> intData = List.from(strData.map(int.parse).toList());
    if (choice == "injector") {
      hexData = intData;
    } else if (choice == "RPM") {
      // intRPM = List.generate(8, (index) => intData[index]);
      List<int> int8Data = List.generate(
          80,
          (index) => index < 10
              ? intData[0]
              : index < 20
                  ? intData[1]
                  : index < 30
                      ? intData[2]
                      : index < 40
                          ? intData[3]
                          : index < 50
                              ? intData[4]
                              : index < 60
                                  ? intData[5]
                                  : index < 70
                                      ? intData[6]
                                      : intData[7]);
      hexData = int8Data;

      // hexData = int8Data.map((e) => e.toRadixString(16)).toList();
    } else {
      // List hex dataype
      List<int> int10Data = List.generate(
          80,
          (index) => index == 0 || (index - 0) % 10 == 0
              ? intData[0]
              : index == 1 || (index - 1) % 10 == 0
                  ? intData[1]
                  : index == 2 || (index - 2) % 10 == 0
                      ? intData[2]
                      : index == 3 || (index - 3) % 10 == 0
                          ? intData[3]
                          : index == 4 || (index - 4) % 10 == 0
                              ? intData[4]
                              : index == 5 || (index - 5) % 10 == 0
                                  ? intData[5]
                                  : index == 6 || (index - 6) % 10 == 0
                                      ? intData[6]
                                      : index == 7 || (index - 7) % 10 == 0
                                          ? intData[7]
                                          : index == 8 || (index - 8) % 10 == 0
                                              ? intData[8]
                                              : intData[9]);
      hexData = int10Data;
      // hexData = int10Data.map((e) => e.toRadixString(16)).toList();
    }

    return hexData;
  }
}
