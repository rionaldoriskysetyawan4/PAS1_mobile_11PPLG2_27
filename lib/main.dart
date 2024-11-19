import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Binding/MyBinding.dart';
import 'menu/CharacterPage/CharacterPage.dart';
import 'menu/DashboardPage.dart';
import 'menu/LoginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => LoginPage(),
          binding: MyBindings(),
        ),
        GetPage(
          name: '/Dashboard',
          page: () => DashboardPage(),
          binding: MyBindings(),
        ),
        GetPage(
          name: '/character',
          page: () => Characterpage(
              image: '',
              title: '',
              description: ''
          ),
        ),
      ],
    );
  }
}
