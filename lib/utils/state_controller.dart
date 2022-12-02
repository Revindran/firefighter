import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StateController extends GetxController {
  final isLoading = false.obs;
  final showPassword = false.obs;

  final List<String> list = ["Season", "Month"];
  String select = "";

  final dummyList = ['Select', 'B', 'C', 'D'];
  final dummyListA = ['Select', 'F', 'G', 'H'];
  String selected = 'Select';
  String selectedA = 'Select';

  final dummyItems = ['Select Item', 'Apple', 'Orange', 'Mango'];
  final dummyUnits = ['Select Unit', 'Bag', 'Big Bag', 'Basket'];
  String selectedItem = 'Select Item';
  String selectedUnit = 'Select Unit';

  RxString selectedFromTime = 'Select From Time'.obs;
  RxString selectedToTime = 'Select To Time'.obs;

  showPasswordToggle() => showPassword.value = !showPassword.value;

  isLoadingToggle() => isLoading.value = !isLoading.value;

  void toggleRadioValue(value) {
    select = value;
    update();
  }

  void toggleDropDownValue(value) {
    selected = value;
    update();
  }

  void toggleDropDownValueA(value) {
    selectedA = value;
    update();
  }

  void toggleItemDownValue(value) {
    selectedItem = value;
    update();
  }

  void toggleUnitDownValue(value) {
    selectedUnit = value;
    update();
  }

  var selectedFromDate = DateTime.now().obs;
  var selectedToDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.now().obs;

  @override
  void onInit() {
    super.onInit();
    selectedFromDate = DateTime.now().obs;
    selectedToDate = DateTime.now().obs;
    selectedTime = TimeOfDay.now().obs;
  }

  chooseDate(selectedDate) async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2024),
      //initialEntryMode: DatePickerEntryMode.input,
      // initialDatePickerMode: DatePickerMode.year,
      helpText: 'Select',
      cancelText: 'Close',
      confirmText: 'Confirm',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter valid date range',
      fieldLabelText: 'Date',
      fieldHintText: 'Month/Date/Year',
      // selectableDayPredicate: disableDate,
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }

  chooseTime(selectedTime) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: Get.context!, //context of current state
    );

    if (pickedTime != null) {
      debugPrint(pickedTime.format(Get.context!)); //output 10:51 PM
      DateTime parsedTime =
          DateFormat.jm().parse(pickedTime.format(Get.context!).toString());
      //converting to DateTime so that we can further format on different pattern.
      debugPrint("$parsedTime"); //output 1970-01-01 22:53:00.000
      String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
      debugPrint(formattedTime);
      selectedTime.value = formattedTime;

      //output 14:59:00
      //DateFormat() is from intl package, you can format the time on any pattern you need.
    } else {
      selectedTime.value = "Time is not selected";
      debugPrint("Time is not selected");
    }
  }

  bool disableDate(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(const Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(const Duration(days: 5))))) {
      return true;
    }
    return false;
  }
}
