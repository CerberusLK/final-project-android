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
      debugShowCheckedModeBanner: false,
      initialBinding: AuthBinding(),
      home: Root(),
      theme: ThemeData.light(),
    );
  }
}

//TODO: delete completed corders on checkout
//TODO: implement the product search
//TODO: implement the local notification when order status changed to complete
//TODO: add a rating system


//TODO: add a cusstomer order details