import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AddReportController extends GetxController {
  final _instance = FirebaseFirestore.instance;
  final isLoading = false.obs;
  var storage = GetStorage();

  Future<void> addReport(String spot, String reason, String date,
      String fromTime, String toTime) async {
    isLoading(true);
    var name = storage.read('name');
    var id = storage.read('id');
    Map<String, dynamic> data;
    try {
      data = {
        "name": name,
        "id": id,
        "spot": spot,
        "reason": reason,
        "date": date,
        "fromTime": fromTime,
        "toTime": toTime,
        "timeStamp": Timestamp.now(),
      };
      _instance
          .collection('reports')
          .add(data)
          .then((value) => {Get.back(), isLoading(false)});
    } catch (e) {
      debugPrint("$e");
      isLoading(false);
      Get.snackbar('Something Wrong!', "$e",
          duration: const Duration(seconds: 1),
          snackPosition: SnackPosition.TOP);
    }
  }
}
