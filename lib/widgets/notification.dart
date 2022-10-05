import 'package:fluent_ui/fluent_ui.dart';

class NotificationBar extends StatelessWidget {
  NotificationBar({
    super.key,
    required this.contextRoot,
    this.type,
    this.height,
    this.width,
    required this.content,
  });

  BuildContext contextRoot;
  double? height = 11;
  double? width = 4;
  Widget content = Text("");
  String? type = "";

  @override
  Widget build(BuildContext context) {
    height ??= 9;
    width ??= 16;

    return Container(
      height: MediaQuery.of(contextRoot).size.height / (20 - height!),
      // width: MediaQuery.of(context).size.width / 4,
      width: MediaQuery.of(contextRoot).size.width / (20 - width!),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: InfoBar(
            // isLong: true,
            title: Text(type == null ? "INFO" : type.toString()),
            content: content,
            severity: type == "ERROR"
                ? InfoBarSeverity.error
                : type == "SUCCESS"
                    ? InfoBarSeverity.success
                    : InfoBarSeverity.info),
      ),
    );
  }
}
