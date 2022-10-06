import 'dart:typed_data';

import 'package:get/get.dart';

class HomeController extends GetxController {
  var indx = 80.obs;
  var ix = 80.obs;
  RxBool isSended = false.obs;
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
    listPoint = List.generate(80,
        (index) => [valueRPM[index], valueTPS[index], valueInjector[index]]);
    update();
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
          ? "500"
          : i == 1 || (i - 1) % 10 == 0
              ? "1000"
              : i == 2 || (i - 2) % 10 == 0
                  ? "1500"
                  : i == 3 || (i - 3) % 10 == 0
                      ? "2000"
                      : i == 4 || (i - 4) % 10 == 0
                          ? "2500"
                          : i == 5 || (i - 5) % 10 == 0
                              ? "3000"
                              : i == 6 || (i - 6) % 10 == 0
                                  ? "3500"
                                  : i == 7 || (i - 7) % 10 == 0
                                      ? "4000"
                                      : i == 8 || (i - 8) % 10 == 0
                                          ? "4500"
                                          : "5000";
      listPoint[i][0] = i < 10
          ? "500"
          : i < 20
              ? "1000"
              : i < 30
                  ? "1500"
                  : i < 40
                      ? "2000"
                      : i < 50
                          ? "2500"
                          : i < 60
                              ? "3000"
                              : i < 70
                                  ? "3500"
                                  : "4000";
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

    List<int> intData = strData.map(int.parse).toList();
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
    Int64List intData = Int64List.fromList(strData.map(int.parse).toList());
    for (var i = 0; i < x; i++) {
      dataStr = "$dataStr ${intData[i].toString()}";
    }
    return dataStr;
  }

  intToStringList(List data, var choice) {}

  ctrlToStringList(List data, var choice, var originType) {
    List dataStr = List.generate(80, (index) => "");
    List<String> strData = [];
    // var x = 0;
    Map origin = {
      "controller": strData =
          List.generate(data.length, (index) => data[index].text),
    };
    Int64List intData = Int64List.fromList(strData.map(int.parse).toList());
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

  ctrlToHexList(List data, var choice) {
    List hexData = [];
    List<String> strData =
        List.generate(data.length, (index) => data[index].text);

    Int64List intData = Int64List.fromList(strData.map(int.parse).toList());
    if (choice == "injector") {
      // List hex datatype
      hexData = intData.map((e) => e.toRadixString(16)).toList();
    } else if (choice == "RPM") {
      // List hex datatype
      // intRPM = List.generate(8, (index) => intData[index]);
      List int8Data = List.generate(
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
      hexData = int8Data.map((e) => e.toRadixString(16)).toList();
    } else {
      // List hex dataype
      List int10Data = List.generate(
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
      hexData = int10Data.map((e) => e.toRadixString(16)).toList();
    }

    // List hex datatype
    return hexData;
  }
}
