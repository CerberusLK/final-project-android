import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/state_manager.dart';
import 'package:safeshopping/controllers/AuthController.dart';
import 'package:safeshopping/controllers/ProductController.dart';
import 'package:safeshopping/controllers/UserController.dart';
import 'package:safeshopping/pages/ProductPage.dart';
import 'package:safeshopping/pages/ShoppingCartPage.dart';
import 'package:safeshopping/pages/UserProfilePage.dart';

class SearchStore extends StatefulWidget {
  @override
  _SearchStoreState createState() => _SearchStoreState();
}

class _SearchStoreState extends State<SearchStore> {
  final UserController userController = Get.put(UserController());
  final AuthController authController = AuthController();
  final ProductController productController = Get.put(ProductController());

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int counter = 0;

    var itemCount = 0;
    (productController.products.length == null)
        ? itemCount = 0
        : itemCount = productController.products.length;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Safe Shopping"),
        actions: <Widget>[
          new Stack(
            children: <Widget>[
              new IconButton(
                  icon: const Icon(Icons.add_shopping_cart_rounded),
                  onPressed: () {
                    Get.to(() => ShoppingCartPage());
                    //ToDo: Link to Cart Page
                  }),
              counter != 0
                  ? new Positioned(
                      right: 11,
                      top: 11,
                      child: new Container(
                        padding: EdgeInsets.all(2),
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 14,
                          minHeight: 14,
                        ),
                        child: Text(
                          '$counter',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : new Container()
            ],
          )
        ],
      ),
      drawer: new Drawer(
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: AssetImage('assets/safe_shopping_logo.png'),
                  ),
                ),
              ),
            ),
            BottomAppBar(
              child: Row(
                children: [
                  FlatButton(
                    child: Text("Logout"),
                    onPressed: () {
                      authController.signOut();
                    },
                  ),
                ],
              ),
            ),
            //ToDo: Current items in shopping cart needs to added
            const Divider(
              height: 20,
              thickness: 5,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              style: TextStyle(
                fontSize: 12,
              ),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search_rounded),
                  onPressed: () {}, //ToDo: Product Search Method
                ),
                hintText: "Search Products",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlue),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlineButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  child: Text(
                    "Clear",
                    style: TextStyle(fontSize: 12),
                  ),
                  onPressed: () {
                    searchController.clear();
                  },
                )
              ],
            ),
          ),
          Container(), //Todo: return values are here
          Expanded(
            child: Obx(() => StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  itemCount: productController.products.length,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        print("Card Clicked" +
                            productController.products[index].productName);
                        Get.to(ProductPage(), arguments: [
                          productController.products[index].imgString,
                          productController.products[index].productName,
                          productController.products[index].brandName,
                          productController.products[index].price,
                          productController.products[index].measurement,
                          productController.products[index].productQuantity,
                          productController.products[index].storeId,
                          productController.products[index].productId
                        ]);
                      }, //Todo: Navigate to product page
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Material(
                          elevation: 5,
                          child: Container(
                            decoration: new BoxDecoration(
                                // color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8.0)),
                            // height: 200,
                            // width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Image.memory(Base64Codec().decode(
                                        productController
                                            .products[index].imgString)),
                                  ),
                                ),
                                Text(productController
                                    .products[index].productName),
                                Text(productController
                                    .products[index].productName),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(productController.products[index].price +
                                    " " +
                                    productController
                                        .products[index].measurement),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Rs. " +
                                            productController
                                                .products[index].price +
                                            ".00",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                )),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                iconSize: 30,
                icon: const Icon(Icons.shopping_basket_rounded),
                onPressed: () {}), //ToDo: To orders page
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/safe_shopping_logo.png'),
                ),
              ),
            ),
            IconButton(
                iconSize: 30,
                icon: const Icon(Icons.person),
                onPressed: () {
                  Get.to(Profile());
                }), //ToDo: To User profile page
          ],
        ),
      ),
    );
  }
}
