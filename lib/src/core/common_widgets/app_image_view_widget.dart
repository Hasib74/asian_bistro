import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImageView {
  String? image;
  double? height;
  double? width;
  double? size;

  Color? color;

  BoxFit? fit;

  AppImageView(
      {this.image, this.height, this.width, this.color, this.size, this.fit})
      : assert(image != null);

  getImage() {
    switch (image?.contains("http")) {
      case true:
        print("http");
        break;
      case false:
        switch (image?.split(".")[1]) {
          case "svg":
            print("Svg image :: ${image}");

            return SvgPicture.asset(
              image!,
              width: size ?? width,
              height: size ?? height,
              color: color,
              fit: fit ?? BoxFit.contain,
            );

            break;
          case "png":
            print("png");

            print("Png image :: ${image}");
            return Image.asset(
              image!,
              width: size ?? width,
              height: size ?? height,
              color: color,
              fit: fit ?? BoxFit.contain,
            );
            break;
          case "jpg":
            print("jpg");
            return Image.asset(
              image!,
              width: size ?? width,
              height: size ?? height,
              color: color,
              fit: fit ?? BoxFit.contain,
            );
            break;
          case "jpeg":
            print("jpeg");
            break;
          default:
            print("default");
            break;
        }

        break;
    }
  }
}
