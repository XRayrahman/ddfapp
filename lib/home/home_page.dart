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
  int lengthController = 80;

  @override
  Widget build(BuildContext context) {
    List textOutput = List.generate(
        80,
        (index) =>
            TextEditingController(text: h.decsInjector[index].toString()));

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
                          textC0: textOutput[0],
                          textC1: textOutput[1],
                          textC2: textOutput[2],
                          textC3: textOutput[3],
                          textC4: textOutput[4],
                          textC5: textOutput[5],
                          textC6: textOutput[6],
                          textC7: textOutput[7],
                          textC8: textOutput[8],
                          textC9: textOutput[9],
                        ),
                        GridInput(
                          readOnly: readOnlyInput,
                          textC0: textOutput[10],
                          textC1: textOutput[11],
                          textC2: textOutput[12],
                          textC3: textOutput[13],
                          textC4: textOutput[14],
                          textC5: textOutput[15],
                          textC6: textOutput[16],
                          textC7: textOutput[17],
                          textC8: textOutput[18],
                          textC9: textOutput[19],
                        ),
                        GridInput(
                          readOnly: readOnlyInput,
                          textC0: textOutput[20],
                          textC1: textOutput[21],
                          textC2: textOutput[22],
                          textC3: textOutput[23],
                          textC4: textOutput[24],
                          textC5: textOutput[25],
                          textC6: textOutput[26],
                          textC7: textOutput[27],
                          textC8: textOutput[28],
                          textC9: textOutput[29],
                        ),
                        GridInput(
                          readOnly: readOnlyInput,
                          textC0: textOutput[30],
                          textC1: textOutput[31],
                          textC2: textOutput[32],
                          textC3: textOutput[33],
                          textC4: textOutput[34],
                          textC5: textOutput[35],
                          textC6: textOutput[36],
                          textC7: textOutput[37],
                          textC8: textOutput[38],
                          textC9: textOutput[39],
                        ),
                        GridInput(
                          readOnly: readOnlyInput,
                          textC0: textOutput[40],
                          textC1: textOutput[41],
                          textC2: textOutput[42],
                          textC3: textOutput[43],
                          textC4: textOutput[44],
                          textC5: textOutput[45],
                          textC6: textOutput[46],
                          textC7: textOutput[47],
                          textC8: textOutput[48],
                          textC9: textOutput[49],
                        ),
                        GridInput(
                          readOnly: readOnlyInput,
                          textC0: textOutput[50],
                          textC1: textOutput[51],
                          textC2: textOutput[52],
                          textC3: textOutput[53],
                          textC4: textOutput[54],
                          textC5: textOutput[55],
                          textC6: textOutput[56],
                          textC7: textOutput[57],
                          textC8: textOutput[58],
                          textC9: textOutput[59],
                        ),
                        GridInput(
                          readOnly: readOnlyInput,
                          textC0: textOutput[60],
                          textC1: textOutput[61],
                          textC2: textOutput[62],
                          textC3: textOutput[63],
                          textC4: textOutput[64],
                          textC5: textOutput[65],
                          textC6: textOutput[66],
                          textC7: textOutput[67],
                          textC8: textOutput[68],
                          textC9: textOutput[69],
                        ),
                        GridInput(
                          readOnly: readOnlyInput,
                          textC0: textOutput[70],
                          textC1: textOutput[71],
                          textC2: textOutput[72],
                          textC3: textOutput[73],
                          textC4: textOutput[74],
                          textC5: textOutput[75],
                          textC6: textOutput[76],
                          textC7: textOutput[77],
                          textC8: textOutput[78],
                          textC9: textOutput[79],
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
  // final List outputInt = [];
  // final List<String> strOutput = [output.text.toString()];
  final HomeController h = Get.put(HomeController());
  final List<String> outputStr =
      List.generate(output.length, (index) => output[index].text);
  final List<int> outputInt = outputStr.map(int.parse).toList();
  final hexOutput = outputInt.map((e) => e.toRadixString(16)).toList();

  // with 0x prefix
  // final hexOutput = outputInt.map((e) => "0x${e.toRadixString(16)}").toList();

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
            h.onSaveHex(hexOutput);
            Navigator.pop(context, hexOutput.toString());
          },
        ),
      ],
    ),
  );
  print(result);
}
