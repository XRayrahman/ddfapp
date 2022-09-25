import 'package:fluent_ui/fluent_ui.dart';
import 'package:evapp/grid_input.dart';
import 'package:evapp/label_column.dart';
import 'package:evapp/label_row.dart';
import 'package:evapp/side_widget.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  List txt = ["q", "w", "e", "r", "t"];
  @override
  Widget build(BuildContext context) {
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
                          textC0: TextEditingController(),
                          textC1: TextEditingController(),
                          textC2: TextEditingController(),
                          textC3: TextEditingController(),
                          textC4: TextEditingController(),
                          textC5: TextEditingController(),
                          textC6: TextEditingController(),
                          textC7: TextEditingController(),
                          textC8: TextEditingController(),
                          textC9: TextEditingController(),
                        ),
                        GridInput(
                          readOnly: readOnlyInput,
                          textC0: TextEditingController(),
                          textC1: TextEditingController(),
                          textC2: TextEditingController(),
                          textC3: TextEditingController(),
                          textC4: TextEditingController(),
                          textC5: TextEditingController(),
                          textC6: TextEditingController(),
                          textC7: TextEditingController(),
                          textC8: TextEditingController(),
                          textC9: TextEditingController(),
                        ),
                        GridInput(
                          readOnly: readOnlyInput,
                          textC0: TextEditingController(),
                          textC1: TextEditingController(),
                          textC2: TextEditingController(),
                          textC3: TextEditingController(),
                          textC4: TextEditingController(),
                          textC5: TextEditingController(),
                          textC6: TextEditingController(),
                          textC7: TextEditingController(),
                          textC8: TextEditingController(),
                          textC9: TextEditingController(),
                        ),
                        GridInput(
                          readOnly: readOnlyInput,
                          textC0: TextEditingController(),
                          textC1: TextEditingController(),
                          textC2: TextEditingController(),
                          textC3: TextEditingController(),
                          textC4: TextEditingController(),
                          textC5: TextEditingController(),
                          textC6: TextEditingController(),
                          textC7: TextEditingController(),
                          textC8: TextEditingController(),
                          textC9: TextEditingController(),
                        ),
                        GridInput(
                          readOnly: readOnlyInput,
                          textC0: TextEditingController(),
                          textC1: TextEditingController(),
                          textC2: TextEditingController(),
                          textC3: TextEditingController(),
                          textC4: TextEditingController(),
                          textC5: TextEditingController(),
                          textC6: TextEditingController(),
                          textC7: TextEditingController(),
                          textC8: TextEditingController(),
                          textC9: TextEditingController(),
                        ),
                        GridInput(
                          readOnly: readOnlyInput,
                          textC0: TextEditingController(),
                          textC1: TextEditingController(),
                          textC2: TextEditingController(),
                          textC3: TextEditingController(),
                          textC4: TextEditingController(),
                          textC5: TextEditingController(),
                          textC6: TextEditingController(),
                          textC7: TextEditingController(),
                          textC8: TextEditingController(),
                          textC9: TextEditingController(),
                        ),
                        GridInput(
                          readOnly: readOnlyInput,
                          textC0: TextEditingController(),
                          textC1: TextEditingController(),
                          textC2: TextEditingController(),
                          textC3: TextEditingController(),
                          textC4: TextEditingController(),
                          textC5: TextEditingController(),
                          textC6: TextEditingController(),
                          textC7: TextEditingController(),
                          textC8: TextEditingController(),
                          textC9: TextEditingController(),
                        ),
                        GridInput(
                          readOnly: readOnlyInput,
                          textC0: TextEditingController(),
                          textC1: TextEditingController(),
                          textC2: TextEditingController(),
                          textC3: TextEditingController(),
                          textC4: TextEditingController(),
                          textC5: TextEditingController(),
                          textC6: TextEditingController(),
                          textC7: TextEditingController(),
                          textC8: TextEditingController(),
                          textC9: TextEditingController(),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                    ),
                    Column(
                      children: [
                        FilledButton(
                          child: Text(flashText),
                          onPressed: () => setState(() {
                            testd = true;
                            Process.run('ls', ['-al']).then(
                              (ProcessResult results) {
                                showContentDialog(context, results.stdout);
                                // setState(() {
                                //   flashText = results.stdout;
                                // });
                              },
                            );
                          }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        testd
                            ? const SizedBox(
                                width: 15,
                                height: 15,
                                child: ProgressRing(),
                              )
                            : const SizedBox(),
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

void showContentDialog(BuildContext context, resultText) async {
  final result = await showDialog<String>(
    context: context,
    builder: (context) => ContentDialog(
      constraints: const BoxConstraints(maxWidth: 500),
      title: const Text('Flash program to Microcontroller?'),
      content: Text(
        resultText,
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
          child: const Text('Flash'),
          onPressed: () {
            Navigator.pop(context, 'User flashing program');
          },
        ),
      ],
    ),
  );
  print(result);
}
