import 'package:get/get.dart';
import 'package:safeshopping/models/User.dart';

class UserController extends GetxController {
  Rx<UserModel> _userModel = UserModel().obs;

  set user(UserModel value) => this._userModel.value = value;

  UserModel get user => _userModel.value;

  void clear() {
    _userModel.value = UserModel();
  }
}
