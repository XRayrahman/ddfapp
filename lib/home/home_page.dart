import 'package:ddfapp/home/home_controller.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:ddfapp/widgets/grid_input.dart';
import 'package:ddfapp/widgets/label_column.dart';
import 'package:ddfapp/widgets/label_row.dart';
import 'package:ddfapp/side_widget.dart';
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

  @override
  Widget build(BuildContext context) {
    List textOutput = List.generate(
      lengthOutput,
      (index) => TextEditingController(
        text: h.decsInjector[index][2].toString(),
      ),
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
                              color: checkedRow ? colorEnabled : colorDisabled),
                        ),
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
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Divider(size: 320, direction: Axis.vertical),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        // Divider(
                        //   size: 700,
                        // ),
                        GridInput(
                          readOnly: readOnlyInput,
                          textC:
                              List.generate(80, (index) => textOutput[index]),
                        ),
                        // GridInput(
                        //   readOnly: readOnlyInput,
                        //   textC: List.generate(
                        //       10, (index) => textOutput[(index + 10)]),
                        // ),
                        // GridInput(
                        //   readOnly: readOnlyInput,
                        //   textC: List.generate(
                        //       10, (index) => textOutput[(index + 20)]),
                        // ),
                        // GridInput(
                        //   readOnly: readOnlyInput,
                        //   textC: List.generate(
                        //       10, (index) => textOutput[(index + 30)]),
                        // ),
                        // GridInput(
                        //   readOnly: readOnlyInput,
                        //   textC: List.generate(
                        //       10, (index) => textOutput[(index + 40)]),
                        // ),
                        // GridInput(
                        //   readOnly: readOnlyInput,
                        //   textC: List.generate(
                        //       10, (index) => textOutput[(index + 50)]),
                        // ),
                        // GridInput(
                        //   readOnly: readOnlyInput,
                        //   textC: List.generate(
                        //       10, (index) => textOutput[(index + 60)]),
                        // ),
                        // GridInput(
                        //   readOnly: readOnlyInput,
                        //   textC: List.generate(
                        //       10, (index) => textOutput[(index + 70)]),
                        // ),
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
                                  FilledButton(
                                    child: const Text("refresh"),
                                    onPressed: () {
                                      setState(() {
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
                              Row(
                                children: [
                                  Text(
                                    h.hexInjector[0].toString(),
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
                              Process.run('ls', ['-al']).then(
                                (ProcessResult results) {
                                  showContentDialog(
                                      context, results.stdout, textOutput);
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
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SideWidget(
                        title: "TPS",
                        dataValue: "0 %",
                        titleIcon: FluentIcons.chart_y_angle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SideWidget(
                        title: "RPM",
                        dataValue: "0",
                        titleIcon: FluentIcons.speed_high,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SideWidget(
                        title: "MAP",
                        dataValue: "0 V",
                        titleIcon: FluentIcons.duststorm,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SideWidget(
                        title: "TEMP",
                        dataValue: "0 °C",
                        titleIcon: FluentIcons.frigid,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

void showContentDialog(BuildContext context, resultText, output) async {
  // final List intOutput = [];
  // final List<String> strOutput = [output.text.toString()];
  final HomeController h = Get.put(HomeController());
  final List<String> strOutput =
      List.generate(output.length, (index) => output[index].text);
  final List<int> intOutput = strOutput.map(int.parse).toList();
  final hexOutput = intOutput.map((e) => e.toRadixString(16)).toList();

  final List<String> strRPM =
      List.generate(output.length, (index) => output[index].text);
  final List<int> intRPM = strRPM.map(int.parse).toList();
  final hexRPM = intRPM.map((e) => e.toRadixString(16)).toList();

  // with 0x prefix
  // final hexOutput = intOutput.map((e) => "0x${e.toRadixString(16)}").toList();

  final result = await showDialog<String>(
    context: context,
    builder: (context) => ContentDialog(
      constraints: const BoxConstraints(maxWidth: 330),
      title: const Text('Save value to ECU?'),
      content: Text(
        "RPM Value :\n" +
            "Throttle Value :\n" +
            "Injection Data :\n" +
            hexOutput.toString(),
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
          child: const Text('Accept'),
          onPressed: () {
            h.onSaveHex(hexOutput, hexOutput, hexOutput);
            // Navigator.pop(context, hexOutput.toString());
            Navigator.pop(context, h.decsInjector.toString());
          },
        ),
      ],
    ),
  );
  print(result);
}
