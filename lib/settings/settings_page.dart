import 'package:fluent_ui/fluent_ui.dart';

import '../text_input.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              "MAP SETTINGS",
              style: TextStyle(fontSize: 24),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 180,
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
                                const Text("Set default TPS value to :"),
                                const SizedBox(
                                  width: 5,
                                ),
                                TextInput(
                                    enabled: false,
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
                                const Text("Set default RPM value to :"),
                                const SizedBox(
                                  width: 5,
                                ),
                                TextInput(
                                    enabled: false,
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
                                const Text("Set default Injector value to :"),
                                const SizedBox(
                                  width: 5,
                                ),
                                TextInput(
                                    enabled: false,
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
