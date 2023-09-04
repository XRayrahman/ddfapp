import 'package:fluent_ui/fluent_ui.dart';

class TextInput extends StatelessWidget {
  final String? placholder;
  final BoxDecoration? boxDecoration;
  final Widget? suffix;
  final Widget? prefix;
  final TextEditingController? controller;
  final bool disabled;
  final Color? textcolor;
  const TextInput(
      {super.key,
      this.placholder,
      this.boxDecoration,
      this.suffix,
      this.prefix,
      this.controller,
      required this.disabled,
      this.textcolor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      width: 90,
      height: 40,
      child: TextBox(
        // controller: TextEditingController.fromValue(value),
        decoration: boxDecoration,
        controller: controller,
        expands: false,
        placeholder: placholder,
        style: TextStyle(fontSize: 16, color: textcolor),
        placeholderStyle: TextStyle(fontSize: 16, color: textcolor),
        textAlign: TextAlign.center,
        suffix: suffix,
        prefix: prefix,
        readOnly: disabled,
        prefixMode: OverlayVisibilityMode.editing,
        suffixMode: OverlayVisibilityMode.editing,
        onSubmitted: (value) => "DONE!",
      ),
    );
  }
}
