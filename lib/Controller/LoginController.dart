
import 'package:get/get.dart';

import '../API/ApiService.dart';


class LoginController extends GetxController {
  var isLoading = false.obs;
  var loginStatus = "".obs;
  var token = "".obs;

  final ApiService _loginService = ApiService();

  Future<void> login(String username, String password) async {
    isLoading.value = true;
    try {
      final response = await _loginService.login(username, password);
      if (response["status"] == true) {
        loginStatus.value = response["message"];
        token.value = response["token"];
      } else {
        loginStatus.value = "Login failed";
      }
    } catch (e) {
      loginStatus.value = "Error: ${e.toString()}";
    } finally {
      isLoading.value = false;
    }
  }
}
