import 'dart:typed_data';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:ddfapp/home/home_controller.dart';
import 'package:ddfapp/widgets/side_controller.dart';
import 'package:ddfapp/text_input.dart';
import 'package:ddfapp/widgets/side_view.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:ddfapp/widgets/grid_input.dart';
import 'package:ddfapp/widgets/label_column.dart';
import 'package:ddfapp/widgets/label_row.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:serial_port_win32/serial_port_win32.dart';
import 'dart:io';
import 'package:ddfapp/widgets/notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController h = Get.put(HomeController());
  final SideController sC = Get.put(SideController());
  bool checkedRow = true;
  bool checkedColumn = true;
  bool checkedInput = true;
  bool readOnlyColumn = false;
  bool readOnlyRow = false;
  bool readOnlyInput = false;
  bool isSaved = false;
  Color colorEnabled = const Color.fromARGB(255, 0, 120, 212);
  Color colorDisabled = const Color.fromARGB(255, 101, 101, 101);
  int lengthOutput = 80;
  int lengthColumn = 8;
  int lengthRow = 10;

  // FOR LOAD DATA
  // Future<File> get _pickFile async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     dialogTitle: "Select a saved Data Value",
  //     type: FileType.custom,
  //     allowedExtensions: ['txt', 'log'],
  //   );

  //   if (result == null) return File("");

  //   PlatformFile file = result.files.single;
  //   return File(file.path.toString());
  // }

  @override
  Widget build(BuildContext context) {
    // FOR LOAD DATA
    // Future<String> loadData() async {
    //   try {
    //     final file = await _pickFile;
    //     final load = await file.readAsString();
    //     final loadSplit = load.split(' ');
    //     List valueOutput = [];
    //     List valueTPS = [];
    //     List valueRPM = [];
    //     h.loadData = List.generate(
    //       h.slotData.value,
    //       (index) => loadSplit[index],
    //     );
    //     // print(h.loadData);

    //     for (var i = 0; i < 8; i++) {
    //       valueOutput = h.ctrlToStringList(h.loadData[i], "injector");
    //     }

    //     for (var i = 0; i < 10; i++) {
    //       valueRPM = h.ctrlToStringList(h.loadData[i + 8], "RPM");
    //     }

    //     for (var i = 0; i < 10; i++) {
    //       valueTPS = h.ctrlToStringList(h.loadData[i + 18], "TPS");
    //     }
    //     h.onSave(
    //       valueTPS,
    //       valueRPM,
    //       valueOutput,
    //     );
    //     return h.loadData[0];
    //   } catch (e) {
    //     return e.toString();
    //   }
    // }

    List<TextEditingController> textOutput = List.generate(
      h.slotData.value,
      (index) => TextEditingController(
        text: h.listPoint[index][2].toString(),
      ),
    );

    TextEditingController setInjectorValue = TextEditingController();

    List textColumn = List.generate(
      8,
      (index) =>
          TextEditingController(text: h.listPoint[index * 10][0].toString()),
    );

    List textRow = List.generate(
      lengthRow,
      (index) => TextEditingController(
        text: h.listPoint[index][1].toString(),
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

    return Container(
      padding: const EdgeInsets.all(20),
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
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Button(
                                              child: const SizedBox(
                                                  width: 120,
                                                  child: Text(
                                                      "Clear Injector Value")),
                                              onPressed: () {
                                                setState(() {
                                                  h.onClearInjector();
                                                });
                                              },
                                              //   style: ButtonStyle(
                                              //       backgroundColor: ,
                                              // ),
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
                                                  width: 120,
                                                  child:
                                                      Text("Clear TPS Value")),
                                              onPressed: () {
                                                setState(
                                                  () {
                                                    h.onClearRow();
                                                  },
                                                );
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
                                                  width: 120,
                                                  child:
                                                      Text("Clear RPM Value")),
                                              onPressed: () {
                                                setState(
                                                  () {
                                                    h.onClearColumn();
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 60,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Text("Set Injector value :"),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            TextInput(
                                                enabled: false,
                                                controller: setInjectorValue),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Button(
                                              child: const Text("OK"),
                                              onPressed: () {
                                                setState(
                                                  () {
                                                    if (setInjectorValue.text ==
                                                        "") {
                                                      showSnackbar(
                                                        duration:
                                                            const Duration(
                                                                seconds: 3),
                                                        alignment:
                                                            Alignment.topRight,
                                                        context,
                                                        NotificationBar(
                                                          contextRoot: context,
                                                          type: "ERROR",
                                                          content: const Text(
                                                            "Value is Empty",
                                                          ),
                                                        ),
                                                      );
                                                    } else if (int.parse(
                                                            setInjectorValue
                                                                .text) <
                                                        255) {
                                                      h.onSetInjectorValue(
                                                          setInjectorValue
                                                              .text);
                                                    } else {
                                                      showSnackbar(
                                                        duration:
                                                            const Duration(
                                                                seconds: 3),
                                                        alignment:
                                                            Alignment.topRight,
                                                        context,
                                                        NotificationBar(
                                                          contextRoot: context,
                                                          type: "ERROR",
                                                          content: const Text(
                                                            "Value is more than maximum",
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                );
                                              },
                                              //   style: ButtonStyle(
                                              //       backgroundColor: ,
                                              // ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const Text("Set ALL value       :"),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Button(
                                              child: const SizedBox(
                                                  width: 115,
                                                  child: Text("DEFAULT")),
                                              onPressed: () {
                                                setState(() {
                                                  h.onSetAllDefaultValue();
                                                });
                                              },
                                              //   style: ButtonStyle(
                                              //       backgroundColor: ,
                                              // ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const Text("Import value       :"),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Button(
                                              child: const SizedBox(
                                                  width: 115,
                                                  child: Text("LOAD DATA")),
                                              onPressed: () {
                                                setState(() {
                                                  // loadData();
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 60,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
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
                                              content: Text(
                                                checkedColumn
                                                    ? "Column Value : Unlocked"
                                                    : "Column Value : Locked",
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 2,
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
                                              content: Text(
                                                checkedRow
                                                    ? "Row Value : Unlocked"
                                                    : "Row Value : Locked",
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Row(
                                          children: [
                                            ToggleSwitch(
                                              checked: checkedInput,
                                              onChanged: (y) => setState(
                                                () {
                                                  checkedInput = y;
                                                  readOnlyInput = !y;
                                                },
                                              ),
                                              content: Text(
                                                checkedInput
                                                    ? "Input Value : Unlocked"
                                                    : "Input Value : Locked",
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(
                              direction: Axis.vertical,
                              size: 100,
                            ),
                            const SizedBox(
                              width: 35,
                            ),
                            Obx(
                              () => Container(
                                alignment: Alignment.centerRight,
                                width: 180,
                                decoration: BoxDecoration(
                                  // color: const Color.fromARGB(50, 100, 100, 100),
                                  border: h.isSended.value
                                      ? Border.all(color: Colors.green)
                                      : Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        isSaved
                                            ? Icon(
                                                FluentIcons.skype_circle_check,
                                                color: Colors.green)
                                            : const Icon(
                                                FluentIcons.sync_status_solid,
                                                color: Color.fromARGB(
                                                    90, 49, 49, 49),
                                              ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        FilledButton(
                                          child: const SizedBox(
                                              width: 100,
                                              child: Text("Save Value")),
                                          onPressed: () {
                                            setState(
                                              () {
                                                try {
                                                  final valueOutput =
                                                      h.ctrlToStringList(
                                                          textOutput,
                                                          "injector");
                                                  final valueRPM =
                                                      h.ctrlToStringList(
                                                          textColumn, "RPM");
                                                  final valueTPS =
                                                      h.ctrlToStringList(
                                                          textRow, "TPS");
                                                  for (var i = 0; i < 80; i++) {
                                                    print(
                                                        "${valueTPS[i]};${valueRPM[i]};${valueOutput[i]};");
                                                  }
                                                  // print(valueRPM);
                                                  // for (var i = 0; i < 8; i++) {
                                                  //   print(valueRPM[i * 10]);
                                                  // }
                                                  // print(valueTPS);
                                                  for (var i = 0;
                                                      i < h.slotData.value;
                                                      i++) {
                                                    if (valueOutput[i] >=
                                                        h.maxInjectorValue
                                                            .value) {
                                                      showSnackbar(
                                                        duration:
                                                            const Duration(
                                                                seconds: 3),
                                                        alignment:
                                                            Alignment.topRight,
                                                        context,
                                                        NotificationBar(
                                                          height: 13,
                                                          contextRoot: context,
                                                          type: "ERROR",
                                                          content: Text(
                                                              "Value(s) is more than maximum value settings at cell: ${i + 1}"),
                                                        ),
                                                      );
                                                      isSaved = false;
                                                    }
                                                  }
                                                  if (valueOutput[
                                                          h.slotData.value -
                                                              1] <=
                                                      h.maxInjectorValue
                                                          .value) {
                                                    h.onSave(
                                                      valueTPS,
                                                      valueRPM,
                                                      valueOutput,
                                                    );
                                                  }
                                                } catch (e) {
                                                  showSnackbar(
                                                    duration: const Duration(
                                                        seconds: 3),
                                                    alignment:
                                                        Alignment.topRight,
                                                    context,
                                                    NotificationBar(
                                                      height: 16,
                                                      contextRoot: context,
                                                      type: "ERROR",
                                                      content: Text(
                                                          "${e}value is invalid or still empty"),
                                                    ),
                                                  );
                                                  isSaved = false;
                                                }

                                                if (isSaved == true) {
                                                  showSnackbar(
                                                    duration: const Duration(
                                                        seconds: 3),
                                                    alignment:
                                                        Alignment.topRight,
                                                    context,
                                                    NotificationBar(
                                                      height: 10,
                                                      width: 14,
                                                      contextRoot: context,
                                                      type: "SUCCESS",
                                                      content:
                                                          Text("Value saved"),
                                                    ),
                                                  );
                                                }
                                              },
                                            );
                                          },
                                          //   style: ButtonStyle(
                                          //       backgroundColor: ,
                                          // ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        h.isSended.value && isSaved
                                            ? Icon(
                                                FluentIcons.skype_circle_check,
                                                color: Colors.green)
                                            : const Icon(
                                                FluentIcons.sync_status_solid,
                                                color: Color.fromARGB(
                                                    90, 49, 49, 49),
                                              ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        FilledButton(
                                          child: const SizedBox(
                                            width: 100,
                                            child: Text("Send Data"),
                                          ),
                                          onPressed: () => setState(
                                            () {
                                              h.ports.clear();
                                              h.ports = SerialPort
                                                  .getAvailablePorts();
                                              print(h.ports);
                                              if (h.ports.isEmpty) {
                                                showSnackbar(
                                                  duration: const Duration(
                                                      seconds: 3),
                                                  alignment: Alignment.topRight,
                                                  context,
                                                  NotificationBar(
                                                    contextRoot: context,
                                                    type: "ERROR",
                                                    content: const Text(
                                                      "No device connected",
                                                    ),
                                                  ),
                                                );
                                              }

                                              if (h.ports.isNotEmpty) {
                                                // final String hexOutput =
                                                //     h.ctrlToHex(textOutput, "injector");
                                                // final String hexRPM =
                                                //     h.ctrlToHex(textColumn, "RPM");
                                                // final String hexTPS =
                                                //     h.ctrlToHex(textRow, "TPS");
                                                List<String> outputData =
                                                    h.ctrlToHexListAll(
                                                  textRow,
                                                  textColumn,
                                                  textOutput,
                                                );
                                                print(outputData);
                                                showContentDialog(
                                                  context,
                                                  outputData,
                                                  textOutput,
                                                  textColumn,
                                                  textRow,
                                                );
                                              }
                                              // try {
                                              //   String outputData =
                                              //       h.ctrlToHexListAll(
                                              //     textRow,
                                              //     textColumn,
                                              //     textOutput,
                                              //   );

                                              isSaved = false;
                                              // }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // const SizedBox(
                            //   width: 80,
                            // ),
                          ],
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    RotatedBox(
                      quarterTurns: 3,
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 10, right: 70),
                        child: const Text(
                          "RPM",
                          style: TextStyle(fontSize: 18),
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
                                  style: TextStyle(fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                LabelRow(
                                    enabled: readOnlyRow,
                                    boxDecor: BoxDecoration(
                                      color: checkedRow
                                          ? colorEnabled
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
                              enabled: readOnlyColumn,
                              boxDecor: BoxDecoration(
                                color: checkedColumn
                                    ? colorEnabled
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
                                  readOnly: readOnlyInput,
                                  boxDecoration: BoxDecoration(
                                      color: checkedInput
                                          ? const Color.fromARGB(
                                              49, 110, 110, 110)
                                          : colorDisabled),
                                  textC: List.generate(
                                    h.slotData.value,
                                    (index) => textOutput[index],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
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
    );
  }
}

void _send(String data) {
  final HomeController hC = Get.put(HomeController());
  // final port = hC.ports[0];
  // print(port.writeBytesFromString());
}

void showContentDialog(
    BuildContext contexts, dataParsed, outputData, columnData, rowData) async {
  // final List intOutput = [];
  // final List<String> strOutput = [output.text.toString()];
  final HomeController h = Get.put(HomeController());
  final TextEditingController slotController =
      TextEditingController(text: "80");
  final TextEditingController baudrateController =
      TextEditingController(text: h.baudrate.toString());
  final TextEditingController delayController =
      TextEditingController(text: h.delaySend.toString());
  final TextEditingController maxCOMController =
      TextEditingController(text: h.maxCOM.toString());
  // final hexOutput = h.ctrlToHexList(outputData, "injector");
  // final hexRPM = h.ctrlToHexList(columnData, "RPM");
  // final hexTPS = h.ctrlToHexList(rowData, "TPS");

  // final textOutputList = h.ctrlToStringList(outputData, "injector");
  // final textRPMList = h.ctrlToStringList(columnData, "RPM");
  // final textTPSList = h.ctrlToStringList(rowData, "TPS");

  final textOutput = h.ctrlToString(outputData, "injector");
  final textRPM = h.ctrlToString(columnData, "RPM");
  final textTPS = h.ctrlToString(rowData, "TPS");

  var port = h.ports[0];

  // with 0x prefix
  // final hexOutput = intOutput.map((e) => "0x${e.toRadixString(16)}").toList();

  final result = await showDialog<String>(
    context: contexts,
    builder: (context) => ContentDialog(
      constraints: const BoxConstraints(maxWidth: 380, minHeight: 540),
      title: const Text('Send value to ECU?'),
      content: Column(
        children: [
          Text(
            "RPM :\n$textRPM\n\nTPS :\n$textTPS\n\nINJECTOR :\n$textOutput\n------------------------------------------------------------\nPORT        :    $port",
          ),
          // Row(
          //   children: [
          //     const Text("MAX COM DEVICE ID: "),
          //     const SizedBox(
          //       width: 10,
          //     ),
          //     TextInput(
          //       enabled: false,
          //       controller: maxCOMController,
          //     )
          //   ],
          // ),
          Row(
            children: [
              const Text("Baudrate  :"),
              const SizedBox(
                width: 10,
              ),
              TextInput(
                enabled: false,
                controller: baudrateController,
              )
            ],
          ),
          const Text(
              "------------------------------------------------------------"),
          Row(
            children: [
              const Text("Delay per cell            : "),
              const SizedBox(
                width: 10,
              ),
              TextInput(
                enabled: false,
                controller: delayController,
              ),
              const Text(" ms"),
            ],
          ),
          Row(
            children: [
              const Text("Total data to send     : "),
              const SizedBox(
                width: 10,
              ),
              TextInput(
                enabled: false,
                controller: slotController,
              ),
              const Text("cell(s)"),
            ],
          )
        ],
      ),
      actions: [
        Button(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context, 'User canceling');
            // Delete file here
          },
        ),
        FilledButton(
          child: const Text('OK'),
          onPressed: () async {
            var timeEach = int.parse(delayController.text);
            try {
              String slotData = "";

              showSnackbar(
                context,
                duration: Duration(
                    milliseconds: timeEach * (int.parse(slotController.text))),
                alignment: Alignment.topRight,
                NotificationBar(
                  height: 14.5,
                  width: 14.5,
                  isLong: true,
                  contextRoot: context,
                  type: "INFO",
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: const Text(
                          "Sending ...",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      // ProgressBar()
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 15, 5),
                        child: CircularCountDownTimer(
                          isReverse: true,
                          width: 45,
                          height: 45,
                          // duration: (timeEach * 3 / 1000).round(),
                          duration:
                              (timeEach * int.parse(slotController.text) / 1000)
                                  .round(),
                          fillColor: Colors.blue,
                          // fillGradient: LinearGradient(colors: [
                          //   Color.fromARGB(255, 1, 62, 109),
                          //   Color.fromARGB(255, 0, 120, 212)
                          // ]),
                          ringColor: const Color.fromARGB(49, 110, 110, 110),
                        ),
                      ),
                    ],
                  ),
                ),
                onDismiss: () async {
                  Navigator.pop(context, h.slotData.value.toString());
                  // showSnackbar(
                  //   duration: const Duration(seconds: 3),
                  //   alignment: Alignment.topRight,
                  //   context,
                  //   NotificationBar(
                  //     height: 16.5,
                  //     width: 16.5,
                  //     isLong: true,
                  //     contextRoot: context,
                  //     type: "INFO",
                  //     content: Text(
                  //       "------------------- ",
                  //     ),
                  //   ),
                  // );
                },
              );
              // for (var i = 0; i < h.slotData.value; i++) {
              //   slotData = "$slotData${dataParsed[i].toString()}";
              // }
              // print('"$slotData"');

              // var data = '"$slotData"';
              try {
                final portSend = SerialPort(h.ports[0], openNow: false);
                portSend.open();

                final valueOutput = h.ctrlToStringList(outputData, "injector");
                final valueRPM = h.ctrlToStringList(columnData, "RPM");
                final valueTPS = h.ctrlToStringList(rowData, "TPS");
                for (var i = 0; i < int.parse(slotController.text); i++) {
                  // print("${valueTPS[i]};${valueRPM[i]};${valueOutput[i]};");

                  if (i == 0) {
                    // portSend.wr
                    portSend.writeBytesFromString(
                        "wCC<${valueTPS[i]};${valueRPM[i]};${valueOutput[i]};${valueTPS[i + 1]};${valueRPM[i + 1]};${valueOutput[i + 1]};${valueTPS[i + 2]};${valueRPM[i + 2]};${valueOutput[i + 2]};${valueTPS[i + 3]};${valueRPM[i + 3]};${valueOutput[i + 3]};${valueTPS[i + 4]};${valueRPM[i + 4]};${valueOutput[i + 4]};${valueTPS[i + 5]};${valueRPM[i + 5]};${valueOutput[i + 5]};${valueTPS[i + 6]};${valueRPM[i + 6]};${valueOutput[i + 6]};${valueTPS[i + 7]};${valueRPM[i + 7]};${valueOutput[i + 7]};${valueTPS[i + 7]};${valueRPM[i + 7]};${valueOutput[i + 7]};${valueTPS[i + 7]};${valueRPM[i + 7]};${valueOutput[i + 7]};");
                    print(
                        "w0<${valueTPS[i]};${valueRPM[i]};${valueOutput[i]};${valueTPS[i + 1]};${valueRPM[i + 1]};${valueOutput[i + 1]}");
                  } else {
                    portSend.writeBytesFromString(
                        "${valueTPS[i + 1]};${valueRPM[i + 1]};${valueOutput[i + 1]};");
                    print("${valueTPS[i]};${valueRPM[i]};${valueOutput[i]};");
                  }
                  //DELAY TIME

                  await Future.delayed(Duration(milliseconds: timeEach));
                }
                portSend.close();

                // portSend.writeBytesFromString('w0<300;310;100;>');
                // for (var i = 0; i < int.parse(slotController.text) * 3; i++) {
                //   slotData = dataParsed[i].toString();
                //   // "${dataParsed[i].toString()}${dataParsed[i + 1].toString()}${dataParsed[i + 2].toString()}";
                //   // print(slotData);

                //   // _send(slotData);

                //   // [SERIAL_PORT32]
                //   try {
                //     final rep = slotData.replaceAll('\\x', '');
                //     print(rep);

                //     // portSend.writeBytesFromString(rep);

                //     // uint16_t val =
                //     //     0x1234;
                //     // final data =
                //     //     Uint16List
                //     //         .fromList([
                //     //   123,
                //     //   456,
                //     //   789
                //     // ]);
                //     // final bytez = data
                //     //     .buffer
                //     //     .asUint8List();
                //     // print("test" +
                //     //     bytez
                //     //         .toString());

                //     // final bytes = ;
                //     var listData = [];
                //     listData = slotData.split('\\x');
                //     print(slotData);
                //     // final msb = listData[2] + "00";
                //     final uint16Data = Uint16List.fromList(
                //         [int.parse("${listData[1]}", radix: 16), 00]);

                //     final bytes = uint16Data.buffer.asUint8List();
                //     // portSend.wr
                //     // portSend.writeBytesFromUint8List(bytes);
                //     portSend.writeBytesFromString('w0<30;31;32>');
                //     print(bytes);
                //   } catch (e) {
                //     showSnackbar(
                //       duration: const Duration(seconds: 3),
                //       alignment: Alignment.topRight,
                //       context,
                //       NotificationBar(
                //         contextRoot: context,
                //         type: "ERROR",
                //         content: Text(
                //           "Port already opened and : $e",
                //         ),
                //       ),
                //     );
                //   }

                //   //-- SerialSend.exe --//
                //   // Process.run(
                //   //   r'lib/assets/programs/SerialSend.exe',
                //   //   [
                //   //     '/devnum',
                //   //     maxCOMController.text,
                //   //     '/baudrate',
                //   //     baudrateController.text,
                //   //     '/hex',
                //   //     slotData
                //   //     // outputData,
                //   //     // columnData,
                //   //     // rowData
                //   //   ],
                //   // ).then(
                //   //   (ProcessResult results) async {
                //   //     // List stringSplit = [];
                //   //     // List tryingSplit = [];
                //   //     // String tests = "";

                //   //     print("out :" + results.stderr);

                //   //     print("err :" + results.stdout);

                //   //     results.stderr == null
                //   //         ? h.isSended.value = false
                //   //         : {
                //   //             h.logSended = h.logData(results.stderr),
                //   //             h.isSended.value = true
                //   //           };
                //   //   },
                //   // );

                //   //DELAY TIME
                //   await Future.delayed(Duration(milliseconds: timeEach));
                // }
              } catch (e) {
                showSnackbar(
                  duration: const Duration(seconds: 3),
                  alignment: Alignment.topRight,
                  context,
                  NotificationBar(
                    height: 11,
                    contextRoot: context,
                    type: "ERROR",
                    content: Text(
                      e.toString(),
                    ),
                  ),
                );
              }
              // h.onSave(textTPSList, textRPMList, textOutputList);
            } catch (e) {
              showSnackbar(
                duration: const Duration(seconds: 3),
                alignment: Alignment.topRight,
                context,
                NotificationBar(
                  height: 11,
                  contextRoot: context,
                  type: "ERROR",
                  content: const Text(
                    "There is a value(s) that empty or invalid",
                  ),
                ),
              );
            }
            // Navigator.pop(context, [textOutput, textRPM, textTPS].toString());
            h.isSended.value = false;
            // Navigator.pop(context, h.slotData.value.toString());
          },
        ),
      ],
    ),
  );
  // print(result);
  // print(hexRPM + hexTPS + hexOutput);
}
