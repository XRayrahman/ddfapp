import 'package:get/get.dart';
import 'package:hex/hex.dart';

class HomeController extends GetxController {
  var indx = 80.obs;
  var ix = 80.obs;
  List intRPM = [].obs;
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

  onSaveHex(List hexRPM, List hexTPS, List hexInjector) {
    decINJ = hexInjector.map((e) => HEX.decode(e)).toList();
    decRPM = hexRPM.map((y) => HEX.decode(y)).toList();
    decTPS = hexTPS.map((x) => HEX.decode(x)).toList();
    // listPoint = List.generate(80, (index) => [decINJ[index][1]]);
    listPoint = List.generate(
        80, (index) => [decRPM[index][0], decTPS[index][0], decINJ[index][0]]);
    // HEX.decode(hexInjector.map.toString()).toList();
    update();
  }

  onDecreaseIndex() {
    indx.value = indx.value - 1;
    hexInjector = List.generate(indx.value, (index) => 0);
    update();
  }

  onClearInjector() {
    hexInjector = List.generate(indx.value, (index) => "0");
    hexRPM = List.generate(80, (index) => "0");
    hexTPS = List.generate(80, (index) => "0");
    decINJ = hexInjector.map((e) => HEX.decode(e)).toList();
    decRPM = hexRPM.map((e) => HEX.decode(e)).toList();
    decTPS = hexTPS.map((e) => HEX.decode(e)).toList();

    listPoint = List.generate(
        80, (index) => [decRPM[index][0], decTPS[index][0], decINJ[index][0]]);
    update();
  }

  onClearRow() {
    hexTPS = List.generate(80, (index) => "0");
    decTPS = hexTPS.map((e) => HEX.decode(e)).toList();

    update();
  }

  onIncreaseIndex() {
    indx.value = indx.value + 1;
    hexInjector = List.generate(indx.value, (index) => 0);
    update();
  }

  strToHex(List data, var choice) {
    String dataStr = "";
    var x = 0;
    List<String> strData =
        List.generate(data.length, (index) => data[index].text);

    List<int> intData = strData.map(int.parse).toList();
    choice == "injector"
        ? x = 80
        : choice == "RPM"
            ? x = 8
            : x = 10;
    for (var i = 0; i < x; i++) {
      dataStr = "$dataStr ${intData[i].toRadixString(16)}";
    }
    return dataStr;
  }

  strToHexList(List data, var choice) {
    List hexData = [];
    List<String> strData =
        List.generate(data.length, (index) => data[index].text);

    List<int> intData = strData.map(int.parse).toList();
    if (choice == "injector") {
      // List hex datatype
      hexData = intData.map((e) => e.toRadixString(16)).toList();
    } else if (choice == "RPM") {
      // List hex datatype
      intRPM = List.generate(8, (index) => intData[index]);
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
