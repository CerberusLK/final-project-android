import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeshopping/controllers/AuthController.dart';
import 'package:safeshopping/controllers/UserController.dart';

void main() {
  runApp(GetMaterialApp(
    home: Profile(),
    theme: ThemeData(fontFamily: 'Poppins'),
  ));
}

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPassController = TextEditingController();
    final TextEditingController currentPassController = TextEditingController();

    UserController _userController = Get.put(UserController());
    AuthController _authController = Get.put(AuthController());

    bool enabled = true;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Profile"),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit_rounded),
              onPressed:
                  () {}, //Todo: Enable or disable the editable of text fields
            )
          ],
        ),
        body: ListView(children: <Widget>[
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  "Order Details",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Icon(Icons.done),
                              Text("Completed"),
                              SizedBox(
                                height: 10,
                              ),
                              Text("2"),
                            ],
                          ),
                        ),
                        VerticalDivider(),
                        Container(
                          child: Column(
                            children: [
                              Icon(Icons.local_shipping_outlined),
                              Text("To be Collected"),
                              SizedBox(
                                height: 10,
                              ),
                              Text("2"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Profile Details",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Obx(() {
                      if (_userController.user.name != null) {
                        nameController.text = _userController.user.name;
                        enabled = true;
                      } else {
                        nameController.text = "Loading...";
                        enabled = false;
                      }
                      return TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.account_box_outlined),
                          hintText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(() {
                      bool enabled;
                      if (_userController.user.email != null) {
                        emailController.text = _userController.user.email;
                        enabled = true;
                      } else {
                        emailController.text = "Loading...";
                        enabled = false;
                      }
                      return TextField(
                        enabled: enabled,
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email_outlined),
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 150,
                            child: RaisedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        scrollable: true,
                                        title: Text("Update Password"),
                                        content: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Form(
                                            child: Column(
                                              children: <Widget>[
                                                TextFormField(
                                                  controller:
                                                      currentPassController,
                                                  decoration: InputDecoration(
                                                      labelText:
                                                          "Current Password",
                                                      prefixIcon: const Icon(
                                                          Icons.vpn_key)),
                                                ),
                                                TextFormField(
                                                  controller:
                                                      passwordController,
                                                  decoration: InputDecoration(
                                                      labelText: "New Password",
                                                      prefixIcon: const Icon(
                                                          Icons.vpn_key)),
                                                ),
                                                TextFormField(
                                                  controller:
                                                      confirmPassController,
                                                  decoration: InputDecoration(
                                                      labelText:
                                                          "Confirm Password",
                                                      prefixIcon: const Icon(
                                                          Icons.vpn_key)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          RaisedButton(
                                            child: Text("Update Password"),
                                            onPressed: () {
                                              if (passwordController.text ==
                                                  confirmPassController.text) {
                                                _authController
                                                    .changeUserPassword(
                                                        passwordController
                                                            .text);
                                                Navigator.of(context).pop();
                                              } else {
                                                Get.snackbar("Message",
                                                    "Passwords don't match");
                                                passwordController.text = "";
                                                confirmPassController.text = "";
                                              }
                                            }, //Todo: Update Password method
                                          )
                                        ],
                                      );
                                    });
                              },
                              child: Text("Change Password"),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            child: RaisedButton(
                              onPressed: () {}, //ToDo: Update Profile method
                              child: Text("Updaet Profile"),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ]));
  }
}
