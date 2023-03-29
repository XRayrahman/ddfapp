import 'package:ddfapp/home/home_controller.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:ddfapp/side_widget.dart';
import 'package:ddfapp/widgets/side_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ddfapp/text_input.dart';
import 'package:serial_port_win32/serial_port_win32.dart';

class SideView extends StatefulWidget {
  const SideView({super.key});

  @override
  State<SideView> createState() => _SideViewState();
}

class _SideViewState extends State<SideView> {
  final SideController sC = Get.put(SideController());
  bool isMaximized = false;
  @override
  Widget build(BuildContext context) {
    final SideController sC = SideController();
    final HomeController h = HomeController();
    final TextEditingController portController =
        TextEditingController(text: sC.ports.toString());
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
                          child: Obx(
                            () => ToggleButton(
                              onChanged: (v) async {
                                sC.isConnected.value = v;
                                h.ports = SerialPort.getAvailablePorts();
                                print(h.ports);

                                // if (sC.isConnected.value == true) {
                                //   // while (true) {

                                //   //READ PORT
                                //   port.readBytesOnListen(8, (value) {
                                //     var split = value.toString();
                                //     final splitted = split.split(",");
                                //     print(splitted);

                                //     for (var x = 0; x < splitted.length; x++) {
                                //       splitted[x] =
                                //           splitted[x].replaceAll("[", " ");
                                //       splitted[x] =
                                //           splitted[x].replaceAll("]", " ");
                                //     }
                                //     sC.readRPM.value = int.parse(splitted[0]);
                                //     sC.readTPS.value = int.parse(splitted[1]);
                                //     sC.readMAP.value = int.parse(splitted[2]);
                                //     // sC.readTEMP.value =
                                //     //     int.parse(splitted[3]);
                                //   });
                                //   // }
                                //   print("done");
                                // } else {
                                //   port.close();
                                // }
                              },
                              checked: sC.isConnected.value,
                              child: Container(
                                alignment: Alignment.center,
                                child: const Icon(
                                  FluentIcons.power_button,
                                  size: 60,
                                ),
                              ),
                            ),
                          )),
                      Row(children: [
                        Expanded(
                          child: DropDownButton(
                              title: Text("PORT"),
                              trailing: Text("~"),
                              items: [
                                MenuFlyoutItem(
                                  text: Text(listPort[0]),
                                  onPressed: () => null,
                                ),
                                MenuFlyoutItem(
                                  text: Text(listPort[1]),
                                  onPressed: () => null,
                                )
                              ]),
                        )
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
                  : Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: const [
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
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            children: const [
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
