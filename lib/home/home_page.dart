import 'dart:ffi';

import 'package:ddfapp/home/home_controller.dart';
import 'package:ddfapp/widgets/side_view.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:ddfapp/widgets/grid_input.dart';
import 'package:ddfapp/widgets/label_column.dart';
import 'package:ddfapp/widgets/label_row.dart';
import 'package:get/get.dart';
import 'dart:io';

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
  bool checkedPower = false;
  bool readOnlyColumn = false;
  bool readOnlyRow = false;
  bool readOnlyInput = false;
  Color colorEnabled = const Color.fromARGB(255, 0, 120, 212);
  Color colorDisabled = const Color.fromARGB(255, 101, 101, 101);
  bool testd = false;
  String flashText = "flash program";
  int lengthOutput = 80;
  int lengthColumn = 8;
  int lengthRow = 10;

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> textOutput = List.generate(
      lengthOutput,
      (index) => TextEditingController(
        text: h.listPoint[index][2].toString(),
      ),
    );

    List textColumn = List.generate(
      lengthColumn,
      (index) => TextEditingController(
        text: h.listPoint[index][0].toString(),
      ),
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
          RotatedBox(
            quarterTurns: 3,
            child: Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: const Text(
                "RPM",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 111,
                    ),
                    Column(
                      children: [
                        const Text(
                          "THROTTLE POSITION (%)",
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        LabelRow(
                            enabled: readOnlyRow,
                            boxDecor: BoxDecoration(
                              color: checkedRow ? colorEnabled : colorDisabled,
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
                        color: checkedColumn ? colorEnabled : colorDisabled,
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
                          textC: List.generate(
                            80,
                            (index) => textOutput[index],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
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
                                height: 5,
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
                                height: 5,
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
                            ],
                          ),
                          const SizedBox(
                            width: 25,
                          ),
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
                                    child:
                                        const Text("Clear All Injector Value"),
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
                                    child: const Text("Clear All TPS Value"),
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
                                  FilledButton(
                                    child: const Text("refresh"),
                                    onPressed: () {
                                      setState(() {
                                        textColumn = List.generate(
                                          8,
                                          (index) => TextEditingController(
                                            text: h.decRPM.toString(),
                                          ),
                                        );
                                        // textColumn = List.generate(
                                        //   8,
                                        //   (index) => TextEditingController(
                                        //       text: index == 0
                                        //           ? h.hexRPM[index].toString()
                                        //           : index == 1
                                        //               ? h.hexRPM[10].toString()
                                        //               : index == 2
                                        //                   ? h.hexRPM[20]
                                        //                       .toString()
                                        //                   : index == 3
                                        //                       ? h.hexRPM[30]
                                        //                           .toString()
                                        //                       : index == 4
                                        //                           ? h.hexRPM[40]
                                        //                               .toString()
                                        //                           : index == 5
                                        //                               ? h.hexRPM[
                                        //                                       50]
                                        //                                   .toString()
                                        //                               : index ==
                                        //                                       6
                                        //                                   ? h.hexRPM[60]
                                        //                                       .toString()
                                        //                                   : h.hexRPM[70]
                                        //                                       .toString()),
                                        // );
                                        textRow = List.generate(
                                          10,
                                          (index) => TextEditingController(
                                            text: h.decTPS.toString(),
                                          ),
                                        );
                                        textOutput = List.generate(
                                          80,
                                          (index) => TextEditingController(
                                            text:
                                                h.hexInjector[index].toString(),
                                          ),
                                        );
                                      });
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              // Row(
                              //   children: [
                              //     Text(
                              //       h.hexInjector[0].toString(),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  FilledButton(
                                    child: const Text("Save Value"),
                                    onPressed: () {
                                      setState(() {
                                        final hexOutput =
                                            h.strToHex(textOutput, "injector");
                                        final hexRPM =
                                            h.strToHex(textColumn, "RPM");
                                        final hexTPS =
                                            h.strToHex(textRow, "TPS");
                                        h.onSaveHex(
                                          hexTPS,
                                          hexRPM,
                                          hexOutput,
                                        );
                                      });
                                    },
                                    //   style: ButtonStyle(
                                    //       backgroundColor: ,
                                    // ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        FilledButton(
                          child: Text(flashText),
                          onPressed: () => setState(() {
                            if (h.hexInjector == null) {
                            } else {
                              testd = true;
                              final hexOutput =
                                  h.strToHex(textOutput, "injector");
                              final hexRPM = h.strToHex(textColumn, "RPM");
                              final hexTPS = h.strToHex(textRow, "TPS");
                              Process.run('echo', [
                                "RPM : $hexRPM \nTPS : $hexTPS \nInjector : $hexOutput"
                              ]).then(
                                (ProcessResult results) {
                                  showContentDialog(context, results.stdout,
                                      textOutput, textColumn, textRow);
                                },
                              );
                            }
                          }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // testd
                        //     ? const SizedBox(
                        //         width: 15,
                        //         height: 15,
                        //         child: ProgressRing(),
                        //       )
                        //     : const SizedBox(),
                      ],
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            width: 150,
            // color: Color.fromARGB(255, 243, 243, 243),
            decoration: BoxDecoration(
              color: const Color.fromARGB(50, 100, 100, 100),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  width: 200,
                  height: 180,
                  child: ToggleButton(
                    onChanged: (v) {
                      setState(() {
                        checkedPower = v;
                      });
                    },
                    checked: checkedPower,
                    child: Container(
                      alignment: Alignment.center,
                      child: const Icon(
                        FluentIcons.power_button,
                        size: 60,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SideView(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

void showContentDialog(
    BuildContext context, resultText, outputData, columnData, rowData) async {
  // final List intOutput = [];
  // final List<String> strOutput = [output.text.toString()];
  final HomeController h = Get.put(HomeController());
  final hexOutput = h.strToHexList(outputData, "injector");
  final hexRPM = h.strToHexList(columnData, "RPM");
  final hexTPS = h.strToHexList(rowData, "TPS");

  // with 0x prefix
  // final hexOutput = intOutput.map((e) => "0x${e.toRadixString(16)}").toList();

  final result = await showDialog<String>(
    context: context,
    builder: (context) => ContentDialog(
      constraints: const BoxConstraints(maxWidth: 330),
      title: const Text('Save value to ECU?'),
      content: Text(
          // "RPM Value :\n" +
          //     hexRPM.toString() +
          //     "\nThrottle Value :\n" +
          //     hexTPS.toString() +
          //     "\nInjection Data :\n" +
          //     hexOutput.toString(),
          resultText),
      actions: [
        Button(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context, 'User canceling');
            // Delete file here
          },
        ),
        FilledButton(
          child: const Text('Accept'),
          onPressed: () {
            h.onSaveHex(hexRPM, hexTPS, hexOutput);
            // Navigator.pop(context, hexOutput.toString());
            Navigator.pop(context, h.listPoint.toString());
          },
        ),
      ],
    ),
  );
  print(resultText);
}
