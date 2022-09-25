import 'package:evapp/text_input.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'dart:core';

class GridInput extends StatelessWidget {
  const GridInput(
      {super.key,
      required this.readOnly,
      required this.textC1,
      required this.textC0,
      required this.textC2,
      required this.textC3,
      required this.textC4,
      required this.textC5,
      required this.textC6,
      required this.textC7,
      required this.textC8,
      required this.textC9});

  final bool readOnly;
  final TextEditingController textC0;
  final TextEditingController textC1;
  final TextEditingController textC2;
  final TextEditingController textC3;
  final TextEditingController textC4;
  final TextEditingController textC5;
  final TextEditingController textC6;
  final TextEditingController textC7;
  final TextEditingController textC8;
  final TextEditingController textC9;

  // final TEController1 = TextEditingController;

  // final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final textController = <TextEditingController>[
      textC0,
      textC1,
      textC2,
      textC3,
      textC4,
      textC5,
      textC6,
      textC7,
      textC8,
      textC9,
    ];
    final suffix = <Widget>[
      IconButton(
        icon: const Icon(FluentIcons.cancel),
        onPressed: () {
          textController[0].clear();
        },
      ),
      IconButton(
        icon: const Icon(FluentIcons.cancel),
        onPressed: () {
          textController[1].clear();
        },
      ),
      IconButton(
        icon: const Icon(FluentIcons.cancel),
        onPressed: () {
          textController[2].clear();
        },
      ),
      IconButton(
        icon: const Icon(FluentIcons.cancel),
        onPressed: () {
          textController[3].clear();
        },
      ),
      IconButton(
        icon: const Icon(FluentIcons.cancel),
        onPressed: () {
          textController[4].clear();
        },
      ),
      IconButton(
        icon: const Icon(FluentIcons.cancel),
        onPressed: () {
          textController[5].clear();
        },
      ),
      IconButton(
        icon: const Icon(FluentIcons.cancel),
        onPressed: () {
          textController[6].clear();
        },
      ),
      IconButton(
        icon: const Icon(FluentIcons.cancel),
        onPressed: () {
          textController[7].clear();
        },
      ),
      IconButton(
        icon: const Icon(FluentIcons.cancel),
        onPressed: () {
          textController[8].clear();
        },
      ),
      IconButton(
        icon: const Icon(FluentIcons.cancel),
        onPressed: () {
          textController[9].clear();
        },
      ),
    ];
    String? placeholder = "0";
    BoxDecoration boxDecoration = const BoxDecoration(
      color: Color.fromARGB(50, 100, 100, 100),
    );
    return Row(
      children: [
        TextInput(
          suffix: suffix[0],
          placholder: placeholder,
          controller: textController[0],
          boxDecoration: boxDecoration,
          enabled: readOnly,
        ),
        TextInput(
          suffix: suffix[1],
          placholder: placeholder,
          controller: textController[1],
          boxDecoration: boxDecoration,
          enabled: readOnly,
        ),
        TextInput(
          suffix: suffix[2],
          placholder: placeholder,
          controller: textController[2],
          boxDecoration: boxDecoration,
          enabled: readOnly,
        ),
        TextInput(
          suffix: suffix[3],
          placholder: placeholder,
          controller: textController[3],
          boxDecoration: boxDecoration,
          enabled: readOnly,
        ),
        TextInput(
          suffix: suffix[4],
          placholder: placeholder,
          controller: textController[4],
          boxDecoration: boxDecoration,
          enabled: readOnly,
        ),
        TextInput(
          suffix: suffix[5],
          placholder: placeholder,
          controller: textController[5],
          boxDecoration: boxDecoration,
          enabled: readOnly,
        ),
        TextInput(
          suffix: suffix[6],
          placholder: placeholder,
          controller: textController[6],
          boxDecoration: boxDecoration,
          enabled: readOnly,
        ),
        TextInput(
          suffix: suffix[7],
          placholder: placeholder,
          controller: textController[7],
          boxDecoration: boxDecoration,
          enabled: readOnly,
        ),
        TextInput(
          suffix: suffix[8],
          placholder: placeholder,
          controller: textController[8],
          boxDecoration: boxDecoration,
          enabled: readOnly,
        ),
        TextInput(
          suffix: suffix[9],
          placholder: placeholder,
          controller: textController[9],
          boxDecoration: boxDecoration,
          enabled: readOnly,
        ),
      ],
    );
  }
}
