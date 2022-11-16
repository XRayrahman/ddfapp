import 'dart:io';

import 'package:ddfapp/home/home_page.dart';
import 'package:ddfapp/settings/settings_page.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:window_size/window_size.dart';
// import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowMinSize(const Size(1300, 690));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      theme: ThemeData(fontFamily: "Segoe"),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'DDF'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      // appBar: NavigationAppBar(
      //   // title: Row(
      //   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   //   children: const [
      //   //     Text(
      //   //       "ECU DDF CONFIGURATION",
      //   //       style: TextStyle(
      //   //         fontSize: 24,
      //   //       ),
      //   //     ),
      //   //   ],
      //   // ),
      // ),
      pane: NavigationPane(
        selected: indexPage,
        size: const NavigationPaneSize(openMaxWidth: 50),
        onChanged: ((value) {
          setState(() {
            indexPage = value;
          });
        }),
        displayMode: PaneDisplayMode.top,
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.home),
            title: const Text("Home"),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text("Settings"),
          ),
        ],
      ),
      content: NavigationBody(
        index: indexPage,
        children: const [
          HomePage(),
          SettingsPage(),
        ],
      ),
    );
  }
}
