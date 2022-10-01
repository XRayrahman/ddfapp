import 'package:fluent_ui/fluent_ui.dart';
import 'package:ddfapp/side_widget.dart';

class SideView extends StatelessWidget {
  const SideView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
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
    );
  }
}
