import 'package:flutter/material.dart';

import 'app_image_view_widget.dart';

IconButton AppIconButton(
    {String? image,
    var index = 0,
    VoidCallback? onPressed,
    Color? iconColor}) {
  return IconButton(
      onPressed: onPressed,
      icon: AppImageView(
        color: iconColor,
        image: image,
        width: 25,
        height: 25,
      ).getImage());
}
