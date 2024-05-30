import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/spaces/AppSpaces.dart';

Widget AppTextFieldWidget(
    {Color cursorColor = Colors.black,
    bool obscureText = false,
    IconData? prefixIcon,
    bool filled = true,
    Color fillColor = const Color(0xffd5d5d5),
    String? levelText,
    Color levelColor = const Color(0xffd5d5d5),
    Color border_color = const Color(0xffd5d5d5),
    Color focus_border_color = const Color(0xffd5d5d5),
    Function(String?)? onSave,
    double horizontal_pading = 10,
    double vartical_pading = 0,
    String? hint,
    double? padding = 16.0,
    double? padding_right,
    double? padding_left,
    double? width,
    double? height,
    //bool enable = true,
    var maxLines = 1,
    var minLines = 1,
    var maxLength = null,
    TextEditingController? controller,
    IconData? leadingIcon,
    bool focusEnable = true,
    FocusNode? focusNode,
    TextInputType textInputType = TextInputType.text,
    Function(dynamic value)? onChanged}) {
  return Container(
    height: maxLines == 1 ? 45 : maxLines! * 24.0,
    width: width ?? Get.width * 0.9,
    decoration: BoxDecoration(
        color: maxLines != null ? fillColor : Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(5))),
    margin: EdgeInsets.only(
        left: padding_left ?? padding ?? 0,
        right: padding_right ?? padding ?? 0),
    padding: EdgeInsets.only(
        left: padding_left ?? padding ?? 0,
        right: padding_right ?? padding ?? 0),
    child: leadingIcon == null
        ? TextField(
            // focusNode: focusNode,
            controller: controller,
            maxLines: maxLines,
            maxLength: maxLength,
            enabled: focusEnable,
            obscureText: obscureText,
            keyboardType: textInputType,
            cursorColor: cursorColor,
            style: TextStyle(color: Colors.black),
            onChanged: onChanged,
            decoration: InputDecoration(
              counterText: "",
              prefixIcon: prefixIcon != null
                  ? Icon(
                      prefixIcon,
                      size: 40,
                    )
                  : null,
              filled: filled,
              fillColor: fillColor,
              labelText: levelText,
              hintText: hint,
              labelStyle: TextStyle(color: levelColor),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: focus_border_color),
              ),
              focusedErrorBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                  vertical: vartical_pading, horizontal: horizontal_pading),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
            ),
          )
        : Container(
            width: Get.width,
            child: Row(
              children: [
                AppSpaces.spaces_width_15,
                Icon(leadingIcon),
                AppSpaces.spaces_width_20,
                Expanded(
                  child: TextField(
                    //   focusNode: focusNode,
                    obscureText: obscureText,
                    controller: controller,
                    decoration: InputDecoration(
/*
                      prefixIcon: Icon(Icons.alarm),



*/
                        hintText: hint,
                        contentPadding: EdgeInsets.only(left: 0),
                        focusedErrorBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        border: new UnderlineInputBorder(
                            borderSide:
                                new BorderSide(color: Colors.transparent)),
                        focusedBorder: new UnderlineInputBorder(
                            borderSide:
                                new BorderSide(color: Colors.transparent)),
                        enabledBorder: InputBorder.none),
                    cursorColor: cursorColor,
                  ),
                ),
                AppSpaces.spaces_width_15,
              ],
            ),
          ),
  );
}
