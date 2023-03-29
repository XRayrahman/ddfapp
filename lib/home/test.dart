import 'dart:typed_data';

void main() {
  Uint16List uint16List =
      Uint16List.fromList(
          [1, 2, 300, 4, 5]);
  Uint8List uint8List =
      Uint8List(uint16List.length);

  for (int i = 0;
      i < uint16List.length;
      i++) {
    uint8List[i] =
        uint16List[i].toUnsigned(8);
  }

  print(
      'Original Uint16List: $uint16List');
  print(
      'Converted Uint8List: $uint8List');
}
