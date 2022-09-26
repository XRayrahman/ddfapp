// import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(
          label: Text("test"),
        ),
      ],
      rows: [
        DataRow.byIndex(
          index: 2,
          cells: const [
            DataCell(
              Text("cell 1"),
            ),
            DataCell(
              Text("cell 2"),
            ),
          ],
        ),
        DataRow.byIndex(
          index: 0,
          cells: const [
            DataCell(
              Text("test 1"),
            ),
            DataCell(
              Text("test 2"),
            ),
          ],
        ),
      ],
    );
  }
}
