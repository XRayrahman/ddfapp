import 'package:ddfapp/text_input.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class LabelColumn extends StatelessWidget {
  LabelColumn(
      {super.key,
      required this.disabled,
      this.boxDecor,
      required this.textController});
  List textController = List.generate(8, (index) => TextEditingController());
  // final _textController = TextEditingController();
  final bool disabled;
  final BoxDecoration? boxDecor;
  // List placeHolder = [
  //   "1000",
  //   "1500",
  //   "2000",
  //   "2500",
  //   "3000",
  //   "3500",
  //   "4000",
  //   "4500",
  // ];
  String? placeHolder = "";

  @override
  Widget build(BuildContext context) {
    Color? textcolor = const Color.fromARGB(255, 255, 255, 255);
    return Column(
      children: List.generate(
        8,
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
