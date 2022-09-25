import 'package:fluent_ui/fluent_ui.dart';

class TextInput extends StatelessWidget {
  final String? placholder;
  final BoxDecoration? boxDecoration;
  final Widget? suffix;
  final TextEditingController? controller;
  final bool enabled;
  final Color? textcolor;
  const TextInput(
      {super.key,
      this.placholder,
      this.boxDecoration,
      this.suffix,
      this.controller,
      required this.enabled,
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
        style: TextStyle(fontSize: 18, color: textcolor),
        placeholderStyle: TextStyle(fontSize: 18, color: textcolor),
        textAlign: TextAlign.center,
        suffix: suffix,
        readOnly: enabled,
        suffixMode: OverlayVisibilityMode.editing,
        onSubmitted: (value) => "DONE!",
      ),
    );
  }
}
