import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:safeshopping/models/User.dart';
import 'package:safeshopping/services/FirestoreServices.dart';

import 'UserController.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<FirebaseUser> _firebaseUser = Rx<FirebaseUser>();

  FirebaseUser get user => _firebaseUser.value;

  void onInit() {
    _firebaseUser.bindStream(_auth.onAuthStateChanged);
  }

  void createUser(String email, String password, String name) async {
    try {
      AuthResult _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      //create a user document in firestore
      UserModel _user =
          UserModel(id: _authResult.user.uid, name: name, email: email);
      if (await FirestoreServices().createNewUser(_user)) {
        Get.find<UserController>().user = _user;
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        "Error in Sign up",
        e.message,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void login(String email, String password) async {
    try {
      AuthResult _authResut = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Get.find<UserController>().user =
          await FirestoreServices().getUser(_authResut.user.uid);
    } catch (e) {
      print(e);
      Get.snackbar(
        "Error in sign in",
        e.toString(),
        snackPosition: SnackPosition.TOP,
        snackStyle: SnackStyle.FLOATING,
      );
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
      Get.find<UserController>().clear();
    } catch (e) {
      print(e);
      Get.snackbar(
        "Error in sign out",
        e.message,
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
