import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:safeshopping/controllers/AuthController.dart';
import 'package:safeshopping/controllers/CompletedOrderController.dart';
import 'package:safeshopping/models/Product.dart';
import 'package:safeshopping/services/FirestoreServices.dart';

class CompletedOrderPage extends StatefulWidget {
  @override
  _CompletedOrderPageState createState() => _CompletedOrderPageState();
}

class _CompletedOrderPageState extends State<CompletedOrderPage> {
  final CompletedOrderController orders = Get.put(CompletedOrderController());
  final AuthController _auth = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Completed Orders"),
        centerTitle: true,
        elevation: 20,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: Obx(() => StaggeredGridView.countBuilder(
                crossAxisCount: 1,
                itemCount: orders.orderList.length,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                itemBuilder: (context, index) {
                  return FutureBuilder<ProductModel>(
                      future: FirestoreServices()
                          .getProduct(orders.orderList[index].productId),
                      builder: (context, productModel) {
                        if (productModel.hasData) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: Card(
                              elevation: 15,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "Order Time:",
                                              style: TextStyle(
                                                  color: Colors.blueGrey[300]),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(orders.orderList[index]
                                                    .dateCreated
                                                    .toDate()
                                                    .toLocal()
                                                    .year
                                                    .toString() +
                                                "." +
                                                orders.orderList[index]
                                                    .dateCreated
                                                    .toDate()
                                                    .toLocal()
                                                    .month
                                                    .toString() +
                                                "." +
                                                orders.orderList[index]
                                                    .dateCreated
                                                    .toDate()
                                                    .toLocal()
                                                    .day
                                                    .toString()),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            IconButton(
                                                color: Colors.red,
                                                icon: Icon(Icons.delete),
                                                onPressed: () {
                                                  FirestoreServices()
                                                      .deleteCompletedOrder(
                                                          _auth.user.uid,
                                                          orders
                                                              .orderList[index]
                                                              .orderId);
                                                })
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "Order Status:",
                                              style: TextStyle(
                                                  color: Colors.blueGrey[300]),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                                orders.orderList[index].status),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              height: 130,
                                              width: 130,
                                              child: Image.memory(Base64Codec()
                                                  .decode(productModel
                                                      .data.imgString)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              productModel.data.productName,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              productModel.data.brandName,
                                              style: TextStyle(
                                                  color: Colors.blueGrey[300]),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text("Rs." +
                                                orders
                                                    .orderList[index].unitPrice
                                                    .toString() +
                                                ".00" +
                                                "  " +
                                                "X" +
                                                "  " +
                                                orders.orderList[index].qty
                                                    .toString()),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Total amount:"),
                                        Text(
                                          "Rs." +
                                              (orders.orderList[index]
                                                          .unitPrice *
                                                      orders
                                                          .orderList[index].qty)
                                                  .toString() +
                                              ".00",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Text("Loading");
                        }
                      });
                },
                staggeredTileBuilder: (index) => StaggeredTile.fit(1))),
          )
        ],
      ),
    );
  }
}
