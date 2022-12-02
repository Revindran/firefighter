import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants.dart';

class CustomCardView extends StatelessWidget {
  final itemName, desc, image, to, color, descHide;

  const CustomCardView(
      {Key? key,
      this.itemName,
      this.desc,
      this.image,
      this.to,
      this.color,
      this.descHide = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width / 2.5,
      height: 200,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        child: InkWell(
          onTap: () => Get.to(to),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: 100,
                    width: 100,
                    child: Image(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    )),
                vHeight10(),
                Text(
                  itemName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
