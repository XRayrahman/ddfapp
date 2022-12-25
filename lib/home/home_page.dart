import 'dart:ffi';

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
      (index) => TextEditingController(
          text: index == 0
              ? h.listPoint[index][0].toString()
              : index == 1
                  ? h.listPoint[10][0].toString()
                  : index == 2
                      ? h.listPoint[20][0].toString()
                      : index == 3
                          ? h.listPoint[30][0].toString()
                          : index == 4
                              ? h.listPoint[40][0].toString()
                              : index == 5
                                  ? h.listPoint[50][0].toString()
                                  : index == 6
                                      ? h.listPoint[60][0].toString()
                                      : h.listPoint[70][0].toString()),
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
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Button(
                                        child: const SizedBox(
                                            width: 120,
                                            child:
                                                Text("Clear Injector Value")),
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
                                            child: Text("Clear TPS Value")),
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
                                            child: Text("Clear RPM Value")),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                              if (setInjectorValue.text == "") {
                                                showSnackbar(
                                                  duration: const Duration(
                                                      seconds: 3),
                                                  alignment: Alignment.topRight,
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
                                                      setInjectorValue.text) <
                                                  255) {
                                                h.onSetInjectorValue(
                                                    setInjectorValue.text);
                                              } else {
                                                showSnackbar(
                                                  duration: const Duration(
                                                      seconds: 3),
                                                  alignment: Alignment.topRight,
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
                                            width: 115, child: Text("DEFAULT")),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      ? Icon(FluentIcons.skype_circle_check,
                                          color: Colors.green)
                                      : const Icon(
                                          FluentIcons.sync_status_solid,
                                          color: Color.fromARGB(90, 49, 49, 49),
                                        ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  FilledButton(
                                    child: const SizedBox(
                                        width: 100, child: Text("Save Value")),
                                    onPressed: () {
                                      setState(
                                        () {
                                          try {
                                            final valueOutput =
                                                h.ctrlToStringList(
                                                    textOutput, "injector");
                                            final valueRPM = h.ctrlToStringList(
                                                textColumn, "RPM");
                                            final valueTPS = h.ctrlToStringList(
                                                textRow, "TPS");
                                            for (var i = 0;
                                                i < h.slotData.value;
                                                i++) {
                                              if (valueOutput[i] >=
                                                  h.maxInjectorValue.value) {
                                                showSnackbar(
                                                  duration: const Duration(
                                                      seconds: 3),
                                                  alignment:
                                                      Alignment.topCenter,
                                                  context,
                                                  NotificationBar(
                                                    height: 13,
                                                    contextRoot: context,
                                                    type: "ERROR",
                                                    content: Text(
                                                        "Value(s) is more than maximum value settings at $i"),
                                                  ),
                                                );
                                              } else if (valueOutput[
                                                      h.slotData.value - 1] <=
                                                  h.maxInjectorValue.value) {
                                                h.onSave(
                                                  valueTPS,
                                                  valueRPM,
                                                  valueOutput,
                                                );
                                                // showSnackbar(
                                                //   duration: const Duration(
                                                //       seconds: 3),
                                                //   alignment: Alignment.topRight,
                                                //   context,
                                                //   NotificationBar(
                                                //     height: 14,
                                                //     contextRoot: context,
                                                //     type: "SUCCESS",
                                                //     content:
                                                //         Text("Value saved"),
                                                //   ),
                                                // );
                                              }
                                            }
                                            isSaved = true;
                                          } catch (e) {
                                            showSnackbar(
                                              duration:
                                                  const Duration(seconds: 3),
                                              alignment: Alignment.topRight,
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
                                      ? Icon(FluentIcons.skype_circle_check,
                                          color: Colors.green)
                                      : const Icon(
                                          FluentIcons.sync_status_solid,
                                          color: Color.fromARGB(90, 49, 49, 49),
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
                                        h.ports =
                                            SerialPort.getAvailablePorts();
                                        print(h.ports[0]);
                                        final port = SerialPort(h.ports[0]);
                                        port.readBytesOnListen(8, (value) {
                                          var split = value.toString();
                                          final splitted = split.split(",");
                                          sC.readRPM.value = int.parse(
                                              splitted[1].replaceAll("[", ""));
                                          print(
                                              splitted[1].replaceAll("[", ""));
                                        });
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

                                        if (h.ports.isNotEmpty) {
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

                                        //   // for (var i = 0; i < 9; i++) {
                                        //   //   sembilanData =
                                        //   //       "$sembilanData ${outputData[i].toString()}";
                                        //   // }
                                        //   // print(sembilanData);
                                        //   showContentDialog(
                                        //     context,
                                        //     outputData,
                                        //     textOutput,
                                        //     textColumn,
                                        //     textRow,
                                        //   );
                                        // } catch (e) {
                                        //   showSnackbar(
                                        //     duration:
                                        //         const Duration(seconds: 3),
                                        //     alignment: Alignment.topRight,
                                        //     context,
                                        //     SizedBox(
                                        //       height: MediaQuery.of(context)
                                        //               .size
                                        //               .height /
                                        //           4,
                                        //       width: MediaQuery.of(context)
                                        //               .size
                                        //               .width /
                                        //           4,
                                        //       child: Padding(
                                        //         padding:
                                        //             const EdgeInsets.all(10.0),
                                        //         child: InfoBar(
                                        //           isLong: true,
                                        //           title: const Text("ERROR"),
                                        //           content: Text(
                                        //               "${e}value is invalid or still empty"),
                                        //           severity:
                                        //               InfoBarSeverity.error,
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   );
                                        // }
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
                ),
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
      constraints: const BoxConstraints(maxWidth: 380, maxHeight: 540),
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
                    milliseconds:
                        timeEach * (int.parse(slotController.text) * 3)),
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
                          duration: (timeEach *
                                  int.parse(slotController.text) *
                                  3 /
                                  1000)
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
                // const dec2hex = AnyBase(AnyBase.dec, AnyBase.hex);
                // var test = dec2hex.convert('512.5');
                // print(test);

                for (var i = 0; i < int.parse(slotController.text) * 3; i++) {
                  slotData = dataParsed[i].toString();
                  // "${dataParsed[i].toString()}${dataParsed[i + 1].toString()}${dataParsed[i + 2].toString()}";
                  // print(slotData);

                  Process.run(
                    r'lib/assets/programs/SerialSend.exe',
                    [
                      '/devnum',
                      maxCOMController.text,
                      '/baudrate',
                      baudrateController.text,
                      '/hex',
                      slotData
                      // outputData,
                      // columnData,
                      // rowData
                    ],
                  ).then(
                    (ProcessResult results) async {
                      // List stringSplit = [];
                      // List tryingSplit = [];
                      // String tests = "";

                      // print("out :" + results.stderr);

                      // print("err :" + results.stdout);

                      results.stderr == null
                          ? h.isSended.value = false
                          : {
                              h.logSended = h.logData(results.stderr),
                              h.isSended.value = true
                            };
                    },
                  );
                  await Future.delayed(Duration(milliseconds: timeEach));
                }
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
                    "There is a value(s) that empty or invalid)",
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
