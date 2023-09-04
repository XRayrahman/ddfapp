import 'dart:async';

import 'package:ddfapp/home/home_controller.dart';
import 'package:ddfapp/widgets/text_input.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'dart:core';

// ignore: must_be_immutable
class GridInput extends StatefulWidget {
  GridInput(
      {super.key,
      required this.readOnly,
      required this.textC,
      this.boxDecoration});

  final bool readOnly;
  List<TextEditingController> textC =
      List.generate(80, (index) => TextEditingController());
  final BoxDecoration? boxDecoration;

  @override
  State<GridInput> createState() => _GridInputState();
}

class _GridInputState extends State<GridInput> {
  HomeController h = HomeController();
  final text = "0";
  Timer? timer;
  bool isButtonPressed = false;
  int i = 0;

  Color colorDisabled = const Color.fromARGB(200, 101, 101, 101);

  @override
  Widget build(BuildContext context) {
    int dataLength = h.slotData.value;
    final textController =
        List.generate(dataLength, (index) => widget.textC[index]);

    void startLoop(int indexRow, int indexColumn, int command) {
      timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        if (isButtonPressed) {
          int parsed =
              int.parse(textController[indexRow + (indexColumn * 10)].text);
          if (command == 0 && parsed > 0) {
            textController[indexRow + (indexColumn * 10)].text =
                (parsed - 1).toString();
          } else if (command == 1 && parsed < 5000) {
            textController[indexRow + (indexColumn * 10)].text =
                (parsed + 1).toString();
          }
        } else {
          timer.cancel(); // Stop the loop when the button is released
        }
      });
    }

    void stopLoop() {
      if (timer != null && timer!.isActive) {
        timer!.cancel();
      }
    }

    String? placeholder = "";
    return Column(
      children: List.generate(
          8,
          (indexColumn) => Row(
                children: List.generate(
                    10,
                    (indexRow) => TextInput(
                          disabled: widget.readOnly,
                          prefix: widget.readOnly
                              ? null
                              : GestureDetector(
                                  onLongPressStart: (details) {
                                    isButtonPressed = true;
                                    startLoop(indexRow, indexColumn, 0);
                                  },
                                  onLongPressEnd: (details) {
                                    isButtonPressed = false;
                                    stopLoop();
                                  },
                                  child: IconButton(
                                    style: ButtonStyle(
                                        elevation: ButtonState.all(50),
                                        padding: ButtonState.all(
                                            const EdgeInsets.fromLTRB(
                                                8, 5, 0, 5))),
                                    focusable: false,
                                    icon: const Icon(
                                      FluentIcons.remove,
                                      size: 10,
                                    ),
                                    onPressed: () {
                                      int parsed = int.parse(textController[
                                              indexRow + (indexColumn * 10)]
                                          .text);
                                      if (parsed <= 0) {
                                      } else {
                                        textController[
                                                indexRow + (indexColumn * 10)]
                                            .text = (parsed - 1).toString();
                                      }
                                    },
                                  ),
                                ),
                          suffix: widget.readOnly
                              ? null
                              : GestureDetector(
                                  onLongPressStart: (details) {
                                    isButtonPressed = true;
                                    startLoop(indexRow, indexColumn, 1);
                                  },
                                  onLongPressEnd: (details) {
                                    isButtonPressed = false;
                                    stopLoop();
                                  },
                                  child: IconButton(
                                    style: ButtonStyle(
                                        elevation: ButtonState.all(50),
                                        padding: ButtonState.all(
                                            const EdgeInsets.fromLTRB(
                                                0, 0, 5, 0))),
                                    focusable: false,
                                    icon: const Icon(
                                      FluentIcons.add,
                                      size: 10,
                                    ),
                                    onPressed: () {
                                      int parsed = int.parse(textController[
                                              indexRow + (indexColumn * 10)]
                                          .text);
                                      if (parsed >= 5000) {
                                      } else {
                                        textController[
                                                indexRow + (indexColumn * 10)]
                                            .text = (parsed + 1).toString();
                                      }
                                    },
                                  ),
                                ),
                          textcolor: const Color.fromARGB(255, 0, 0, 0),
                          placholder: placeholder,
                          controller:
                              textController[indexRow + (indexColumn * 10)],
                          boxDecoration: const BoxDecoration(
                              color: Color.fromARGB(30, 110, 110, 110)),
                        )),
              )),
    );
  }
}
