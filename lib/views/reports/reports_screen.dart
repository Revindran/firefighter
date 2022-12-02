import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firefighter/components/custom_appbar.dart';
import 'package:firefighter/views/add_report/add_report_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/Constants.dart';

final _fireStoreInstance = FirebaseFirestore.instance;
var storage = GetStorage();

class Reports extends StatelessWidget {
  Reports({Key? key}) : super(key: key);
  final uType = storage.read('uType');
  final uName = storage.read('name');

  @override
  Widget build(BuildContext context) {
    final c = Get.put(AddReportController());
    return Scaffold(
      appBar: const CustomAppBar(
        plusButtonHide: true,
        backShow: true,
        title: "Reports",
        height: 110,
      ),
      body: Column(
        children: [
          vHeight20(),
          StreamBuilder<QuerySnapshot>(
              stream: _fireStoreInstance
                  .collection('reports')
                  .orderBy("timeStamp", descending: true)
                  .snapshots(),
              builder: (context, querySnapshot) {
                if (querySnapshot.hasError) {
                  return const Center(child: Text('Has Error'));
                }
                if (querySnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(color: accentColor));
                }
                if (querySnapshot.data == null) {
                  return const Center(child: Text('Empty Data'));
                }
                if (querySnapshot.data!.size == 0) {
                  return const Center(child: Text('No Data'));
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    shrinkWrap: true,
                    itemCount: querySnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot ds =
                          querySnapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey)),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Name: ${ds.get('name')}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          "Date: ${ds.get('date')}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          "Spot: ${ds.get("spot")}",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "From time: ${ds.get('fromTime')}",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "To time: ${ds.get('toTime')}",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "Reason: ${ds.get('reason')}",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Obx(
                                      () => c.isLoading.value
                                          ? const CircularProgressIndicator(
                                              color: Colors.redAccent)
                                          : uType == 'admin'
                                              ? IconButton(
                                                  onPressed: () =>
                                                      c.deleteReport(ds.id),
                                                  icon: const Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.redAccent))
                                              : uName == ds.get('name')
                                                  ? IconButton(
                                                      onPressed: () =>
                                                          c.deleteReport(ds.id),
                                                      icon: const Icon(
                                                          Icons.delete_outline,
                                                          color:
                                                              Colors.redAccent))
                                                  : Container(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            vHeight10(),
                          ],
                        ),
                      );
                    },
                  );
                }
              }),
        ],
      ),
    );
  }
}
