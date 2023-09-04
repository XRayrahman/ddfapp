import 'package:fluent_ui/fluent_ui.dart';

abstract class state extends StatefulWidget {
  const state({super.key});

  @override
  State<state> createState() => _state();
}

class _state extends State<state> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
