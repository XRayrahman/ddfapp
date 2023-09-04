import 'dart:io';
import 'package:ddfapp/home/home_controller.dart';
import 'package:ddfapp/home/upload_controller.dart';
import 'package:ddfapp/widgets/text_input.dart';
import 'package:ddfapp/widgets/divider.dart';
import 'package:ddfapp/widgets/table/grid_input.dart';
import 'package:ddfapp/widgets//table/label_column.dart';
import 'package:ddfapp/widgets/table/label_row.dart';
import 'package:ddfapp/widgets/notification.dart';
import 'package:ddfapp/home/home_side_controller.dart';
import 'package:ddfapp/home/home_side.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:serial_port_win32/serial_port_win32.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class ChartData {
  ChartData(this.x, this.y);
  final int? x;
  final double? y;
}

class _HomePageState extends State<HomePage> {
  final HomeController h = Get.put(HomeController());
  final SideController sC = Get.put(SideController());
  final menuController = FlyoutController();
  bool checkedRow = false;
  bool checkedColumn = false;
  bool checkedInjector = true;
  bool readOnlyColumn = true;
  bool readOnlyRow = true;
  bool readOnlyInjector = false;
  int lengthOutput = 80;
  int lengthColumn = 8;
  int lengthRow = 10;
  Color colorInput = const Color.fromARGB(255, 249, 249, 249);
  Color colorDisabled = const Color.fromARGB(222, 101, 101, 101);

