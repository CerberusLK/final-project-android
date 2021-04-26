import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/state_manager.dart';
import 'package:safeshopping/controllers/AuthController.dart';
import 'package:safeshopping/controllers/UserController.dart';
import 'package:safeshopping/controllers/productController.dart';

class SearchStore extends StatefulWidget {
  @override
  _SearchStoreState createState() => _SearchStoreState();
}

class _SearchStoreState extends State<SearchStore> {
  final UserController userController = Get.put(UserController());
  final AuthController authController = AuthController();
  final StoreController storeController = Get.put(StoreController());

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int counter = 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Safe Shopping"),
        actions: <Widget>[
          new Stack(
            children: <Widget>[
              new IconButton(
                  icon: const Icon(Icons.add_shopping_cart_rounded),
                  onPressed: () {
                    //ToDo: Link to Cart Page
                    setState(() {
                      counter = 2;
                    });
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
          Expanded(
            child: Obx(
              () => StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  itemCount: storeController.productList.length,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 200,
                      width: 100,
                      color: Colors.lightBlueAccent,
                    );
                  },
                  staggeredTileBuilder: (index) => StaggeredTile.fit(1)),
            ),
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
                onPressed: () {}), //ToDo: To User profile page
          ],
        ),
      ),
    );
  }
}
