import 'package:flutter/material.dart';

class CustomTitleAndValueTileWidget extends StatelessWidget {
  String? title;
  String? value;
  TextStyle? titleStyle;

  TextStyle? valueStyle;

  CustomTitleAndValueTileWidget(
      {super.key, this.value, this.title, this.titleStyle, this.valueStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title ?? "",
              style: titleStyle ??
                  TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )),
          Expanded(
            child: Text(
              value ?? "",
              style: valueStyle ??
                  TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