  Future<String> loadData() async {
    try {
      final file = await _pickFile;
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData1 = [
      ChartData(1, 0),
      ChartData(2, 0),
      ChartData(3, 0),
      ChartData(4, 0),
      ChartData(5, 0)
    ];

    final List<ChartData> chartData2 = [
      ChartData(1, 0),
      ChartData(2, 0),
      ChartData(3, 0),
      ChartData(4, 0),
      ChartData(5, 0)
    ];

    TextEditingController setInjectorVal = TextEditingController();
    TextEditingController setINJValueMin = TextEditingController();
    TextEditingController setINJValueMax = TextEditingController();
    TextEditingController setTPSValueMin = TextEditingController();
    TextEditingController setTPSValueMax = TextEditingController();
    TextEditingController setRPMValueMin = TextEditingController();
    TextEditingController setRPMValueMax = TextEditingController();

    List textColumn = List.generate(
      8,
      (index) =>
          TextEditingController(text: h.vecData[index * 10][0].toString()),
    );

    List textRow = List.generate(
      lengthRow,
      (index) => TextEditingController(
        text: h.vecData[index][1].toString(),
      ),
    );

    List<TextEditingController> textInjector = List.generate(
      h.slotData.value,
      (index) => TextEditingController(
        text: h.vecData[index][2].toString(),
      ),
    );

    List textControllerColumn = List.generate(
      lengthColumn,
      (index) => textColumn[index],
    );

    List textControllerRow = List.generate(
      lengthRow,
      (index) => textRow[index],
    );

    List<TextEditingController> textControllerInjector = List.generate(
      h.slotData.value,
      (index) => textInjector[index],
    );

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            // height: 750,
            child: Row(
              children: [
                SizedBox(
                  width: 1060,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.8),
                              offset: const Offset(-6.0, -6.0),
                              blurRadius: 16.0,
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(6.0, 6.0),
                              blurRadius: 16.0,
                            ),
                          ],
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              width: 100,
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "CLEAR",
                                                  ),
                                                  Icon(
                                                    FluentIcons.remove_filter,
                                                    size: 14,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Button(
                                              child: const SizedBox(
                                                  width: 80,
                                                  child: Text(" TPS ")),
                                              onPressed: () {
                                                setState(
                                                  () {
                                                    h.onClearRow();
                                                  },
                                                );
                                              },
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Button(
                                              child: const SizedBox(
                                                  width: 80,
                                                  child: Text(" RPM ")),
                                              onPressed: () {
                                                setState(
                                                  () {
                                                    h.onClearColumn();
                                                  },
                                                );
                                              },
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Button(
                                              child: const SizedBox(
                                                  width: 80,
                                                  child: Text(" INJ ")),
                                              onPressed: () {
                                                setState(() {
                                                  h.onClearInjector();
                                                });
                                              },
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                          ],
                                        ),
                                        const cDivider(
                                          direction: Axis.vertical,
                                          size: 120,
                                          marginH: 20,
                                          marginV: 20,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                vertical: 10,
                                              ),
                                              width: 120,
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "INSERT",
                                                  ),
                                                  Icon(
                                                    FluentIcons.insert,
                                                    size: 14,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Button(
                                                  child: const SizedBox(
                                                      width: 110,
                                                      child: Text("DEFAULT")),
                                                  onPressed: () {
                                                    setState(() {
                                                      h.onSetAllDefaultValue();
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Button(
                                                  child: const SizedBox(
                                                      width: 110,
                                                      child: Text("LOAD DATA")),
                                                  onPressed: () {
                                                    setState(() {
                                                      loadData();
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  height: 38,
                                                  child: TextInput(
                                                    boxDecoration:
                                                        BoxDecoration(
                                                            color: colorInput),
                                                    disabled: false,
                                                    placholder: "injector",
                                                    controller: setInjectorVal,
                                                  ),
                                                ),
                                                FilledButton(
                                                  child: const Text("OK"),
                                                  onPressed: () {
                                                    setState(
                                                      () {
                                                        if (setInjectorVal
                                                                .text ==
                                                            "") {
                                                          showSnackbar(
                                                            duration:
                                                                const Duration(
                                                                    seconds: 3),
                                                            alignment: Alignment
                                                                .topRight,
                                                            context,
                                                            NotificationBar(
                                                              contextRoot:
                                                                  context,
                                                              type: "ERROR",
                                                              content:
                                                                  const Text(
                                                                "Value is Empty",
                                                              ),
                                                            ),
                                                          );
                                                        } else if (int.parse(
                                                                    setInjectorVal
                                                                        .text) <
                                                                1000 &&
                                                            int.parse(
                                                                    setInjectorVal
                                                                        .text) >=
                                                                0) {
                                                          h.onSetInjectorValue(
                                                              setInjectorVal
                                                                  .text);
                                                        } else {
                                                          showSnackbar(
                                                            duration:
                                                                const Duration(
                                                                    seconds: 3),
                                                            alignment: Alignment
                                                                .topRight,
                                                            context,
                                                            NotificationBar(
                                                              height: 12,
                                                              contextRoot:
                                                                  context,
                                                              type: "ERROR",
                                                              content:
                                                                  const Text(
                                                                "Value is invalid or more than maximum",
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                        const cDivider(
                                          direction: Axis.vertical,
                                          size: 120,
                                          marginH: 20,
                                          marginV: 20,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              margin: const EdgeInsets.only(
                                                top: 10,
                                                bottom: 3,
                                              ),
                                              width: 300,
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "INSERT BY RANGE",
                                                    // style: TextStyle(fontSize: 16),
                                                  ),
                                                  Icon(
                                                    FluentIcons.step_insert,
                                                    size: 14,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "TPS > ",
                                                ),
                                                SizedBox(
                                                  height: 35,
                                                  child: TextInput(
                                                      boxDecoration:
                                                          BoxDecoration(
                                                              shape: BoxShape
                                                                  .rectangle,
                                                              color:
                                                                  colorInput),
                                                      disabled: false,
                                                      placholder: "min",
                                                      controller:
                                                          setTPSValueMin),
                                                ),
                                                const Text(
                                                  "--",
                                                ),
                                                SizedBox(
                                                  height: 35,
                                                  child: TextInput(
                                                      boxDecoration:
                                                          BoxDecoration(
                                                              color:
                                                                  colorInput),
                                                      disabled: false,
                                                      placholder: "max",
                                                      controller:
                                                          setTPSValueMax),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                FilledButton(
                                                  child: const Text(
                                                    "OK",
                                                  ),
                                                  onPressed: () {
                                                    setState(
                                                      () {
                                                        if (setTPSValueMin
                                                                .text.isEmpty ||
                                                            setTPSValueMax
                                                                .text.isEmpty) {
                                                          showSnackbar(
                                                            duration:
                                                                const Duration(
                                                                    seconds: 3),
                                                            alignment: Alignment
                                                                .topRight,
                                                            context,
                                                            NotificationBar(
                                                              contextRoot:
                                                                  context,
                                                              type: "ERROR",
                                                              content:
                                                                  const Text(
                                                                "Value should not be empty",
                                                              ),
                                                            ),
                                                          );
                                                        } else if (int.parse(
                                                                setTPSValueMin
                                                                    .text) >=
                                                            int.parse(
                                                                setTPSValueMax
                                                                    .text)) {
                                                          showSnackbar(
                                                            duration:
                                                                const Duration(
                                                                    seconds: 3),
                                                            alignment: Alignment
                                                                .topRight,
                                                            context,
                                                            NotificationBar(
                                                              contextRoot:
                                                                  context,
                                                              type: "ERROR",
                                                              content:
                                                                  const Text(
                                                                "Invalid value",
                                                              ),
                                                            ),
                                                          );
                                                        } else {
                                                          h.insertByRange(
                                                              "TPS",
                                                              int.parse(
                                                                  setTPSValueMin
                                                                      .text),
                                                              int.parse(
                                                                  setTPSValueMax
                                                                      .text));
                                                        }
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "RPM > ",
                                                ),
                                                SizedBox(
                                                  height: 35,
                                                  child: TextInput(
                                                      boxDecoration:
                                                          BoxDecoration(
                                                              color:
                                                                  colorInput),
                                                      disabled: false,
                                                      placholder: "min",
                                                      controller:
                                                          setRPMValueMin),
                                                ),
                                                const Text(
                                                  "--",
                                                ),
                                                SizedBox(
                                                  height: 35,
                                                  child: TextInput(
                                                      boxDecoration:
                                                          BoxDecoration(
                                                              color:
                                                                  colorInput),
                                                      disabled: false,
                                                      placholder: "max",
                                                      controller:
                                                          setRPMValueMax),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                FilledButton(
                                                  child: const Text(
                                                    "OK",
                                                  ),
                                                  onPressed: () {
                                                    setState(
                                                      () {
                                                        if (setRPMValueMin
                                                                    .text ==
                                                                "" ||
                                                            setRPMValueMax
                                                                    .text ==
                                                                "") {
                                                          showSnackbar(
                                                            duration:
                                                                const Duration(
                                                                    seconds: 3),
                                                            alignment: Alignment
                                                                .topRight,
                                                            context,
                                                            NotificationBar(
                                                              contextRoot:
                                                                  context,
                                                              type: "ERROR",
                                                              content:
                                                                  const Text(
                                                                "Value should not be empty",
                                                              ),
                                                            ),
                                                          );
                                                        } else if (int.parse(
                                                                setRPMValueMin
                                                                    .text) >=
                                                            int.parse(
                                                                setRPMValueMax
                                                                    .text)) {
                                                          showSnackbar(
                                                            duration:
                                                                const Duration(
                                                                    seconds: 3),
                                                            alignment: Alignment
                                                                .topRight,
                                                            context,
                                                            NotificationBar(
                                                              contextRoot:
                                                                  context,
                                                              type: "ERROR",
                                                              content:
                                                                  const Text(
                                                                "Invalid value",
                                                              ),
                                                            ),
                                                          );
                                                        } else {
                                                          h.insertByRange(
                                                              "RPM",
                                                              int.parse(
                                                                  setRPMValueMin
                                                                      .text),
                                                              int.parse(
                                                                  setRPMValueMax
                                                                      .text));
                                                        }
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "INJ > ",
                                                ),
                                                SizedBox(
                                                  height: 35,
                                                  child: TextInput(
                                                      boxDecoration:
                                                          BoxDecoration(
                                                              color:
                                                                  colorInput),
                                                      disabled: false,
                                                      placholder: "min",
                                                      controller:
                                                          setINJValueMin),
                                                ),
                                                const Text(
                                                  "--",
                                                ),
                                                SizedBox(
                                                  height: 35,
                                                  child: TextInput(
                                                      boxDecoration:
                                                          BoxDecoration(
                                                              color:
                                                                  colorInput),
                                                      disabled: false,
                                                      placholder: "max",
                                                      controller:
                                                          setINJValueMax),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                FilledButton(
                                                  child: const Text(
                                                    "OK",
                                                  ),
                                                  onPressed: () {
                                                    setState(
                                                      () {
                                                        if (setINJValueMin
                                                                    .text ==
                                                                "" ||
                                                            setINJValueMax
                                                                    .text ==
                                                                "") {
                                                          showSnackbar(
                                                            duration:
                                                                const Duration(
                                                                    seconds: 3),
                                                            alignment: Alignment
                                                                .topRight,
                                                            context,
                                                            NotificationBar(
                                                              contextRoot:
                                                                  context,
                                                              type: "ERROR",
                                                              content:
                                                                  const Text(
                                                                "Value should not be empty",
                                                              ),
                                                            ),
                                                          );
                                                        } else if (int.parse(
                                                                setINJValueMin
                                                                    .text) >=
                                                            int.parse(
                                                                setINJValueMax
                                                                    .text)) {
                                                          showSnackbar(
                                                            duration:
                                                                const Duration(
                                                                    seconds: 3),
                                                            alignment: Alignment
                                                                .topRight,
                                                            context,
                                                            NotificationBar(
                                                              contextRoot:
                                                                  context,
                                                              type: "ERROR",
                                                              content:
                                                                  const Text(
                                                                "Invalid value",
                                                              ),
                                                            ),
                                                          );
                                                        } else {
                                                          h.insertByRange(
                                                              "INJ",
                                                              int.parse(
                                                                  setINJValueMin
                                                                      .text),
                                                              int.parse(
                                                                  setINJValueMax
                                                                      .text));
                                                        }
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                        const cDivider(
                                          direction: Axis.vertical,
                                          size: 120,
                                          marginH: 20,
                                          marginV: 20,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              margin: const EdgeInsets.only(
                                                top: 10,
                                                bottom: 3,
                                              ),
                                              width: 100,
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text("EDIT"),
                                                  Icon(
                                                    FluentIcons
                                                        .app_icon_default_edit,
                                                    size: 14,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                ToggleSwitch(
                                                  checked: checkedRow,
                                                  onChanged: (x) => setState(
                                                    () {
                                                      checkedRow = x;
                                                      readOnlyRow = !x;
                                                    },
                                                  ),
                                                  content: const Text("TPS"),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Row(
                                              children: [
                                                ToggleSwitch(
                                                  checked: checkedColumn,
                                                  onChanged: (v) => setState(
                                                    () {
                                                      checkedColumn = v;
                                                      readOnlyColumn = !v;
                                                    },
                                                  ),
                                                  content: const Text("RPM"),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Row(
                                              children: [
                                                ToggleSwitch(
                                                  checked: checkedInjector,
                                                  onChanged: (y) => setState(
                                                    () {
                                                      checkedInjector = y;
                                                      readOnlyInjector = !y;
                                                    },
                                                  ),
                                                  content: const Text(
                                                    "INJ",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // const SizedBox(
                                            //   height: 40,
                                            // ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Divider(
                                  direction: Axis.vertical,
                                  size: 120,
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                Obx(
                                  () => Container(
                                    alignment: Alignment.centerRight,
                                    width: 180,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.8),
                                          offset: const Offset(-6.0, -6.0),
                                          blurRadius: 16.0,
                                        ),
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          offset: const Offset(6.0, 6.0),
                                          blurRadius: 16.0,
                                        ),
                                      ],
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      // color: const Color.fromARGB(50, 100, 100, 100),
                                      border: h.isSended.value
                                          ? Border.all(color: Colors.green)
                                          : Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            h.isSaved.value
                                                ? Icon(
                                                    FluentIcons
                                                        .skype_circle_check,
                                                    color: Colors.green)
                                                : const Icon(
                                                    FluentIcons
                                                        .sync_status_solid,
                                                    color: Color.fromARGB(
                                                        90, 49, 49, 49),
                                                  ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            FlyoutTarget(
                                              controller: menuController,
                                              child: FilledButton(
                                                child: const SizedBox(
                                                    width: 100,
                                                    child: Text("Save Value")),
                                                onPressed: () {
                                                  setState(
                                                    () {
                                                      try {
                                                        final valueInjector =
                                                            h.ctrlToStringList(
                                                                textInjector,
                                                                "injector");
                                                        final valueRPM =
                                                            h.ctrlToStringList(
                                                                textColumn,
                                                                "RPM");
                                                        final valueTPS =
                                                            h.ctrlToStringList(
                                                                textRow, "TPS");
                                                        for (var i = 0;
                                                            i < 80;
                                                            i++) {
                                                          if (kDebugMode) {
                                                            print(
                                                                "${valueTPS[i]};${valueRPM[i]};${valueInjector[i]};");
                                                          }
                                                        }
                                                        for (var i = 0;
                                                            i <
                                                                h.slotData
                                                                    .value;
                                                            i++) {
                                                          if (valueInjector[
                                                                  i] >=
                                                              h.maxInjectorValue
                                                                  .value) {
                                                            showSnackbar(
                                                              duration:
                                                                  const Duration(
                                                                      seconds:
                                                                          3),
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              context,
                                                              NotificationBar(
                                                                height: 13,
                                                                contextRoot:
                                                                    context,
                                                                type: "ERROR",
                                                                content: Text(
                                                                    "Value(s) is more than maximum value settings at cell: ${i + 1}"),
                                                              ),
                                                            );
                                                            h.isSaved.value =
                                                                false;
                                                          }
                                                        }
                                                        if (valueInjector[h
                                                                    .slotData
                                                                    .value -
                                                                1] <=
                                                            h.maxInjectorValue
                                                                .value) {
                                                          menuController
                                                              .showFlyout(
                                                                  autoModeConfiguration:
                                                                      FlyoutAutoConfiguration(
                                                                    preferredMode:
                                                                        FlyoutPlacementMode
                                                                            .topCenter,
                                                                  ),
                                                                  barrierDismissible:
                                                                      true,
                                                                  dismissOnPointerMoveAway:
                                                                      true,
                                                                  dismissWithEsc:
                                                                      true,
                                                                  builder:
                                                                      (context) {
                                                                    return MenuFlyout(
                                                                        items: [
                                                                          MenuFlyoutItem(
                                                                            leading:
                                                                                const Icon(FluentIcons.save),
                                                                            text:
                                                                                const Text('Save'),
                                                                            onPressed:
                                                                                (() {
                                                                              h.onSave(
                                                                                valueTPS,
                                                                                valueRPM,
                                                                                valueInjector,
                                                                              );
                                                                              Flyout.of(context).close;
                                                                              h.isSaved.value = true;
                                                                              showSnackbar(
                                                                                duration: const Duration(seconds: 3),
                                                                                alignment: Alignment.topRight,
                                                                                context,
                                                                                NotificationBar(
                                                                                  height: 10,
                                                                                  width: 14,
                                                                                  contextRoot: context,
                                                                                  type: "SUCCESS",
                                                                                  content: const Text("Value saved"),
                                                                                ),
                                                                              );
                                                                            }),
                                                                          ),
                                                                          MenuFlyoutItem(
                                                                            leading:
                                                                                const Icon(FluentIcons.save_as),
                                                                            text:
                                                                                const Text('Save as'),
                                                                            onPressed:
                                                                                (() {
                                                                              h.onSave(
                                                                                valueTPS,
                                                                                valueRPM,
                                                                                valueInjector,
                                                                              );
                                                                              Future<File> files = writeToFile("${h.ctrlToString(textRow, "TPS")}\n"
                                                                                  "${h.ctrlToString(textColumn, "RPM")}\n"
                                                                                  "${h.ctrlToString(textInjector, "injector")}");
                                                                              files.whenComplete(() => h.isSaved.value = true);

                                                                              showSnackbar(
                                                                                duration: const Duration(seconds: 3),
                                                                                alignment: Alignment.topRight,
                                                                                context,
                                                                                NotificationBar(
                                                                                  height: 10,
                                                                                  width: 14,
                                                                                  contextRoot: context,
                                                                                  type: "SUCCESS",
                                                                                  content: const Text("Value saved"),
                                                                                ),
                                                                              );
                                                                              Flyout.of(context).close;
                                                                            }),
                                                                          ),
                                                                        ]);
                                                                  });

                                                          // saveDialog(
                                                          //     context,
                                                          //     textRow,
                                                          //     textColumn,
                                                          //     textInjector);
                                                        }
                                                      } catch (e) {
                                                        showSnackbar(
                                                          duration:
                                                              const Duration(
                                                                  seconds: 3),
                                                          alignment: Alignment
                                                              .topRight,
                                                          context,
                                                          NotificationBar(
                                                            height: 20,
                                                            contextRoot:
                                                                context,
                                                            type: "ERROR",
                                                            content: Text(
                                                                "${e}value is invalid or still empty"),
                                                          ),
                                                        );
                                                        h.isSaved.value = false;
                                                      }
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            h.isSended.value && h.isSaved.value
                                                ? Icon(
                                                    FluentIcons
                                                        .skype_circle_check,
                                                    color: Colors.green)
                                                : const Icon(
                                                    FluentIcons
                                                        .sync_status_solid,
                                                    color: Color.fromARGB(
                                                        90, 49, 49, 49),
                                                  ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            FilledButton(
                                              child: const SizedBox(
                                                width: 100,
                                                child: Text("Send to ECU"),
                                              ),
                                              onPressed: () => setState(
                                                () {
                                                  try {
                                                    h.ports.clear();
                                                  } catch (e) {
                                                    throw Exception(
                                                        "already cleared: $e");
                                                  }
                                                  h.ports = SerialPort
                                                      .getAvailablePorts();
                                                  if (h.ports.isEmpty) {
                                                    showSnackbar(
                                                      duration: const Duration(
                                                          seconds: 3),
                                                      alignment:
                                                          Alignment.topRight,
                                                      context,
                                                      NotificationBar(
                                                        contextRoot: context,
                                                        type: "ERROR",
                                                        width: 80,
                                                        height: 12,
                                                        content: const Text(
                                                          "Data can't be sent, try save it first",
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    try {
                                                      List<String> outputData =
                                                          h.ctrlToHexListAll(
                                                        textRow,
                                                        textColumn,
                                                        textInjector,
                                                      );
                                                      showContentDialog(
                                                        context,
                                                        outputData,
                                                        textInjector,
                                                        textColumn,
                                                        textRow,
                                                      );
                                                    } catch (e) {
                                                      throw Exception(e);
                                                    }
                                                  }
                                                  h.isSaved.value = false;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          RotatedBox(
                            quarterTurns: 3,
                            child: Container(
                              padding:
                                  const EdgeInsets.only(bottom: 10, right: 70),
                              child: const Text(
                                "RPM",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 111,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        "THROTTLE POSITION (mV)",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      LabelRow(
                                          disabled: readOnlyRow,
                                          boxDecor: BoxDecoration(
                                            color: checkedRow
                                                ? Colors.teal
                                                : colorDisabled,
                                          ),
                                          textController: textControllerRow),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Divider(size: 1000),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  LabelColumn(
                                    disabled: readOnlyColumn,
                                    boxDecor: BoxDecoration(
                                      color: checkedColumn
                                          ? Colors.teal
                                          : colorDisabled,
                                    ),
                                    textController: textControllerColumn,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Divider(
                                    size: 320,
                                    direction: Axis.vertical,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      GridInput(
                                        readOnly: readOnlyInjector,
                                        textC: textControllerInjector,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Expanded(
                        // width: 100,
                        // height: 200,
                        child: Row(children: [
                          RotatedBox(
                            quarterTurns: 3,
                            child: Container(
                              padding:
                                  const EdgeInsets.only(bottom: 10, left: 10),
                              child: const Text(
                                "VOLTAGE GRAPH",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(),
                                legend: Legend(
                                  isVisible: true,
                                ),
                                series: <CartesianSeries>[
                                  // Initialize line series
                                  FastLineSeries<ChartData, int>(
                                      name: "TPS",
                                      dataSource: chartData1,
                                      xValueMapper: (ChartData data, _) =>
                                          data.x,
                                      yValueMapper: (ChartData data, _) =>
                                          data.y),
                                  FastLineSeries<ChartData, int>(
                                      name: "RPM",
                                      dataSource: chartData2,
                                      xValueMapper: (ChartData data, _) =>
                                          data.x,
                                      yValueMapper: (ChartData data, _) =>
                                          data.y),
                                ]),
                          ),
                        ]),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Expanded(
                  child: SideView(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// FOR LOAD DATA
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> writeToFile(String counter) async {
  final file = await _saveFile;
  return file.writeAsString(counter);
}

Future<File> get _saveFile async {
  String? result = await FilePicker.platform.saveFile(
    dialogTitle: "Select or create File to save Values",
    type: FileType.custom,
    allowedExtensions: ['txt', 'log'],
    initialDirectory: await _localPath,
  );
  return File(result.toString());
}

Future<File> get _pickFile async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    dialogTitle: "Select a saved Data Value",
    type: FileType.custom,
    allowedExtensions: ['txt', 'log'],
    initialDirectory: await _localPath,
  );

  if (result == null) return File("");

  PlatformFile file = result.files.single;
  return File(file.path.toString());
}
