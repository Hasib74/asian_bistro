import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

import '../../core/utils/spaces/AppSpaces.dart';
import 'controller/online_payment_controller.dart';

class PaymentOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SolidBottomSheet(
      maxHeight: 200,
      autoSwiped: false,
      canUserSwipe: false,
      controller: OnlinePaymentController.to.solidController,
      draggableBody: false,
      body: Container(
        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                spreadRadius: 3,
                blurRadius: 10,
              )
            ],
            color: Colors.white,
/*
            border: Border.all(color: Colors.grey.withOpacity(0.6), width: 2),
*/
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: InkWell(
                      onTap: () =>
                          OnlinePaymentController.to.solidController.hide(),
                      child: Icon(Icons.clear)),
                ),
              ),
              //Spacer(),
              Text(
                "Payment With",
                style: Get.textTheme.bodyMedium,
              ),
              AppSpaces.spaces_height_20,
              // Spacer(),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Google Pay"),
                Text("Or"),
                Text("Master Card")
              ]),
            ],
          ),
          //Spacer(),
          //Spacer(),
        ),
      ), headerBar: Container(),
    );
  }
}
