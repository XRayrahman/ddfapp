import 'package:get/get.dart';
import 'package:hex/hex.dart';

class HomeController extends GetxController {
  var indx = 80.obs;
  List hexInjector = List.generate(80, (index) => 0).obs;
  List decInjector = List.generate(80, (index) => 0).obs;
  List decsInjector = List.generate(80, (index) => 0).obs;

  onSaveHex(List output) {
    hexInjector = output;
    decInjector = hexInjector.map((e) => HEX.decode(e)).toList();
    decsInjector = List.generate(80, (index) => decInjector[index][0]);
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
    decsInjector = List.generate(80, (index) => decInjector[index][0]);
    update();
  }

  onIncreaseIndex() {
    indx.value = indx.value + 1;
    hexInjector = List.generate(indx.value, (index) => 0);
    update();
  }
}
