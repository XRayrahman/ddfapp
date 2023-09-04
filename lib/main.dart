import 'dart:io';
import 'package:ddfapp/home/home_page.dart';
import 'package:ddfapp/settings/settings_page.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // check for platform / operating system used
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowMinSize(const Size(1300, 830));
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    // Build base for the application based on Fluent UI Design System
    return FluentApp(
      theme: FluentThemeData(
        fontFamily: "Segoe-UI",
        accentColor: Colors.teal,
      ),
      title: 'ECU DDF',
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Dual-Diesel Fuel ECU'),
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
    // Main Navigation for the application with 2 pane (for now)
    // home-> for data manipulation and settings-> for parameter
    return NavigationView(
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
            body: const HomePage(),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text("Settings"),
            body: const SettingsPage(),
          ),
        ],
      ),
    );
  }
}
