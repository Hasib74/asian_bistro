import 'package:flutter/material.dart';
import 'package:pizza_user_app/generated/assets.dart';
import 'package:get/get.dart';
import 'package:pizza_user_app/src/core/common_widgets/custom_card_view.dart';
import 'package:pizza_user_app/src/core/common_widgets/custom_title_and_value_tile_widget.dart';
import 'package:pizza_user_app/src/core/utils/colors/app_colors.dart';

class ContractUsScreen extends StatelessWidget {
  bool isContactUs;

  ContractUsScreen({super.key, this.isContactUs = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isContactUs ? "Contact Us" : "Hours of Operation"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomCardView(
                  child: Column(
                children: [
                  if (isContactUs) ...[
                    Text(
                      "Contact Us",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    CustomTitleAndValueTileWidget(
                        title: "Email", value: "info.asianbistro@gmail.com"),
                    Divider(),
                    CustomTitleAndValueTileWidget(
                        title: "Phone", value: "410-788-8680, 410-788-8696"),
                    Divider(),
                    CustomTitleAndValueTileWidget(
                        title: "Address", value: "5210 baltimore national pike baltimore ,MD 21229,USA"),
                  ] else ...[
                    Text(
                      "Hours of Operation",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    CustomTitleAndValueTileWidget(
                        title: "Sturday", value: "11:00 AM - 10:15 PM"),
                    Divider(),
                    CustomTitleAndValueTileWidget(
                        title: "Sunday", value: "12:00 AM - 9:45 PM"),
                    Divider(),
                    CustomTitleAndValueTileWidget(
                        title: "Monday", value: "11:00 AM - 9:45 PM"),
                    Divider(),
                    CustomTitleAndValueTileWidget(
                        title: "Tuesday", value: "11:00 AM - 9:45 PM"),
                    Divider(),
                    CustomTitleAndValueTileWidget(
                        title: "Wednesday", value: "11:00 AM - 9:45 PM"),
                    Divider(),
                    CustomTitleAndValueTileWidget(
                        title: "Thursday", value: "11:00 AM - 9:45 PM"),
                    Divider(),
                    CustomTitleAndValueTileWidget(
                        title: "Friday", value: "11:00 AM - 10:15 PM"),
                  ]
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
