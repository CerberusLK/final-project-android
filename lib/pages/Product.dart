import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  var args = Get.arguments;

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
                padding: const EdgeInsets.fromLTRB(8, 2, 0, 8),
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
                padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 2, 0, 8),
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
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
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
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20)),
                      onPressed: () {},
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
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
