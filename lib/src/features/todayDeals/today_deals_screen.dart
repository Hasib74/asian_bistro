import 'package:flutter/material.dart';
import 'package:pizza_user_app/src/core/utils/colors/app_colors.dart';

class TodayDealsScreen extends StatelessWidget {
  TodayDealsScreen({super.key , this.title, this.message});

  String? title;

  String? message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(title ?? "Today Deals"),
      ),
      body: Center(
        child: Text(message ?? "No deals today"),
      ),
    );
  }
}
