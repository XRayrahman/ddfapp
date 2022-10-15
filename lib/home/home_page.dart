import 'package:ddfapp/home/home_controller.dart';
import 'package:ddfapp/text_input.dart';
import 'package:ddfapp/widgets/side_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:ddfapp/widgets/grid_input.dart';
import 'package:ddfapp/widgets/label_column.dart';
import 'package:ddfapp/widgets/label_row.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:ddfapp/widgets/notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController h = Get.put(HomeController());
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

  Future<File> get _pickFile async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: "Select a saved Data Value",
      type: FileType.custom,
      allowedExtensions: ['txt', 'log'],
    );

    if (result == null) return File("");

    PlatformFile file = result.files.single;
    return File(file.path.toString());
  }

  @override
  Widget build(BuildContext context) {
    Future<String> loadData() async {
      try {
        final file = await _pickFile;
        final load = await file.readAsString();
        final loadSplit = load.split(' ');
        List valueOutput = [];
        List valueTPS = [];
        List valueRPM = [];
        h.loadData = List.generate(
          80,
          (index) => loadSplit[index],
        );
        print(h.loadData);

        for (var i = 0; i < 8; i++) {
          valueOutput = h.ctrlToStringList(h.loadData[i], "injector");
        }

        for (var i = 0; i < 10; i++) {
          valueRPM = h.ctrlToStringList(h.loadData[i + 8], "RPM");
        }

        for (var i = 0; i < 10; i++) {
          valueTPS = h.ctrlToStringList(h.loadData[i + 18], "TPS");
        }
        h.onSave(
          valueTPS,
          valueRPM,
          valueOutput,
        );
        return h.loadData[0];
      } catch (e) {
        return e.toString();
      }
    }

    List<TextEditingController> textOutput = List.generate(
      lengthOutput,
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
                                      const Text("Set Injector value to :"),
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
                                      const Text("Set ALL value to       :"),
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
                                      const Text("Set ALL value to       :"),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Button(
                                        child: const SizedBox(
                                            width: 115,
                                            child: Text("LOAD DATA")),
                                        onPressed: () {
                                          setState(() {
                                            loadData();
                                            // final List splitData = dataBuffer.map(int.parse);
                                          });
                                        },
                                        //   style: ButtonStyle(
                                        //       backgroundColor: ,
                                        // ),
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
                                                i < lengthOutput;
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
                                                      lengthOutput - 1] <=
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
                                        // final String hexOutput =
                                        //     h.ctrlToHex(textOutput, "injector");
                                        // final String hexRPM =
                                        //     h.ctrlToHex(textColumn, "RPM");
                                        // final String hexTPS =
                                        //     h.ctrlToHex(textRow, "TPS");
                                        try {
                                          final outputData = h.ctrlToHexListAll(
                                            textRow,
                                            textColumn,
                                            textOutput,
                                          );

                                          // for (var i = 0; i < 9; i++) {
                                          //   sembilanData =
                                          //       "$sembilanData ${outputData[i].toString()}";
                                          // }
                                          // print(sembilanData);
                                          showContentDialog(
                                            context,
                                            outputData,
                                            textOutput,
                                            textColumn,
                                            textRow,
                                          );
                                        } catch (e) {
                                          showSnackbar(
                                            duration:
                                                const Duration(seconds: 3),
                                            alignment: Alignment.topRight,
                                            context,
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: InfoBar(
                                                  isLong: true,
                                                  title: const Text("ERROR"),
                                                  content: Text(
                                                      "${e}value is invalid or still empty"),
                                                  severity:
                                                      InfoBarSeverity.error,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
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
                                    80,
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
    BuildContext context, dataParsed, outputData, columnData, rowData) async {
  // final List intOutput = [];
  // final List<String> strOutput = [output.text.toString()];
  final HomeController h = Get.put(HomeController());
  final TextEditingController slotController =
      TextEditingController(text: "80");
  final hexOutput = h.ctrlToHexList(outputData, "injector");
  final hexRPM = h.ctrlToHexList(columnData, "RPM");
  final hexTPS = h.ctrlToHexList(rowData, "TPS");

  // final textOutputList = h.ctrlToStringList(outputData, "injector");
  // final textRPMList = h.ctrlToStringList(columnData, "RPM");
  // final textTPSList = h.ctrlToStringList(rowData, "TPS");

  final textOutput = h.ctrlToString(outputData, "injector");
  final textRPM = h.ctrlToString(columnData, "RPM");
  final textTPS = h.ctrlToString(rowData, "TPS");

  // with 0x prefix
  // final hexOutput = intOutput.map((e) => "0x${e.toRadixString(16)}").toList();

  final result = await showDialog<String>(
    context: context,
    builder: (context) => ContentDialog(
      constraints: const BoxConstraints(maxWidth: 380, maxHeight: 480),
      title: const Text('Send value to ECU?'),
      content: Column(
        children: [
          Text(
            "RPM :\n$textRPM\n\nTPS :\n$textTPS\n\nInjector :\n$textOutput",
          ),
          Row(
            children: [
              const Text("Total data to send (MAX = 80) :"),
              const SizedBox(
                width: 10,
              ),
              TextInput(
                enabled: false,
                controller: slotController,
              )
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
          onPressed: () {
            try {
              String slotData = "";
              h.slotData.value = int.parse(slotController.text);

              for (var i = 0; i < h.slotData.value; i++) {
                slotData = "$slotData ${dataParsed[i].toString()}";
              }
              print(slotData);
              try {
                Process.run(
                  r'C:\Users\Administrator\Downloads\Programs\SerialSend.exe',
                  [
                    '/devnum',
                    '5',
                    '/baudrate',
                    '9600',
                    '/hex',
                    r'sembilanData'
                    // outputData,
                    // columnData,
                    // rowData
                  ],
                ).then(
                  (ProcessResult results) async {
                    List stringSplit = [];
                    List tryingSplit = [];
                    String tests = "";
                    print("out :" + results.stderr);
                    print("err :" + results.stdout);
                    results.stderr == null
                        ? h.isSended.value = false
                        : {
                            h.isSended.value = true,
                            stringSplit = results.stderr.toString().split('\n'),
                            // tryingSplit = stringSplit[5].toString().split('...'),
                            tests = stringSplit[5],
                            tests =
                                tests.replaceAll(RegExp('[^A-Za-z0-9 ]'), ' '),
                            tryingSplit = tests
                                .toString()
                                .split('                             '),
                            // print(stringSplit[5]),
                            print(tests),
                            h.logSended =
                                "${stringSplit[2]} \n ${stringSplit[3]} \n ${stringSplit[4]} \n ${tryingSplit[tryingSplit.length - 2]} \n ${tryingSplit[tryingSplit.length - 1]}",
                            showSnackbar(
                              duration: const Duration(seconds: 3),
                              alignment: Alignment.topRight,
                              context,
                              NotificationBar(
                                height: 16.5,
                                width: 16.5,
                                isLong: true,
                                contextRoot: context,
                                type: "INFO",
                                content: Text(
                                  "------------------- \n${h.logSended}",
                                ),
                              ),
                            ),
                          };
                  },
                );
              } catch (e) {
                print(e.toString());
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
            Navigator.pop(context, h.slotData.value.toString());
          },
        ),
      ],
    ),
  );
  // print(result);
  // print(hexRPM + hexTPS + hexOutput);
}
