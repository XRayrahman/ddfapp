import 'dart:typed_data';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isSended = false.obs;
  RxBool isSaved = false.obs;
  var slotData = 80.obs;
  var maxInjectorValue = 3000.obs;
  var baudrate = 115200.obs;
  var maxCOM = "15".obs;
  var delaySend = "500".obs;
  var readRPM = "0".obs;

  List ports = [].obs;
  List hexINJ = List.generate(80, (index) => "").obs;
  List hexRPM = List.generate(80, (index) => "").obs;
  List hexTPS = List.generate(80, (index) => "").obs;
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
  List vecData = List.generate(80, (index) => ["", "", ""]).obs;
  Map map = {"injector": 80, "RPM": 8, "TPS": 10};

  onSave(List valueTPS, List valueRPM, List valueInjector) {
    vecData = List.generate(slotData.value,
        (index) => [valueRPM[index], valueTPS[index], valueInjector[index]]);
    // print(vecData);
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

  onDecreaseIndex() {
    slotData.value = slotData.value - 1;
    hexINJ = List.generate(slotData.value, (index) => 0);
    update();
  }

  onSetInjectorValue(var data) {
    for (int i = 0; i < 80; i++) {
      vecData[i][2] = data;
    }

    update();
  }

  insertByRange(String choice, int start, int end) {
    int n = 0;
    int y = 0;
    switch (choice) {
      case "RPM":
        n = 80;
        y = 0;
        break;
      case "TPS":
        n = 10;
        y = 1;
        break;
      case "INJ":
        n = 80;
        y = 2;
        break;
      default:
        throw ArgumentError("unknown choice");
    }
    int increment = ((end - start) / (n - 1)).round();
    for (int i = 0; i < 80; i++) {
      if (i == 79) {
        vecData[i][y] = end.toString();
      } else {
        vecData[i][y] = ((increment * i) + start).toString();
      }
    }
    update();
  }

  onSetAllDefaultValue() {
    for (int i = 0; i < 80; i++) {
      vecData[i][2] = "0";
      vecData[i][1] = i == 0 || (i - 0) % 10 == 0
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
      vecData[i][0] = i < 10
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
      vecData[i][2] = "0";
    }
    update();
  }

  onClearRow() {
    for (int i = 0; i < 80; i++) {
      vecData[i][1] = "0";
    }
    update();
  }

  onClearColumn() {
    for (int i = 0; i < 80; i++) {
      vecData[i][0] = "0";
    }
    update();
  }

  onIncreaseIndex() {
    slotData.value = slotData.value + 1;
    hexINJ = List.generate(slotData.value, (index) => 0);
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
      dataStr = "$dataStr${intData[i].toString()} ";
    }
    return dataStr;
  }

  intToStringList(List data, var choice) {}

  ctrlToStringList(List data, var choice) {
    List dataStr = List.generate(80, (index) => "");
    List<String> strData = [];
    strData = List.generate(data.length, (index) => data[index].text);
    List intData = List.from(strData.map(int.parse).toList());
    if (choice == "injector") {
      dataStr = intData;
    } else if (choice == "RPM") {
      for (var index = 0; index < 80; index++) {
        var val = (index / 10).floor();
        dataStr[index] = intData[val];
      }
    } else {
      for (var index = 0; index < 80; index++) {
        var val = index % 10;
        dataStr[index] = intData[val];
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
      List<int> int8Data =
          List.generate(80, (index) => intData[((index / 10).floor())]);
      hexData = int8Data;
      // hexData = int8Data.map((e) => e.toRadixString(16)).toList();
    } else {
      // List hex dataype
      List<int> int10Data = List.generate(80, (index) => intData[index % 10]);
      hexData = int10Data;
      // hexData = int10Data.map((e) => e.toRadixString(16)).toList();
    }

    return hexData;
  }

  String toHEX(int value, {int byteSize = 16}) {
    int padLength = 4;
    byteSize == 8 ? padLength = 2 : 4;
    String hex = value.toRadixString(byteSize).padLeft(padLength, "0");
    return hex;
  }
}
