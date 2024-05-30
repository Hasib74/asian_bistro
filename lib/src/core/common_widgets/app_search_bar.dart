import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/colors/app_colors.dart';
import '../utils/spaces/AppSpaces.dart';

typedef Function? SearchText(String searchText);

class AppSearchWidget extends StatefulWidget {
  //const VendorOfferSearch({Key? key}) : super(key: key);

  SearchText searchText;

  VoidCallback? closeBtnOnClick;

  TextEditingController? searchTextExitingController;

  FocusNode? focusNode;

  AppSearchWidget(
      {required this.searchText,
      this.closeBtnOnClick,
      this.searchTextExitingController,
      this.focusNode});

  @override
  State<AppSearchWidget> createState() => _AppSearchWidgetState();
}

class _AppSearchWidgetState extends State<AppSearchWidget> {
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 40,
      width: Get.size.width * 0.9,
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: 1,
              blurRadius: 1,
            )
          ],
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.searchTextExitingController,
              focusNode: widget.focusNode,
              onChanged: (value) {
                widget.searchText(value);
                setState(() {
                  _searchText = value;

                  printInfo(info: "Search text ::: ${_searchText}");
                });
              },
              decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  counterText: '',
                  hintText: "Search...",
                  contentPadding:
                      EdgeInsets.only(left: 20, bottom: 9, top: 0, right: 15),
                  focusColor: Colors.black),
              cursorColor: Colors.black,
              maxLength: 20,
              maxLines: 1,
            ),
          ),
          _searchText.length > 0
              ? InkWell(
                  onTap: () {
                    widget.closeBtnOnClick!();
                    setState(() {
                      _searchText = "";
                      widget.searchTextExitingController?.text = "";
                      widget.focusNode?.canRequestFocus = false;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(Icons.close),
                      AppSpaces.spaces_width_5,
                      AppSpaces.spaces_width_5,
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
