import 'package:ddfapp/widgets/text_input.dart';
import 'package:fluent_ui/fluent_ui.dart';

class LabelRow extends StatelessWidget {
  LabelRow(
      {super.key,
      required this.disabled,
      this.boxDecor,
      required this.textController});
  List textController = List.generate(10, (index) => TextEditingController());
  final bool disabled;
  final BoxDecoration? boxDecor;
  String? placeHolder = "";

  @override
  Widget build(BuildContext context) {
    Color? textcolor = const Color.fromARGB(255, 255, 255, 255);
    return Row(
      children: List.generate(
        10,
        (index) => TextInput(
          disabled: disabled,
          suffix: disabled
              ? null
              : IconButton(
                  style: ButtonStyle(
                      padding: ButtonState.all(
                          const EdgeInsets.fromLTRB(0, 0, 5, 0))),
                  focusable: false,
                  icon: const Icon(FluentIcons.cancel),
                  onPressed: () {
                    textController[index].clear();
                  },
                ),
          placholder: placeHolder,
          boxDecoration: boxDecor,
          textcolor: textcolor,
          controller: textController[index],
        ),
      ),
    );
  }
}
