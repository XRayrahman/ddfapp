import 'package:ddfapp/home/home_controller.dart';
import 'package:ddfapp/text_input.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'dart:core';

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

  // final TEController1 = TextEditingController;
  @override
  Widget build(BuildContext context) {
    int dataLength = h.slotData.value;
    final textController =
        List.generate(dataLength, (index) => widget.textC[index]);

    // final suffix = List.generate(
    //   dataLength,
    //   (index) => IconButton(
    //     icon: const Icon(FluentIcons.cancel),
    //     onPressed: (() => setState(() {
    //           textController[index].clear;
    //         })),
    //   ),
    // );
    String? placeholder = "";
    // BoxDecoration boxDecoration = const BoxDecoration(
    //   color: Color.fromARGB(50, 100, 100, 100),
    // );
    return Column(
      children: List.generate(
        8,
        (indexColumn) => Row(
          children: List.generate(
            10,
            (indexRow) => indexColumn == 0
                ? TextInput(
                    disabled: widget.readOnly,
                    suffix: IconButton(
                      icon: const Icon(FluentIcons.cancel),
                      onPressed: () {
                        textController[indexRow].clear();
                      },
                    ),
                    placholder: placeholder,
                    controller: textController[indexRow],
                    boxDecoration: widget.boxDecoration,
                  )
                : indexColumn == 1
                    ? TextInput(
                        disabled: widget.readOnly,
                        suffix: IconButton(
                          icon: const Icon(FluentIcons.cancel),
                          onPressed: () {
                            textController[indexRow + 10].clear();
                          },
                        ),
                        placholder: placeholder,
                        controller: textController[indexRow + 10],
                        boxDecoration: widget.boxDecoration,
                      )
                    : indexColumn == 2
                        ? TextInput(
                            disabled: widget.readOnly,
                            suffix: IconButton(
                              icon: const Icon(FluentIcons.cancel),
                              onPressed: () {
                                textController[indexRow + 20].clear();
                              },
                            ),
                            placholder: placeholder,
                            controller: textController[indexRow + 20],
                            boxDecoration: widget.boxDecoration,
                          )
                        : indexColumn == 3
                            ? TextInput(
                                disabled: widget.readOnly,
                                suffix: IconButton(
                                  icon: const Icon(FluentIcons.cancel),
                                  onPressed: () {
                                    textController[indexRow + 30].clear();
                                  },
                                ),
                                placholder: placeholder,
                                controller: textController[indexRow + 30],
                                boxDecoration: widget.boxDecoration,
                              )
                            : indexColumn == 4
                                ? TextInput(
                                    disabled: widget.readOnly,
                                    suffix: IconButton(
                                      icon: const Icon(FluentIcons.cancel),
                                      onPressed: () {
                                        textController[indexRow + 40].clear();
                                      },
                                    ),
                                    placholder: placeholder,
                                    controller: textController[indexRow + 40],
                                    boxDecoration: widget.boxDecoration,
                                  )
                                : indexColumn == 5
                                    ? TextInput(
                                        disabled: widget.readOnly,
                                        suffix: IconButton(
                                          icon: const Icon(FluentIcons.cancel),
                                          onPressed: () {
                                            textController[indexRow + 50]
                                                .clear();
                                          },
                                        ),
                                        placholder: placeholder,
                                        controller:
                                            textController[indexRow + 50],
                                        boxDecoration: widget.boxDecoration,
                                      )
                                    : indexColumn == 6
                                        ? TextInput(
                                            disabled: widget.readOnly,
                                            suffix: IconButton(
                                              icon: const Icon(
                                                  FluentIcons.cancel),
                                              onPressed: () {
                                                textController[indexRow + 60]
                                                    .clear();
                                              },
                                            ),
                                            placholder: placeholder,
                                            controller:
                                                textController[indexRow + 60],
                                            boxDecoration: widget.boxDecoration,
                                          )
                                        : TextInput(
                                            disabled: widget.readOnly,
                                            suffix: IconButton(
                                              icon: const Icon(
                                                  FluentIcons.cancel),
                                              onPressed: () {
                                                textController[indexRow + 70]
                                                    .clear();
                                              },
                                            ),
                                            placholder: placeholder,
                                            controller:
                                                textController[indexRow + 70],
                                            boxDecoration: widget.boxDecoration,
                                          ),
          ),
        ),
      ),
    );
  }
}
