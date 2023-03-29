import 'package:ddfapp/text_input.dart';
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
  // List placeHolder = [
  //   "10",
  //   "20",
  //   "30",
  //   "40",
  //   "50",
  //   "60",
  //   "70",
  //   "80",
  //   "90",
  //   "100",
  // ];
  String? placeHolder = "";

  @override
  Widget build(BuildContext context) {
    Color? textcolor = const Color.fromARGB(255, 255, 255, 255);
    return Row(
      children: List.generate(
        10,
        (index) => TextInput(
          disabled: disabled,
          placholder: placeHolder,
          boxDecoration: boxDecor,
          textcolor: textcolor,
          controller: textController[index],
        ),
      ),
    );
  }
}
