import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:safeshopping/controllers/AuthController.dart';
import 'package:safeshopping/controllers/ShoppingCartController.dart';
import 'package:safeshopping/models/Product.dart';
import 'package:safeshopping/services/FirestoreServices.dart';

class ShoppingCartPage extends GetWidget<ShoppingCartController> {
  ShoppingCartController shoppingCartController =
      Get.put(ShoppingCartController());
  AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    int total = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => StaggeredGridView.countBuilder(
                crossAxisCount: 1,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                itemCount: shoppingCartController.shoppingList.length,
                itemBuilder: (context, index) {
                  return FutureBuilder<ProductModel>(
                      future: FirestoreServices().getProduct(
                          shoppingCartController.shoppingList[index].productId),
                      builder: (context, productModel) {
                        if (productModel.hasData) {
                          int _total = int.parse(shoppingCartController
                                  .shoppingList[index].price) *
                              int.parse(shoppingCartController
                                  .shoppingList[index].quantity);
                          total = total + _total;
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                            child: Card(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 130,
                                    width: 130,
                                    child: Image.memory(Base64Codec()
                                        .decode(productModel.data.imgString)),
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 4, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  productModel.data.productName,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                Text(productModel
                                                    .data.brandName),
                                                Text(
                                                  "Item Price: " +
                                                      "Rs." +
                                                      productModel.data.price +
                                                      ".00",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // Text(
                                        //   "Total : " +
                                        //       "Rs." +
                                        //       total.toString() +
                                        //       ".00",
                                        //   style: TextStyle(
                                        //       fontWeight: FontWeight.bold),
                                        // ),
                                        Row(
                                          children: [
                                            IconButton(
                                                icon: Icon(Icons.remove),
                                                onPressed: () {
                                                  FirestoreServices()
                                                      .decrementQuantity(
                                                          _authController
                                                              .user.uid,
                                                          shoppingCartController
                                                              .shoppingList[
                                                                  index]
                                                              .productId);
                                                }),
                                            Text(
                                              shoppingCartController
                                                  .shoppingList[index].quantity,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            IconButton(
                                                icon: Icon(Icons.add),
                                                onPressed: () {
                                                  FirestoreServices()
                                                      .incrementQuantity(
                                                          _authController
                                                              .user.uid,
                                                          shoppingCartController
                                                              .shoppingList[
                                                                  index]
                                                              .productId);
                                                }),
                                          ],
                                        ),
                                        IconButton(
                                            color: Colors.red,
                                            icon: Icon(Icons.delete),
                                            onPressed: () {
                                              FirestoreServices()
                                                  .deleteItemFromShoppingCart(
                                                      _authController.user.uid,
                                                      shoppingCartController
                                                          .shoppingList[index]
                                                          .productId);
                                            }), //Todo: Delete item
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Text("Loading...");
                        }
                      });
                },
                staggeredTileBuilder: (index) => StaggeredTile.fit(1))),
          ),
          BottomAppBar(
            child: Row(
              children: [
                Text(total.toString()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
