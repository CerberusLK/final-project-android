import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Scanner {
  Future<String> scanQrCode() async {
    try {
      String qrCode = await FlutterBarcodeScanner.scanBarcode(
          "#1e88e5", "Cancel", true, ScanMode.QR);
      print("Bar code Text:" + qrCode);
      return qrCode;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
