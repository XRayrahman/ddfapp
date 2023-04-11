import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:ddfapp/home/home_controller.dart';
import 'package:ddfapp/widgets/divide.dart';
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
import 'package:ddfapp/widgets/notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController h = Get.put(HomeController());
  final SideController sC = Get.put(SideController());
  bool checkedRow = false;
  bool checkedColumn = false;
  bool checkedInput = true;
  bool readOnlyColumn = true;
  bool readOnlyRow = true;
  bool readOnlyInput = false;
  bool isSaved = false;
  int lengthOutput = 80;
  int lengthColumn = 8;
  int lengthRow = 10;
  Color colorEnabled = const Color.fromARGB(255, 0, 120, 212);
  Color colorInput = const Color.fromARGB(49, 110, 110, 110);
  Color colorDisabled = const Color.fromARGB(255, 101, 101, 101);

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
    List<TextEditingController> textOutput = List.generate(
      h.slotData.value,
      (index) => TextEditingController(
        text: h.listPoint[index][2].toString(),
      ),
    );

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
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          width: 100,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
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
                                              width: 80, child: Text(" TPS ")),
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
                                              width: 80, child: Text(" RPM ")),
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
                                              width: 80, child: Text(" INJ ")),
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
                                    const Divide(
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
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                          width: 120,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
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
                                                  // loadData();
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
                                                  boxDecoration: BoxDecoration(
                                                      color: colorInput),
                                                  disabled: false,
                                                  placholder: "injector",
                                                  controller: setInjectorVal),
                                            ),
                                            FilledButton(
                                              child: const Text("OK"),
                                              onPressed: () {
                                                setState(
                                                  () {
                                                    if (setInjectorVal.text ==
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
                                                                setInjectorVal
                                                                    .text) <
                                                            1000 &&
                                                        int.parse(setInjectorVal
                                                                .text) >=
                                                            0) {
                                                      h.onSetInjectorValue(
                                                          setInjectorVal.text);
                                                    } else {
                                                      showSnackbar(
                                                        duration:
                                                            const Duration(
                                                                seconds: 3),
                                                        alignment:
                                                            Alignment.topRight,
                                                        context,
                                                        NotificationBar(
                                                          height: 12,
                                                          contextRoot: context,
                                                          type: "ERROR",
                                                          content: const Text(
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
                                    const Divide(
                                      direction: Axis.vertical,
                                      size: 120,
                                      marginH: 20,
                                      marginV: 20,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
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
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
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
                                                  boxDecoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      color: colorInput),
                                                  disabled: false,
                                                  placholder: "min",
                                                  controller: setTPSValueMin),
                                            ),
                                            const Divider(
                                              direction: Axis.horizontal,
                                              size: 10,
                                            ),
                                            SizedBox(
                                              height: 35,
                                              child: TextInput(
                                                  boxDecoration: BoxDecoration(
                                                      color: colorInput),
                                                  disabled: false,
                                                  placholder: "max",
                                                  controller: setTPSValueMax),
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
                                                    if (setTPSValueMin.text ==
                                                            "" ||
                                                        setTPSValueMax.text ==
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
                                                            "Value should not be empty",
                                                          ),
                                                        ),
                                                      );
                                                    } else if (int.parse(
                                                            setTPSValueMin
                                                                .text) >=
                                                        int.parse(setTPSValueMax
                                                            .text)) {
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
                                                  boxDecoration: BoxDecoration(
                                                      color: colorInput),
                                                  disabled: false,
                                                  placholder: "min",
                                                  controller: setRPMValueMin),
                                            ),
                                            const Divider(
                                              direction: Axis.horizontal,
                                              size: 10,
                                            ),
                                            SizedBox(
                                              height: 35,
                                              child: TextInput(
                                                  boxDecoration: BoxDecoration(
                                                      color: colorInput),
                                                  disabled: false,
                                                  placholder: "max",
                                                  controller: setRPMValueMax),
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
                                                    if (setRPMValueMin.text ==
                                                            "" ||
                                                        setRPMValueMax.text ==
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
                                                            "Value should not be empty",
                                                          ),
                                                        ),
                                                      );
                                                    } else if (int.parse(
                                                            setRPMValueMin
                                                                .text) >=
                                                        int.parse(setRPMValueMax
                                                            .text)) {
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
                                                  boxDecoration: BoxDecoration(
                                                      color: colorInput),
                                                  disabled: false,
                                                  placholder: "min",
                                                  controller: setINJValueMin),
                                            ),
                                            const Divider(
                                              direction: Axis.horizontal,
                                              size: 10,
                                            ),
                                            SizedBox(
                                              height: 35,
                                              child: TextInput(
                                                  boxDecoration: BoxDecoration(
                                                      color: colorInput),
                                                  disabled: false,
                                                  placholder: "max",
                                                  controller: setINJValueMax),
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
                                                    if (setINJValueMin.text ==
                                                            "" ||
                                                        setINJValueMax.text ==
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
                                                            "Value should not be empty",
                                                          ),
                                                        ),
                                                      );
                                                    } else if (int.parse(
                                                            setINJValueMin
                                                                .text) >=
                                                        int.parse(setINJValueMax
                                                            .text)) {
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
                                    const Divide(
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
                                          ),
                                          width: 100,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
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
                                              checked: checkedInput,
                                              onChanged: (y) => setState(
                                                () {
                                                  checkedInput = y;
                                                  readOnlyInput = !y;
                                                },
                                              ),
                                              content: const Text(
                                                "INJ",
                                                textAlign: TextAlign.center,
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
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  // color: const Color.fromARGB(50, 100, 100, 100),
                                  border: h.isSended.value
                                      ? Border.all(color: Colors.green)
                                      : Border.all(color: Colors.white),
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
                                                    isSaved = true;
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
                                                      content: const Text(
                                                          "Value saved"),
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
                                                List<String> outputData =
                                                    h.ctrlToHexListAll(
                                                  textRow,
                                                  textColumn,
                                                  textOutput,
                                                );
                                                showContentDialog(
                                                  context,
                                                  outputData,
                                                  textOutput,
                                                  textColumn,
                                                  textRow,
                                                );
                                              }
                                              isSaved = false;
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
                              disabled: readOnlyColumn,
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
  final HomeController h = Get.put(HomeController());
  final TextEditingController slotController =
      TextEditingController(text: "80");
  final TextEditingController baudrateController =
      TextEditingController(text: h.baudrate.toString());
  final TextEditingController delayController =
      TextEditingController(text: h.delaySend.toString());
  // final TextEditingController maxCOMController =
  //     TextEditingController(text: h.maxCOM.toString());

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
          Row(
            children: [
              const Text("Baudrate  :"),
              const SizedBox(
                width: 10,
              ),
              TextInput(
                disabled: false,
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
                disabled: false,
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
                disabled: false,
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
            if (h.ports.isNotEmpty) {
              try {
                // String slotData = "";

                showSnackbar(
                  context,
                  duration: Duration(milliseconds: timeEach * 8),
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
                            duration: (timeEach * 8 / 1000).round(),
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

                  final valueOutput =
                      h.ctrlToStringList(outputData, "injector");
                  final valueRPM = h.ctrlToStringList(columnData, "RPM");
                  final valueTPS = h.ctrlToStringList(rowData, "TPS");
                  var x = 0;
                  for (var i = 0; i < 8; i++) {
                    portSend.writeBytesFromString(
                        "w${i}CC<${valueTPS[x]};${valueRPM[x]};${valueOutput[x]};${valueTPS[x + 1]};${valueRPM[x + 1]};${valueOutput[x + 1]};${valueTPS[x + 2]};${valueRPM[x + 2]};${valueOutput[x + 2]};${valueTPS[x + 3]};${valueRPM[x + 3]};${valueOutput[x + 3]};${valueTPS[x + 4]};${valueRPM[x + 4]};${valueOutput[x + 4]};${valueTPS[x + 5]};${valueRPM[x + 5]};${valueOutput[x + 5]};${valueTPS[x + 6]};${valueRPM[x + 6]};${valueOutput[x + 6]};${valueTPS[x + 7]};${valueRPM[x + 7]};${valueOutput[x + 7]};${valueTPS[x + 8]};${valueRPM[x + 8]};${valueOutput[x + 8]};${valueTPS[x + 9]};${valueRPM[x + 9]};${valueOutput[x + 9]};>");
                    print(
                        "w${i}CC<${valueTPS[x]};${valueRPM[x]};${valueOutput[x]};${valueTPS[x + 1]};${valueRPM[x + 1]};${valueOutput[x + 1]};${valueTPS[x + 2]};${valueRPM[x + 2]};${valueOutput[x + 2]};${valueTPS[x + 3]};${valueRPM[x + 3]};${valueOutput[x + 3]};${valueTPS[x + 4]};${valueRPM[x + 4]};${valueOutput[x + 4]};${valueTPS[x + 5]};${valueRPM[x + 5]};${valueOutput[x + 5]};${valueTPS[x + 6]};${valueRPM[x + 6]};${valueOutput[x + 6]};${valueTPS[x + 7]};${valueRPM[x + 7]};${valueOutput[x + 7]};${valueTPS[x + 8]};${valueRPM[x + 8]};${valueOutput[x + 8]};${valueTPS[x + 9]};${valueRPM[x + 9]};${valueOutput[x + 9]};>");

                    //DELAY TIME
                    x += 10;

                    await Future.delayed(Duration(milliseconds: timeEach));
                  }
                  portSend.close();
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
            } else {
              showSnackbar(
                duration: const Duration(seconds: 3),
                alignment: Alignment.topRight,
                context,
                NotificationBar(
                  height: 11,
                  contextRoot: context,
                  type: "ERROR",
                  content: const Text(
                    "Port not connected",
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
}
