import 'package:fluent_ui/fluent_ui.dart';

class NotificationBar extends StatelessWidget {
  NotificationBar({
    super.key,
    required this.contextRoot,
    this.type,
    this.height,
    this.width,
    this.isLong,
    required this.content,
  });

  BuildContext contextRoot;
  double? height = 10;
  double? width = 200;
  Widget content = const Text("");
  String? type = "";
  bool? isLong = false;
  bool isLongConst = false;

  @override
  Widget build(BuildContext context) {
    height ??= 10;
    width ??= 16;
    if (isLong == true) {
      isLongConst = true;
    }

    return SizedBox(
      height: (MediaQuery.of(contextRoot).size.height / 100) * height!,
      // width: MediaQuery.of(context).size.width / 4,
      width: (MediaQuery.of(contextRoot).size.width + width!) / 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InfoBar(
            isLong: isLongConst,
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
