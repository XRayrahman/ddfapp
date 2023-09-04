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
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 210,
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
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Row(
                    children: [
                      Container(
                        width: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "TEMPERATURE",
                                  style: TextStyle(fontSize: 24),
                                ),
                                Icon(
                                  FluentIcons.remove_filter,
                                  size: 24,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Max. Temp (exhaust) :"),
                                const SizedBox(
                                  width: 5,
                                ),
                                Row(
                                  children: [
                                    TextInput(
                                        disabled: false,
                                        controller: TextEditingController()),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Button(
                                      child: const Text("OK"),
                                      onPressed: () {
                                        setState(
                                          () {},
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Min Temp (Reducer) :"),
                                const SizedBox(
                                  width: 5,
                                ),
                                Row(
                                  children: [
                                    TextInput(
                                        disabled: false,
                                        controller: TextEditingController()),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Button(
                                      child: const Text("OK"),
                                      onPressed: () {
                                        setState(
                                          () {},
                                        );
                                      },
                                    ),
                                  ],
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
                                Button(
                                  child: const Text("OK"),
                                  onPressed: () {
                                    setState(
                                      () {},
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
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
                                    Button(
                                      child: const Text("OK"),
                                      onPressed: () {
                                        setState(
                                          () {},
                                        );
                                      },
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
                                    Button(
                                      child: const Text("OK"),
                                      onPressed: () {
                                        setState(
                                          () {},
                                        );
                                      },
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
                                    Button(
                                      child: const Text("OK"),
                                      onPressed: () {
                                        setState(
                                          () {},
                                        );
                                      },
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
