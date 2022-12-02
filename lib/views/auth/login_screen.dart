import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import 'auth_controller.dart';

final controller = Get.put(AuthController());

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  image: DecorationImage(
                      image: AssetImage("assets/logo.jpg"), fit: BoxFit.cover)),
              height: Get.height / 2,
              width: double.infinity,
            ),
            vHeight20(),
            const Text(
              "Welcome to LD14",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            vHeight10(),
            Obx(
              () => Text(
                controller.signUP.value ? "Signup" : "Login to continue",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            vHeight20(),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter I'd",
                ),
              ),
            ),
            vHeight10(),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Obx(
                () => TextField(
                  controller: _passwordController,
                  obscureText: controller.showPassword.value,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.showPassword.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: () => controller.showPasswordToggle(),
                    ),
                    hintText: 'Enter password',
                  ),
                ),
              ),
            ),
            vHeight10(),
            Obx(() => controller.isLoading.value
                ? CircularProgressIndicator(color: accentColor)
                : SizedBox(
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(16.0)))),
                        onPressed: () {
                          if (_emailController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty) {
                            controller.isLoadingToggle();
                            controller.userSignIn(_emailController.text,
                                _passwordController.text);
                          } else {
                            Get.snackbar(
                                "Error", "Fill all the fields to continue!",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.redAccent,
                                colorText: Colors.white);
                          }
                        },
                        child: const Text('Login',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  )),
            vHeight20(),
            vHeight20(),
            vHeight20(),
          ],
        ),
      ),
    );
  }
}
