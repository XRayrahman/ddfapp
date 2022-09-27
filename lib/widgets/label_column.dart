import 'package:ddfapp/text_input.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class LabelColumn extends StatelessWidget {
  LabelColumn({super.key, required this.enabled, this.boxDecor});
  final _textController = TextEditingController();
  final bool enabled;
  final BoxDecoration? boxDecor;

  @override
  Widget build(BuildContext context) {
    Color? textcolor = const Color.fromARGB(255, 255, 255, 255);
    return Column(
      children: [
        TextInput(
          placholder: "4500",
          boxDecoration: boxDecor,
          textcolor: textcolor,
          controller: _textController,
          enabled: enabled,
        ),
        TextInput(
          placholder: "4000",
          boxDecoration: boxDecor,
          textcolor: textcolor,
          enabled: enabled,
        ),
        TextInput(
          placholder: "3500",
          boxDecoration: boxDecor,
          textcolor: textcolor,
          enabled: enabled,
        ),
        TextInput(
          placholder: "3000",
          boxDecoration: boxDecor,
          textcolor: textcolor,
          enabled: enabled,
        ),
        TextInput(
          placholder: "2500",
          boxDecoration: boxDecor,
          textcolor: textcolor,
          enabled: enabled,
        ),
        TextInput(
          placholder: "2000",
          boxDecoration: boxDecor,
          textcolor: textcolor,
          enabled: enabled,
        ),
        TextInput(
          placholder: "1500",
          boxDecoration: boxDecor,
          textcolor: textcolor,
          enabled: enabled,
        ),
        TextInput(
          placholder: "1000",
          boxDecoration: boxDecor,
          textcolor: textcolor,
          enabled: enabled,
        ),
      ],
    );
  }
}
