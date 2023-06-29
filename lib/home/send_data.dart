import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:ddfapp/text_input.dart';
import 'package:ddfapp/widgets/notification.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:serial_port_win32/serial_port_win32.dart';

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
          onPressed: () {
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
                  final portSend = SerialPort(h.ports[0], openNow: false);
                  portSend.open();

                  final List valueOutput =
                      h.ctrlToStringList(outputData, "injector");
                  final List valueRPM = h.ctrlToStringList(columnData, "RPM");
                  final List valueTPS = h.ctrlToStringList(rowData, "TPS");
                  var x = 0;

                  var packetTPS = "";
                  const bytes8 = 2;
                  var packetState = "1";
                  var changeCell = "F";
                  // const UNIT_SCALE = 10;
                  for (var i = 0; i < 9; i++) {
                    var rowIndex = i.toRadixString(8).padLeft(2, "0");
                    // ROW_INDEX = ROW_INDEX.padLeft(3, "\\x");
                    if (i == 8) {
                      for (var n = 0; n < 9; n++) {
                        packetTPS =
                            "$packetTPS${valueTPS[n].toRadixString(16).padLeft(4, "0")}";
                      }
                      portSend.writeBytesFromString(
                        packetTPS,
                      );
                      if (kDebugMode) {
                        print("$packetTPS${packetTPS.length + 2}");
                      }
                    } else {
                      String packetData = "$packetState$changeCell$rowIndex"
                          "${h.toHEX(valueRPM[x])}"
                          "${h.toHEX(valueOutput[x])}"
                          "${h.toHEX(valueOutput[x + 1])}"
                          "${h.toHEX(valueOutput[x + 2])}"
                          "${h.toHEX(valueOutput[x + 3])}"
                          "${h.toHEX(valueOutput[x + 4])}"
                          "${h.toHEX(valueOutput[x + 5])}"
                          "${h.toHEX(valueOutput[x + 6])}"
                          "${h.toHEX(valueOutput[x + 7])}"
                          "${h.toHEX(valueOutput[x + 8])}"
                          "${h.toHEX(valueOutput[x + 9])}";
                      String packetdataSize = (packetData.length + bytes8)
                          .toRadixString(8)
                          .padLeft(2, "0");
                      portSend.WriteTotalTimeoutMultiplier = 1;
                      portSend.writeBytesFromString(
                        // "first is baris, kemudian data + check manual "
                        packetData,
                      );
                      if (kDebugMode) {
                        print("$packetData$packetdataSize");
                      }
                      // print("${dataParsed}");
                      x += 10;
                    }

                    //     "w${i}CC<${valueTPS[x]};${valueRPM[x]};${valueOutput[x]};${valueTPS[x + 1]};${valueRPM[x + 1]};${valueOutput[x + 1]};${valueTPS[x + 2]};${valueRPM[x + 2]};${valueOutput[x + 2]};${valueTPS[x + 3]};${valueRPM[x + 3]};${valueOutput[x + 3]};${valueTPS[x + 4]};${valueRPM[x + 4]};${valueOutput[x + 4]};${valueTPS[x + 5]};${valueRPM[x + 5]};${valueOutput[x + 5]};${valueTPS[x + 6]};${valueRPM[x + 6]};${valueOutput[x + 6]};${valueTPS[x + 7]};${valueRPM[x + 7]};${valueOutput[x + 7]};${valueTPS[x + 8]};${valueRPM[x + 8]};${valueOutput[x + 8]};${valueTPS[x + 9]};${valueRPM[x + 9]};${valueOutput[x + 9]};>");
                    // print(
                    //     "w${i}CC<${valueTPS[x]};${valueRPM[x]};${valueOutput[x]};${valueTPS[x + 1]};${valueRPM[x + 1]};${valueOutput[x + 1]};${valueTPS[x + 2]};${valueRPM[x + 2]};${valueOutput[x + 2]};${valueTPS[x + 3]};${valueRPM[x + 3]};${valueOutput[x + 3]};${valueTPS[x + 4]};${valueRPM[x + 4]};${valueOutput[x + 4]};${valueTPS[x + 5]};${valueRPM[x + 5]};${valueOutput[x + 5]};${valueTPS[x + 6]};${valueRPM[x + 6]};${valueOutput[x + 6]};${valueTPS[x + 7]};${valueRPM[x + 7]};${valueOutput[x + 7]};${valueTPS[x + 8]};${valueRPM[x + 8]};${valueOutput[x + 8]};${valueTPS[x + 9]};${valueRPM[x + 9]};${valueOutput[x + 9]};>");

                    //DELAY TIME
                    Future.delayed(Duration(milliseconds: timeEach));
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
                        "pengiriman gagal $e",
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
