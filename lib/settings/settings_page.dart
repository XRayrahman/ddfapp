import 'package:fluent_ui/fluent_ui.dart';
import '../widgets/text_input.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController exhaustController = TextEditingController();

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                // padding:
                // const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 270,
                width: 350,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.8),
                      offset: const Offset(-6.0, -6.0),
                      blurRadius: 16.0,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(6.0, 6.0),
                      blurRadius: 16.0,
                    ),
                  ],
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      // width: 400,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // width: 300,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "TEMPERATURE",
                                      style: TextStyle(fontSize: 24),
                                    ),
                                    Icon(
                                      FluentIcons.frigid,
                                      size: 24,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Max. Temp (exhaust) :"),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    TextInput(
                                      disabled: false,
                                      controller: exhaustController,
                                      placholder: 0.toString(),
                                      prefix: GestureDetector(
                                        onLongPressStart: (details) {},
                                        //   isButtonPressed = true;
                                        //   startLoop(indexRow, indexColumn, 1);
                                        // },
                                        // onLongPressEnd: (details) {
                                        //   isButtonPressed = false;
                                        //   stopLoop();
                                        // },
                                        child: IconButton(
                                          style: ButtonStyle(
                                              elevation: ButtonState.all(50),
                                              padding: ButtonState.all(
                                                  const EdgeInsets.fromLTRB(
                                                      8, 0, 0, 0))),
                                          focusable: false,
                                          icon: const Icon(
                                            FluentIcons.remove,
                                            size: 10,
                                          ),
                                          onPressed: () {
                                            exhaustController.text = (int.parse(
                                                        exhaustController
                                                            .text) -
                                                    1)
                                                .toString();
                                          },
                                        ),
                                      ),
                                      suffix: GestureDetector(
                                        onLongPressStart: (details) {},
                                        //   isButtonPressed = true;
                                        //   startLoop(indexRow, indexColumn, 1);
                                        // },
                                        // onLongPressEnd: (details) {
                                        //   isButtonPressed = false;
                                        //   stopLoop();
                                        // },
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
                                            exhaustController.text = (int.parse(
                                                        exhaustController
                                                            .text) +
                                                    1)
                                                .toString();
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Min Temp (Reducer) :"),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    TextInput(
                                        disabled: false,
                                        controller: TextEditingController()),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Default Injector Value :"),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    TextInput(
                                        disabled: false,
                                        controller: TextEditingController()),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 243, 243, 243),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12.0),
                                    bottomRight: Radius.circular(12.0)),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 10, 0),
                                      child: Button(
                                        style: ButtonStyle(
                                            padding:
                                                ButtonState.all<EdgeInsets>(
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8))),
                                        child: const Text(
                                          "RESET",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        onPressed: () {
                                          setState(
                                            () {},
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 20, 0),
                                      child: Button(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                ButtonState.all(Colors.teal),
                                            padding:
                                                ButtonState.all<EdgeInsets>(
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8))),
                                        child: const Text(
                                          "SAVE",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                        onPressed: () {
                                          setState(
                                            () {},
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 210,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.8),
                      offset: const Offset(-6.0, -6.0),
                      blurRadius: 16.0,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(6.0, 6.0),
                      blurRadius: 16.0,
                    ),
                  ],
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text("Max Temp (exhaust) :"),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    TextInput(
                                        disabled: false,
                                        controller: TextEditingController()),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const Text("Min Temp (Reducer) :"),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    TextInput(
                                        disabled: false,
                                        controller: TextEditingController()),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const Text("Default Injector Value :"),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    TextInput(
                                        disabled: false,
                                        controller: TextEditingController()),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 60,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.8),
                  offset: const Offset(-6.0, -6.0),
                  blurRadius: 16.0,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(6.0, 6.0),
                  blurRadius: 16.0,
                ),
              ],
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ],
      ),
    );
  }
}
