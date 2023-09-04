import 'dart:ffi';
import 'dart:typed_data';
import 'dart:io' show Directory;
import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as path;
import 'api.dart';

/// This Dart code sends data using a custom serial communication library.
void main() {
  final libPath = path.join(Directory.current.path, 'sern.dll');
  final customSerialCommunication = CustomSerialCommunication(libPath);

  const port = 0; // Use the desired port
  const baudRate = 9600; // Use the desired baud rate
  const command = 1;
  const index = 10;
  const data = [
    1000,
    2000,
    3000,
    4000,
    5000,
    6000,
    1200,
    8000,
    50000,
    2515,
  ]; // Use your data bytes here

  final result =
      customSerialCommunication.sendData(port, baudRate, command, index, data);

  if (result == 0) {
    print('Data sent successfully.');
  } else {
    print('Failed to sending data.');
  }
}
