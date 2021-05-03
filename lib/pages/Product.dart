import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  var args = Get.arguments;
  var counter = 1.obs;

  void increment() {
    if (counter >= 20) {
      Get.snackbar(
          "Message", "You might need to contact the seller for the order");
    } else
      counter.update((val) {
        counter++;
      });
  }

  void decrement() {
    if (counter > 1) {
      counter.update((val) {
        counter--;
      });
    } else {
      Get.snackbar("Message", "Quantity cannot be less than 1 item");
    }
  }

  @override
  Widget build(BuildContext context) {
    String imgString = args[0];
    String productName = args[1];
    String brandName = args[2];
    String price = args[3];
    String measurement = args[4];
    String quantity = args[5];
    String storeId = args[6];

    return Scaffold(
      appBar: AppBar(
        title: Text("Product Description"),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.memory(Base64Codec().decode(imgString)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            productName,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 2, 0, 8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            brandName,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 2, 0, 2),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Rs. " + price + ".00",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 0, 0, 8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "per " + quantity + " " + measurement,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                decrement();
                              }),
                          SizedBox(
                            width: 12,
                          ),
                          Obx(() => Text(counter.toString())),
                          SizedBox(
                            width: 12,
                          ),
                          IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                increment();
                              }),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20)),
                            onPressed: () {}, //Todo: Add item to cart
                            child: Row(
                              children: [
                                Text("Add to Cart"),
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(Icons.add_shopping_cart_rounded),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
