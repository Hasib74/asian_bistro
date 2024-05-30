import 'dart:io';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/colors/app_colors.dart';
import 'app_loading.dart';

enum ImageType {
  RING,
  RECTANGLE,
}

Widget ImageViewWidget(
    {required String? imageUrl,
    ImageType imageType = ImageType.RECTANGLE,
    BoxFit? fit = BoxFit.cover,
    bool borderEnable = false,
    double? height,
    double? width,
    File? file,
    double borderRadius_top_left = 0,
    double borderRadius_top_right = 0,
    double borderRadius_bottom_left = 0,
    double borderRadius_bottom_right = 0,
    double imageSize = 80}) {
  print("Image link : ${imageUrl}");
  return file == null
      ? /*_networkImage(
          imageUrl,
          height,
          imageSize,
          width,
      fit
        )*/
      _cachedNetworkImage(
          imageUrl!,
          height,
          imageSize,
          width,
          imageType,
          borderEnable,
          borderRadius_bottom_right,
          borderRadius_bottom_left,
          borderRadius_top_right,
          borderRadius_top_left,
          fit ?? BoxFit.cover)
      : Container(
          width: width ?? imageSize ?? double.infinity,
          height: height ?? imageSize ?? double.infinity,
          decoration: BoxDecoration(
              shape: imageType == ImageType.RECTANGLE
                  ? BoxShape.rectangle
                  : BoxShape.circle,
              border: borderEnable ? Border.all() : null,
              image: DecorationImage(
                  fit: fit ?? BoxFit.cover, image: FileImage(file))),
        );
}

_networkImage(String? imageUrl, double? height, double imageSize, double? width,
    BoxFit? fit) {
  return Image.network(
      imageUrl != null && imageUrl.isNotEmpty
          ? imageUrl
          : "https://cdn.pixabay.com/photo/2017/12/10/14/47/pizza-3010062_1280.jpg",
      width: height ?? imageSize ?? double.infinity,
      height: width ?? imageSize ?? double.infinity,
      fit: fit ?? BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.primaryColor,
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
            : null,
      ),
    );
  });
}

CachedNetworkImage _cachedNetworkImage(
    String imageUrl,
    double? height,
    double imageSize,
    double? width,
    ImageType imageType,
    bool borderEnable,
    double borderRadius_bottom_right,
    double borderRadius_bottom_left,
    double borderRadius_top_right,
    double borderRadius_top_left,
    BoxFit fit) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    imageBuilder: (context, imageProvider) => Container(
      width: height ?? imageSize ?? double.infinity,
      height: width ?? imageSize ?? double.infinity,
      decoration: BoxDecoration(
        shape: imageType == ImageType.RECTANGLE
            ? BoxShape.rectangle
            : BoxShape.circle,
        border: borderEnable ? Border.all() : null,
        borderRadius: imageType == ImageType.RING
            ? null
            : BorderRadius.only(
                bottomRight: Radius.circular(borderRadius_bottom_right),
                bottomLeft: Radius.circular(borderRadius_bottom_left),
                topRight: Radius.circular(borderRadius_top_right),
                topLeft: Radius.circular(borderRadius_top_left)),
        image: DecorationImage(image: imageProvider, fit: fit ?? BoxFit.cover),
      ),
    ),
    placeholder: (context, url) =>
        SizedBox(width: 20, height: 20, child: AppLoading()),
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}
