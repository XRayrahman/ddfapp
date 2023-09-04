import 'dart:io';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:ddfapp/widgets/text_input.dart';
import 'package:ddfapp/widgets/notification.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
// import 'package:serial_port_win32/serial_port_win32.dart';
import 'dart:io' show Directory;
// import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as path;
import 'package:ddfapp/api.dart';

import 'home_controller.dart';

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

  await showDialog<String>(
    context: contexts,
    builder: (context) => ContentDialog(
      constraints:
          const BoxConstraints(maxWidth: 380, minHeight: 540, maxHeight: 580),
      title: const Text('Send value to ECU?'),
      content: Column(
        children: [
          Text(
            "RPM :\n$textRPM\n\nTPS :\n$textTPS\n\nINJECTOR :\n$textOutput\n"
            "------------------------------------------------------------\n"
            "PORT        :    $port",
          ),
          Row(
            children: [
              const Text("Baudrate  :"),
              const SizedBox(
                width: 10,
              ),
              TextInput(
                disabled: true,
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
                showSnackbar(
                  context,
                  duration: Duration(milliseconds: timeEach * 8),
                  alignment: Alignment.topRight,
                  NotificationBar(
                    height: 18,
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
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 15, 5),
                          child: CircularCountDownTimer(
                            isReverse: true,
                            width: 45,
                            height: 45,
                            // duration: (timeEach * 3 / 1000).round(),
                            duration: (timeEach * 9 / 1000).round(),
                            fillColor: Colors.blue,
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
                try {
                  // final portSend = SerialPort(h.ports[0], openNow: false);
                  // portSend.open();
                  // try {
                  //   // const dec2hex = AnyBase(AnyBase.dec, AnyBase.hex);
                  //   // var test = dec2hex.convert('512.5');
                  //   // print(test);

                  //   for (var i = 0;
                  //       i < int.parse(slotController.text) * 3;
                  //       i++) {
                  //     var slotData = dataParsed[i].toString();
                  //     // "${dataParsed[i].toString()}${dataParsed[i + 1].toString()}${dataParsed[i + 2].toString()}";
                  //     // print(slotData);

                  //     Process.run(
                  //       r'lib/assets/programs/SerialSend.exe',
                  //       [
                  //         '/devnum',
                  //         'test',
                  //         '/baudrate',
                  //         baudrateController.text,
                  //         '/hex',
                  //         slotData
                  //         // outputData,
                  //         // columnData,
                  //         // rowData
                  //       ],
                  //     ).then(
                  //       (ProcessResult results) async {
                  //         // List stringSplit = [];
                  //         // List tryingSplit = [];
                  //         // String tests = "";

                  //         // print("out :" + results.stderr);

                  //         // print("err :" + results.stdout);

                  //         results.stderr == null
                  //             ? h.isSended.value = false
                  //             : {};
                  //       },
                  //     );
                  //     await Future.delayed(Duration(milliseconds: timeEach));
                  //   }
                  // } catch (e) {
                  //   showSnackbar(
                  //     duration: const Duration(seconds: 3),
                  //     alignment: Alignment.topRight,
                  //     context,
                  //     NotificationBar(
                  //       height: 11,
                  //       contextRoot: context,
                  //       type: "ERROR",
                  //       content: Text(
                  //         e.toString(),
                  //       ),
                  //     ),
                  //   );
                  // }

                  String libPath = "";
                  if (kReleaseMode) {
                    // I'm on release mode, absolute linking
                    final String localLib = path.join(
                        'data', 'flutter_assets', 'lib', 'assets', 'sern.dll');
                    libPath = path.join(
                        Directory(Platform.resolvedExecutable).parent.path,
                        localLib);
                  } else {
                    // I'm on debug mode, local linking
                    libPath = path.join(
                        Directory.current.path, 'lib', 'assets', 'sern.dll');
                  }

                  final customSerialCommunication =
                      CustomSerialCommunication(libPath);

                  final List injector =
                      h.ctrlToStringList(outputData, "injector");
                  final List rpm = h.ctrlToStringList(columnData, "RPM");
                  final List valueInjector = injector.cast<int>();
                  final List valueRPM = rpm.cast<int>();
                  final List valueTPS = h.ctrlToStringList(rowData, "TPS");
                  var x = 0;

                  if (h.ports.isEmpty) {
                    h.ports.add(0);
                  }
                  var packetTPS = "";
                  var listTPS =
                      List.generate(10, (index) => valueTPS[index % 10]);
                  var command = 1;

                  // print("TPS :" + listTPS.length.toString());
                  for (var i = 0; i < 9; i++) {
                    if (i == 0) {
                      for (var n = 0; n < 9; n++) {
                        packetTPS = "$packetTPS${valueTPS[n]}";
                      }

                      final resultTPS = customSerialCommunication.sendData(
                          0, h.baudrate.value, command, i, listTPS.cast<int>());

                      if (kDebugMode) {
                        if (resultTPS == 0) {
                          print('Data sent successfully.');
                        } else {
                          print('Failed to sending data.');
                        }
                      }
                    } else {
                      var listData = List<int>.filled(11, 0);
                      listData[0] = valueRPM[x];
                      listData[1] = valueInjector[x];
                      listData[2] = valueInjector[x + 1];
                      listData[3] = valueInjector[x + 2];
                      listData[4] = valueInjector[x + 4];
                      listData[5] = valueInjector[x + 5];
                      listData[6] = valueInjector[x + 3];
                      listData[7] = valueInjector[x + 6];
                      listData[8] = valueInjector[x + 7];
                      listData[9] = valueInjector[x + 8];
                      listData[10] = valueInjector[x + 9];
                      // Use your data bytes here

                      final result = customSerialCommunication.sendData(
                          0, h.baudrate.value, command, i, listData);
                      // String packetData = "$packetState$changeCell$rowIndex"
                      //     "${h.toHEX(valueRPM[x])}"
                      //     "${h.toHEX(valueOutput[x])}"
                      //     "${h.toHEX(valueOutput[x + 1])}"
                      //     "${h.toHEX(valueOutput[x + 2])}"
                      //     "${h.toHEX(valueOutput[x + 3])}"
                      //     "${h.toHEX(valueOutput[x + 4])}"
                      //     "${h.toHEX(valueOutput[x + 5])}"
                      //     "${h.toHEX(valueOutput[x + 6])}"
                      //     "${h.toHEX(valueOutput[x + 7])}"
                      //     "${h.toHEX(valueOutput[x + 8])}"
                      //     "${h.toHEX(valueOutput[x + 9])}";
                      // String packetdataSize = (packetData.length + bytes8)
                      //     .toRadixString(8)
                      //     .padLeft(2, "0");
                      // portSend.WriteTotalTimeoutMultiplier = 1;
                      // portSend.writeBytesFromString(
                      //   // "first is baris, kemudian data + check manual "
                      //   packetData,
                      // );
                      if (kDebugMode) {
                        if (result == 0) {
                          print('Data sent successfully.');
                        } else {
                          print('Failed to sending data.');
                        }
                      }
                      // print("${dataParsed}");
                      x += 10;
                      if (result == 0) {
                        showSnackbar(
                          duration: const Duration(seconds: 3),
                          alignment: Alignment.topRight,
                          context,
                          NotificationBar(
                            height: 10,
                            width: 14,
                            contextRoot: context,
                            type: "SUCCESS",
                            content: const Text("Data sent"),
                          ),
                        );
                      } else {
                        showSnackbar(
                          duration: const Duration(seconds: 3),
                          alignment: Alignment.topRight,
                          context,
                          NotificationBar(
                            height: 10,
                            width: 14,
                            contextRoot: context,
                            type: "ERROR",
                            content: const Text("Failed to sending data"),
                          ),
                        );
                      }
                    }
                    //DELAY TIME
                    Future.delayed(Duration(milliseconds: timeEach));
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
                        "pengiriman gagal \n$e",
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
