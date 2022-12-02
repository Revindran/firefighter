import 'package:firefighter/components/custom_appbar.dart';
import 'package:firefighter/views/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';

class AddFighter extends StatelessWidget {
  AddFighter({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final idController = TextEditingController();
  final passwordController = TextEditingController();
  final c = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        plusButtonHide: true,
        backShow: true,
        title: "Add a Fighter",
        height: 110,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            vHeight20(),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Name",
                ),
              ),
            ),
            vHeight10(),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: TextField(
                controller: idController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Id",
                ),
              ),
            ),
            vHeight10(),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Password",
                ),
              ),
            ),
            vHeight10(),
            Obx(
              () => c.isLoading.value
                  ? const CircularProgressIndicator(color: Colors.white)
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
                            if (nameController.text.isNotEmpty &&
                                idController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty) {
                              c.userSignUp(nameController.text,
                                  idController.text, passwordController.text);
                              nameController.text = "";
                              idController.text = "";
                              passwordController.text = "";
                            } else {
                              Get.snackbar(
                                  "Error", "Fill all the fields to continue!",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.redAccent,
                                  colorText: Colors.white);
                            }
                          },
                          child: const Text('Add',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
