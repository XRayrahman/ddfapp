import 'package:ddfapp/grid_input.dart';
import 'package:fluent_ui/fluent_ui.dart';

class FirstRow extends StatefulWidget {
  const FirstRow({super.key});

  @override
  State<FirstRow> createState() => _FirstRowState();
}

class _FirstRowState extends State<FirstRow> {
  List textOutput = <TextEditingController>[
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  @override
  Widget build(BuildContext context) {
    return GridInput(
      readOnly: false,
      textC0: textOutput[0],
      textC1: textOutput[1],
      textC2: textOutput[2],
      textC3: textOutput[3],
      textC4: textOutput[4],
      textC5: textOutput[5],
      textC6: textOutput[6],
      textC7: textOutput[7],
      textC8: textOutput[8],
      textC9: textOutput[9],
    );
  }
}
