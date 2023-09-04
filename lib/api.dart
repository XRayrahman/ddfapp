import 'dart:ffi';
import 'dart:convert';
import 'dart:io' show Directory;
import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as path;

typedef SendDataFunc = Int32 Function(
    Int32, Uint32, Uint8, Uint8, Pointer<Uint16>, Uint8);
typedef SendData = int Function(int, int, int, int, Pointer<Uint16>, int);

typedef StringFunc = Pointer<Utf8> Function(Pointer<Utf8>);
typedef StringFuncDart = Pointer<Utf8> Function(Pointer<Utf8>);

base class SerialCommunication extends Struct {
  @Uint8()
  external int port;

  @Uint8()
  external int baudRate;
}

base class SerialData extends Struct {
  @Uint8()
  external int command;

  @Uint8()
  external int index;

  external Pointer<Uint8> data;

  @Uint32()
  external int dataLength;
}

/// The CustomSerialCommunication class is used for serial communication.
class CustomSerialCommunication {
  final DynamicLibrary _dylib;

  CustomSerialCommunication(String libraryName)
      : _dylib = DynamicLibrary.open(libraryName);

  int sendData(
    int port,
    int baudRate,
    int command,
    int index,
    List<int> data,
  ) {
    // final pointerFunc =
    //     _dylib.lookupFunction<StringFunc, StringFuncDart>('test');

    final sendDataFunc =
        _dylib.lookupFunction<SendDataFunc, SendData>('send_data');

    final dataPtr = calloc<Uint16>(data.length);
    for (var i = 0; i < data.length; i++) {
      dataPtr[i] = data[i];
    }

    final result =
        sendDataFunc(port, baudRate, command, index, dataPtr, data.length);

    calloc.free(dataPtr);
    return result;
    // final test = pointerFunc("test".toNativeUtf8());
    // final testDart = test.toDartString();
    // print("isi :" + testDart);
  }

  // Pointer<SerialData> readSerialData(Pointer<SerialCommunication> serial) {
  //   final readFn = _dylib
  //       .lookupFunction<_ReadSerialData, _ReadSerialDataDart>("read_data");
  //   return readFn(serial);
  // }
}
