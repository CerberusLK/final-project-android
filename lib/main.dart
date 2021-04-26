import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeshopping/controllers/bindings/AuthBindings.dart';
import 'package:safeshopping/utils/Root.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AuthBinding(),
      home: Root(),
    );
  }
}
