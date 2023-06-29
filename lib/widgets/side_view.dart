import 'package:ddfapp/home/home_controller.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:ddfapp/widgets/side_widget.dart';
import 'package:ddfapp/widgets/side_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:serial_port_win32/serial_port_win32.dart';
import 'notification.dart';

class SideView extends StatefulWidget {
  const SideView({super.key});

  @override
  State<SideView> createState() => _SideViewState();
}

class _SideViewState extends State<SideView> {
  final SideController sC = Get.put(SideController());
  bool isMaximized = false;
  var portSelected = "COM1";

  @override
  Widget build(BuildContext context) {
    final SideController sC = SideController();
    final HomeController h = HomeController();
    // final TextEditingController portController =
    //     TextEditingController(text: sC.ports.toString());
    List listPort = ["COM1", "COM2"];

    return Container(
      // color: Color.fromARGB(255, 243, 243, 243),
      decoration: BoxDecoration(
        color: const Color.fromARGB(50, 100, 100, 100),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          // width: 200,
                          height: 150,
                          child: Obx(() => ToggleButton(
                                onChanged: (v) async {
                                  sC.isConnected.value = v;
                                  if (sC.isConnected.value == true) {
                                    try {
                                      h.ports = SerialPort.getAvailablePorts();
                                      SerialPort port = SerialPort(h.ports[0]);
                                      try {
                                        port.open();
                                      } catch (e) {
                                        throw Exception("port already opened");
                                      }

                                      if (sC.isConnected.value == true) {
                                        //   //READ PORT
                                        try {
                                          port.readBytesOnListen(4, (value) {
                                            List<int> intList =
                                                sC.byteToInt(value);

                                            try {
                                              sC.readRPM.value = intList[0];
                                              sC.readTPS.value = intList[1];
                                              sC.readMAP.value = intList[2];
                                            } catch (e) {
                                              if (kDebugMode) {
                                                print("waiting data...");
                                              }
                                            }
                                          });
                                        } catch (e) {
                                          port.close();
                                          // print(e);
                                        }
                                      } else {
                                        port.close();
                                      }
                                    } catch (e) {
                                      showSnackbar(
                                        duration: const Duration(seconds: 1),
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

                                      // print("ERROR: {$e}");
                                    }
                                  } else {
                                    try {
                                      h.ports = SerialPort.getAvailablePorts();
                                      SerialPort port = SerialPort(h.ports[0],
                                          openNow: false);

                                      port.close();
                                      showSnackbar(
                                        duration: const Duration(seconds: 1),
                                        alignment: Alignment.topRight,
                                        context,
                                        NotificationBar(
                                          contextRoot: context,
                                          type: "SUCCESS",
                                          content: const Text(
                                            "port closed",
                                          ),
                                        ),
                                      );
                                    } catch (e) {
                                      // print("ERROR: {$e}");
                                    }
                                  }
                                },
                                checked: sC.isConnected.value,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    FluentIcons.power_button,
                                    size: 60,
                                  ),
                                ),
                              ))),
                      Row(children: [
                        Expanded(
                            child: ComboBox<String>(
                          placeholder: const Text("PORT"),
                          value: portSelected,
                          items: listPort.map((e) {
                            return ComboBoxItem(
                              value: e.toString(),
                              child: Text(e.toString()),
                              // onTap: () => setState(
                              //   () {
                              //     portSelected = listPort[e];
                              //   },
                              // ),
                            );
                          }).toList(),
                          onChanged: ((value) => setState(() {
                                portSelected = value.toString();
                              })),
                        ))
                      ]),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              child: MediaQuery.of(context).size.width < 1450
                  ? Expanded(
                      child: ListView(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => SideWidget(
                              title: "TPS",
                              dataValue: "${sC.readTPS.toString()} V",
                              titleIcon: FluentIcons.chart_y_angle,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(() => SideWidget(
                                title: "RPM",
                                dataValue: sC.readRPM.toString(),
                                titleIcon: FluentIcons.speed_high,
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => SideWidget(
                              title: "MAP",
                              dataValue: "${sC.readMAP.toString()} V",
                              titleIcon: FluentIcons.duststorm,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => SideWidget(
                              title: "TEMP",
                              dataValue: "${sC.readTEMP.toString()} °C",
                              titleIcon: FluentIcons.frigid,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => SideWidget(
                              title: "INJ 1",
                              dataValue: "${sC.readTEMP.toString()} °C",
                              titleIcon: FluentIcons.frigid,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => SideWidget(
                              title: "INJ 2",
                              dataValue: "${sC.readTEMP.toString()} °C",
                              titleIcon: FluentIcons.frigid,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => SideWidget(
                              title: "INJ 3",
                              dataValue: "${sC.readTEMP.toString()} °C",
                              titleIcon: FluentIcons.frigid,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => SideWidget(
                              title: "INJ 4",
                              dataValue: "${sC.readTEMP.toString()} °C",
                              titleIcon: FluentIcons.frigid,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
                  : const Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              SideWidget(
                                title: "TPS",
                                dataValue: "0 V",
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
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            children: [
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
                            ],
                          ),
                        )
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
