import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/colors/app_colors.dart';
import '../../../core/utils/spaces/AppSpaces.dart';
import '../../profile/screen/EditProfileController/ProfileController.dart';

class OrdersCard extends StatelessWidget {
  // final image;
  //final name;
  final deliveryCharge;
  final distance;
  final offer;
  final rating;
  final orderId;
  final totalPrice;
  final discountPrice;
  final holderName;
  final holderAddress;
  final EdgeInsets? padding;

  final Decoration? decoration;

  final String? date;

  final String? createdTime;

  OrdersCard(
      {this.rating,
      //  this.name,
      this.holderAddress,
      this.holderName,
      this.offer,
      this.deliveryCharge,
      this.discountPrice,
      this.orderId,
      this.distance,
      this.totalPrice,
      this.padding,
      this.decoration,
      this.date,
      this.createdTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
      child: Container(
        height: 200,
        width: Get.width,
        decoration: decoration ??
            BoxDecoration(
                color: AppColors.whiteColor,
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
                borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(child: _orderId_totalPrice_discountPrice()),
              Expanded(
                child: _orderHolder_maillingAddress(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _orderId_totalPrice_discountPrice() {
    String? _date = date?.split("T")[0];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text("Order Information",
        //     style: Get.textTheme.bodyText1
        //         .copyWith(color: Colors.white.withOpacity(0.9))),
        AppSpaces.spaces_height_10,
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 0),
          child: Container(
            width: 130,
            height: 2,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
        Text("Order Id : ${orderId}",
            style: Get.textTheme.titleMedium
                ?.copyWith(color: Colors.black.withOpacity(0.7))),

        AppSpaces.spaces_height_5,

        Text(
            "Ordered Date : ${_date?.split("-")[2]}/${_date?.split("-")[1]}/${_date?.split("-")[0]}",
            style: Get.textTheme.titleSmall
                ?.copyWith(color: Colors.black.withOpacity(0.7))),

        AppSpaces.spaces_height_5,

        Text("Ordered Time : ${createdTime}",
            style: Get.textTheme.titleSmall
                ?.copyWith(color: Colors.black.withOpacity(0.7))),

        AppSpaces.spaces_height_5,

        Text(
            "Total Price : \$${double.parse(totalPrice.toString()).toStringAsFixed(2)}",
            style: Get.textTheme.titleSmall
                ?.copyWith(color: Colors.black.withOpacity(0.7))),

        AppSpaces.spaces_height_5,

        Text("Discount Price : \$${discountPrice}",
            style: Get.textTheme.titleSmall
                ?.copyWith(color: Colors.black.withOpacity(0.7))),
      ],
    );
  }

  /*Widget _image() {
    return ImageViewWidget(
        imageUrl: image,
        width: 140,
        height: 130,
        borderRadius_top_left: 10,
        borderRadius_bottom_left: 10);
  }*/

  _orderHolder_maillingAddress() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Name",
              style: Get.textTheme.titleMedium
                  ?.copyWith(color: Colors.black.withOpacity(0.9))),
          Text(
              holderName ??
                  "${ProfileController.to.user.value.fullName == null ? "Guest" : ProfileController.to.user.value.fullName}",
              style: Get.textTheme.titleSmall
                  ?.copyWith(color: Colors.black.withOpacity(0.6))),
          AppSpaces.spaces_height_15,
          Text(holderAddress ?? "Address",
              style: Get.textTheme.titleSmall
                  ?.copyWith(color: Colors.black.withOpacity(0.7))),
          Expanded(
            child: Text(
                "${ProfileController.to.user.value.address == null ? "" : ProfileController.to.user.value.address}",
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Get.textTheme.titleSmall
                    ?.copyWith(color: Colors.grey.withOpacity(0.9))),
          ),
        ],
      ),
    );
  }
}
