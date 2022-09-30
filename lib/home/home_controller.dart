import 'package:get/get.dart';
import 'package:hex/hex.dart';

class HomeController extends GetxController {
  var indx = 80.obs;
  var ix = 80.obs;
  List intRPM = [].obs;
  List hexInjector = List.generate(80, (index) => "").obs;
  // List strRPM = List.generate(80, (index) => "").obs;
  List decInjector = List.generate(
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
            [""]
          ]).obs;
  List decsInjector = List.generate(80, (index) => ["", "", ""]).obs;

  onSaveHex(List tps, List rpm, List output) {
    hexInjector = output;
    decInjector = hexInjector.map((e) => HEX.decode(e)).toList();
    decRPM = rpm.map((y) => HEX.decode(y)).toList();
    decTPS = tps.map((x) => HEX.decode(x)).toList();
    // decsInjector = List.generate(80, (index) => [decInjector[index][1]]);
    decsInjector = List.generate(80,
        (index) => [decTPS[index][0], decRPM[index][0], decInjector[index][0]]);
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
    decInjector = hexInjector.map((e) => HEX.decode(e)).toList();
    decsInjector = List.generate(80,
        (index) => [decTPS[index][0], decRPM[index][0], decInjector[index][0]]);
    update();
  }

  onIncreaseIndex() {
    indx.value = indx.value + 1;
    hexInjector = List.generate(indx.value, (index) => 0);
    update();
  }

  strToHex(List data, var choice) {
    List hexData = [];
    List<String> strData =
        List.generate(data.length, (index) => data[index].text);
    List<int> intData = strData.map(int.parse).toList();
    if (choice == "injector") {
      hexData = intData.map((e) => e.toRadixString(16)).toList();
    } else if (choice == "RPM") {
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
    }
    // else {
    //   List int10Data = List.generate(
    //       80,
    //       (index) => index < 8
    //           ? intData[0]
    //           : index < 16
    //               ? intData[1]
    //               : index < 24
    //                   ? intData[2]
    //                   : index < 32
    //                       ? intData[3]
    //                       : index < 40
    //                           ? intData[4]
    //                           : index < 48
    //                               ? intData[5]
    //                               : index < 56
    //                                   ? intData[6]
    //                                   : index < 64
    //                                       ? intData[7]
    //                                       : index < 72
    //                                           ? intData[8]
    //                                           : index < 56
    //                                               ? intData[6]
    //                                               : intData[7]);
    //   hexData = int8Data.map((e) => e.toRadixString(16)).toList();
    // }
    return hexData;
  }
}
