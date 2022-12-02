import 'package:firefighter/components/custom_appbar.dart';
import 'package:firefighter/utils/constants.dart';
import 'package:firefighter/views/add_report/add_report_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/state_controller.dart';

class AddReport extends StatelessWidget {
  AddReport({Key? key}) : super(key: key);
  final fromTController = TextEditingController();
  final toTController = TextEditingController();
  final spotController = TextEditingController();
  final reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StateController());
    final c = Get.put(AddReportController());
    return Scaffold(
      appBar: const CustomAppBar(
          plusButtonHide: true,
          backShow: true,
          title: "Add a report",
          height: 110),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            vHeight20(),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Obx(
                    () => InkWell(
                      onTap: () =>
                          controller.chooseDate(controller.selectedFromDate),
                      child: Text(
                          "Date - ${humanReadableDate(controller.selectedFromDate.value)}"),
                    ),
                  ),
                ),
              ),
            ),
            // vHeight10(),
            // Padding(
            //   padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            //   child: Container(
            //     width: Get.width,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10),
            //         border: Border.all(
            //           color: Colors.grey,
            //           width: 1,
            //         )),
            //     child: Padding(
            //       padding: const EdgeInsets.all(18.0),
            //       child: Obx(
            //         () => InkWell(
            //           onTap: () =>
            //               controller.chooseTime(controller.selectedFromTime),
            //           child: Text(
            //               "From time - ${controller.selectedFromTime.value}"),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // vHeight10(),
            // Padding(
            //   padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            //   child: Container(
            //     width: Get.width,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10),
            //         border: Border.all(
            //           color: Colors.grey,
            //           width: 1,
            //         )),
            //     child: Padding(
            //       padding: const EdgeInsets.all(18.0),
            //       child: Obx(
            //         () => InkWell(
            //           onTap: () =>
            //               controller.chooseTime(controller.selectedToTime),
            //           child:
            //               Text("To time - ${controller.selectedToTime.value}"),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            vHeight10(),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: TextField(
                controller: fromTController,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "From time",
                ),
              ),
            ),
            vHeight10(),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: TextField(
                maxLines: 5,
                minLines: 1,
                controller: toTController,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "To time",
                ),
              ),
            ),
            vHeight10(),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: TextField(
                controller: spotController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Specify Spot",
                ),
              ),
            ),
            vHeight10(),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: TextField(
                maxLines: 5,
                minLines: 1,
                controller: reasonController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Reason",
                ),
              ),
            ),
            vHeight20(),
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
                            if (fromTController.text.isNotEmpty &&
                                toTController.text.isNotEmpty &&
                                spotController.text.isNotEmpty &&
                                reasonController.text.isNotEmpty) {
                              c.addReport(
                                  spotController.text,
                                  reasonController.text,
                                  humanReadableDate(
                                      controller.selectedFromDate.value),
                                  fromTController.text,
                                  toTController.text);
                              spotController.text = "";
                              reasonController.text = "";
                              fromTController.text = "";
                              toTController.text = "";
                            } else {
                              Get.snackbar(
                                  "Error", "Fill all the fields to continue!",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.redAccent,
                                  colorText: Colors.white);
                            }
                          },
                          child: const Text('Submit',
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
