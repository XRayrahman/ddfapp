import 'package:ddfapp/home/data_controller.dart';
import 'package:ddfapp/text_input.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class LabelColumn extends StatefulWidget {
  LabelColumn(
      {super.key,
      required this.enabled,
      this.boxDecor,
      required this.textController});
  final List<TextEditingController> textController;
  // final _textController = TextEditingController();
  final bool enabled;
  final BoxDecoration? boxDecor;

  @override
  State<LabelColumn> createState() => _LabelColumnState();
}

class _LabelColumnState extends State<LabelColumn> {
  // List placeHolder = [
  String? placeHolder = "";

  HomeController h = HomeController();

  @override
  Widget build(BuildContext context) {
    final textController =
        List.generate(10, (index) => widget.textController[index]);

    Color? textcolor = const Color.fromARGB(255, 255, 255, 255);
    return Column(
      children: List.generate(
        10,
        (index) => TextInput(
          enabled: widget.enabled,
          placholder: placeHolder,
          boxDecoration: widget.boxDecor,
          textcolor: textcolor,
          controller: textController[index],
        ),
      ),
    );
  }
}
