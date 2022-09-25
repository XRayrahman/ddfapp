import 'package:evapp/text_input.dart';
import 'package:fluent_ui/fluent_ui.dart';

class LabelRow extends StatelessWidget {
  LabelRow({super.key, required this.enabled, this.boxDecor});
  final _textController1 = TextEditingController();
  final _textController2 = TextEditingController();
  final _textController3 = TextEditingController();
  final _textController4 = TextEditingController();
  final _textController5 = TextEditingController();
  final _textController6 = TextEditingController();
  final _textController7 = TextEditingController();
  final _textController8 = TextEditingController();
  final _textController9 = TextEditingController();
  final _textController10 = TextEditingController();
  final bool enabled;
  final BoxDecoration? boxDecor;

  @override
  Widget build(BuildContext context) {
    Color? textcolor = const Color.fromARGB(255, 255, 255, 255);
    return Row(
      children: [
        TextInput(
          placholder: "10",
          boxDecoration: boxDecor,
          textcolor: textcolor,
          controller: _textController1,
          enabled: enabled,
        ),
        TextInput(
          placholder: "20",
          boxDecoration: boxDecor,
          textcolor: textcolor,
          controller: _textController2,
          enabled: enabled,
        ),
        TextInput(
          placholder: "30",
          boxDecoration: boxDecor,
          textcolor: textcolor,
          controller: _textController3,
          enabled: enabled,
        ),
        TextInput(
          placholder: "40",
          boxDecoration: boxDecor,
          textcolor: textcolor,
          controller: _textController4,
          enabled: enabled,
        ),
        TextInput(
          placholder: "50",
          boxDecoration: boxDecor,
          textcolor: textcolor,
          controller: _textController5,
          enabled: enabled,
        ),
        TextInput(
          placholder: "60",
          boxDecoration: boxDecor,
          textcolor: textcolor,
          controller: _textController6,
          enabled: enabled,
        ),
        TextInput(
          placholder: "70",
          boxDecoration: boxDecor,
          textcolor: textcolor,
          controller: _textController7,
          enabled: enabled,
        ),
        TextInput(
          placholder: "80",
          boxDecoration: boxDecor,
          textcolor: textcolor,
          controller: _textController8,
          enabled: enabled,
        ),
        TextInput(
          placholder: "90",
          boxDecoration: boxDecor,
          textcolor: textcolor,
          controller: _textController9,
          enabled: enabled,
        ),
        TextInput(
          placholder: "100",
          boxDecoration: boxDecor,
          textcolor: textcolor,
          controller: _textController10,
          enabled: enabled,
        ),
      ],
    );
  }
}
