import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../Controller/LoginController.dart';
import '../reuse/MyText.dart';
import '../reuse/MyTextField.dart';



class LoginPage extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Color(0xFF8E8E8E),
        title: Row(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors
                    .transparent,
                shadowColor: Colors.transparent,
              ),
              onPressed: () {
                exit(0);
              },
              child: Text("Keluar"),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 100,),
            Center(
                child: MyText(
                  hintText: 'La League',
                  fontSize: 18,
                  colors: Colors.grey[700]!,
                  fontFamily: 'NunitoSans',
                  textAlign: TextAlign.center,
                )),
            SizedBox(height: 10),
            Mytextfield(
              hintText: 'Username',
              radius: 0.5,
              width: 300,
              height: 100,
              controller: usernameController,
            ),

            Mytextfield(
              hintText: 'Password',
              radius: 0.8,
              width: 300,
              height: 100,
              controller: passwordController,
            ),
            SizedBox(height: 16),
            Obx(() => ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(Colors.blueAccent),
                padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              onPressed: controller.isLoading.value
                  ? null
                  : () async {
                if (usernameController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: MyText(
                        hintText: "Nama dan password harus diisi!",
                        fontSize: 16,
                        colors: Colors.white,
                      ),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                } else {await controller.login(usernameController.text,
                    passwordController.text);
                if (controller.loginStatus.value ==
                    "Login success") {
                  Get.toNamed('/Dashboard');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: MyText(
                        hintText: controller.loginStatus.value,
                        fontSize: 16,
                        colors: Colors.white,
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
                }
              },
              child: controller.isLoading.value
                  ? CircularProgressIndicator(
                color: Colors.white,
              )
                  : MyText(
                hintText: "Login",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                colors: Colors.white,
              ),
            )),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
