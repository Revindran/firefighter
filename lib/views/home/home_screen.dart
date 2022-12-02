import 'package:firefighter/components/custom_appbar.dart';
import 'package:firefighter/utils/constants.dart';
import 'package:firefighter/views/add_report/add_report_screen.dart';
import 'package:firefighter/views/reports/reports_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../add_fighter/add_fighter_screen.dart';
import 'components/custom_card.dart';

class HomeScreen extends StatelessWidget {
  final uType;

  HomeScreen({Key? key, required this.uType}) : super(key: key);

  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Welcome back, ${storage.read('name')}",
        height: 110,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          vHeight20(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomCardView(
                image: 'assets/report.png',
                itemName: "Add Report",
                descHide: true,
                color: bgWhite,
                to: AddReport(),
              ),
              CustomCardView(
                image: 'assets/reports.png',
                itemName: "View Reports",
                descHide: true,
                color: bgWhite,
                to: Reports(),
              ),
            ],
          ),
          vHeight20(),
          uType == "admin"
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomCardView(
                      image: 'assets/firefighter.png',
                      itemName: "Add a fighter",
                      descHide: true,
                      color: bgWhite,
                      to: AddFighter(),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
