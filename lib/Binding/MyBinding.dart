import 'package:get/get.dart';

import '../Controller/LoginController.dart';

class MyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() =>LoginController());

  }
}