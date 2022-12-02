import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../home/home_screen.dart';

class AuthController extends GetxController {
  final _instance = FirebaseFirestore.instance;
  final isLoading = false.obs;
  final showPassword = true.obs;
  final signUP = false.obs;
  var storage = GetStorage();

  showPasswordToggle() => showPassword.value = !showPassword.value;

  signUPToggle() => signUP.value = !signUP.value;

  isLoadingToggle() => isLoading.value = !isLoading.value;

  Future<void> userSignIn(String id, String pass) async {
    try {
      _instance.collection('users').doc(id).get().then((value) {
        if (value.exists) {
          var password = value['password'];
          if (kDebugMode) {
            print("password $password");
          }
          if (pass == password) {
            var name = value['name'];
            var id = value['id'];
            var uType = value['uType'];
            storage.write('name', name);
            storage.write('id', id);
            storage.write('uType', uType);
            isLoadingToggle();
            Get.offAll(() => HomeScreen(uType: uType));
          } else {
            isLoadingToggle();
            Get.snackbar('Error', 'Wrong Password',
                duration: const Duration(seconds: 1),
                snackPosition: SnackPosition.BOTTOM);
          }
        } else {
          isLoadingToggle();
          Get.snackbar('Error', "User Not Found",
              duration: const Duration(seconds: 1),
              snackPosition: SnackPosition.BOTTOM);
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      isLoadingToggle();
      Get.snackbar('Error', "User Not Found",
          duration: const Duration(seconds: 1),
          snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> userSignUp(String name, String id, String pass) async {
    isLoading(true);
    Map<String, dynamic> data;
    try {
      data = {
        "name": name,
        "id": id,
        "password": pass,
        "uType": "user",
        "timeStamp": Timestamp.now(),
      };
      _instance.collection('users').doc(id).set(data).then((value) => {
            isLoading(false),
            Get.back(),
          });
    } catch (e) {
      debugPrint("$e");
      isLoading(false);
      Get.snackbar('Something Wrong!', "$e",
          duration: const Duration(seconds: 1),
          snackPosition: SnackPosition.TOP);
    }
  }
}
