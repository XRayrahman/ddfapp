import 'package:ddfapp/widgets/text_input.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:ddfapp/widgets/notification.dart';
import "home_controller.dart";
import 'package:ddfapp/widgets/divider.dart';
import 'package:get/get.dart';

class ConfigBar extends StatefulWidget {
  const ConfigBar({super.key});

  @override
  State<ConfigBar> createState() => _ConfigBarState();
}

class _ConfigBarState extends State<ConfigBar> {
  bool checkedRow = true;
  bool checkedColumn = true;
  bool checkedInput = true;
  bool readOnlyColumn = false;
  bool readOnlyRow = false;
  bool readOnlyInput = false;
  final HomeController h = Get.put(HomeController());
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
    TextEditingController setInjectorValue = TextEditingController();
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: 100,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  child: const SizedBox(width: 80, child: Text(" TPS ")),
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
                  child: const SizedBox(width: 80, child: Text(" RPM ")),
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
                  child: const SizedBox(width: 80, child: Text(" INJ ")),
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const SizedBox(
                //   height: 6,
                // ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  width: 120,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "INSERT",
                        // style: TextStyle(fontSize: 16),
                      ),
                      Icon(
                        FluentIcons.insert,
                        size: 14,
                      ),
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 5,
                // ),
                Row(
                  children: [
                    // const Text("Set ALL value       :"),
                    // const SizedBox(
                    //   width: 5,
                    // ),
                    Button(
                      child: const SizedBox(width: 110, child: Text("DEFAULT")),
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
                    // const Text("Import value       :"),
                    // const SizedBox(
                    //   width: 5,
                    // ),
                    Button(
                      child:
                          const SizedBox(width: 110, child: Text("LOAD DATA")),
                      onPressed: () {
                        setState(() {
                          // loadData();
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextInput(
                        disabled: false,
                        placholder: "injector",
                        controller: setInjectorValue),
                    // const SizedBox(
                    //   width: 5,
                    // ),
                    Button(
                      child: const Text("OK"),
                      onPressed: () {
                        setState(
                          () {
                            if (setInjectorValue.text == "") {
                              showSnackbar(
                                duration: const Duration(seconds: 3),
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
                            } else if (int.parse(setInjectorValue.text) < 255) {
                              h.onSetInjectorValue(setInjectorValue.text);
                            } else {
                              showSnackbar(
                                duration: const Duration(seconds: 3),
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const SizedBox(
                //   height: 6,
                // ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  width: 150,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "INSERT BY RANGE",
                        // style: TextStyle(fontSize: 16),
                      ),
                      Icon(
                        FluentIcons.insert,
                        size: 14,
                      ),
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 5,
                // ),
                Row(
                  children: [
                    // const Text("Set ALL value       :"),
                    // const SizedBox(
                    //   width: 5,
                    // ),
                    Button(
                      child: const SizedBox(width: 110, child: Text("DEFAULT")),
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
                    // const Text("Import value       :"),
                    // const SizedBox(
                    //   width: 5,
                    // ),
                    Button(
                      child:
                          const SizedBox(width: 110, child: Text("LOAD DATA")),
                      onPressed: () {
                        setState(() {
                          // loadData();
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextInput(
                        disabled: false,
                        placholder: "injector",
                        controller: setInjectorValue),
                    // const SizedBox(
                    //   width: 5,
                    // ),
                    Button(
                      child: const Text("OK"),
                      onPressed: () {
                        setState(
                          () {
                            if (setInjectorValue.text == "") {
                              showSnackbar(
                                duration: const Duration(seconds: 3),
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
                            } else if (int.parse(setInjectorValue.text) < 255) {
                              h.onSetInjectorValue(setInjectorValue.text);
                            } else {
                              showSnackbar(
                                duration: const Duration(seconds: 3),
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 8),
                  width: 130,
                  child: const Text(
                    "ENABLE VALUES",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
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
    );
  }
}
