import 'package:fluent_ui/fluent_ui.dart';
import 'package:ddfapp/side_widget.dart';
import 'package:ddfapp/widgets/side_controller.dart';
import 'package:get/get.dart';

class SideView extends StatefulWidget {
  const SideView({super.key});

  @override
  State<SideView> createState() => _SideViewState();
}

class _SideViewState extends State<SideView> {
  final SideController sC = Get.put(SideController());
  bool checkedPower = false;
  bool isMaximized = false;
  @override
  Widget build(BuildContext context) {
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
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    // width: 200,
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
                ),
              ],
            ),
            Container(
              child: MediaQuery.of(context).size.width < 1450
                  ? Expanded(
                      child: ListView(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SideWidget(
                            title: "TPS",
                            dataValue: "0 %",
                            titleIcon: FluentIcons.chart_y_angle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(() => SideWidget(
                                title: "RPM",
                                dataValue: sC.readRPM.toString(),
                                titleIcon: FluentIcons.speed_high,
                              )),
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
