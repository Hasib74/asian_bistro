import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

showProductImageSelectDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(child: Text('Select Product Image ')),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[],
          ),
        ),
        actions: <Widget>[
          Center(
            child: TextButton(
              child: Icon(Icons.photo_album), // Text('Open Gallery'),
              style: TextButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                shadowColor: Colors.red,
                elevation: 5,
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontStyle: FontStyle.italic),
              ),
              onPressed: () async {
                XFile? _imageFile = await openPhoneCameraOrGallery(false);
                Get.back(result: _imageFile);
              },
            ),
          ),
          SizedBox(height: 7),
          Center(
            child: TextButton(
              child: Icon(Icons.camera_alt), // Text('Open Camera'),
              style: TextButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                shadowColor: Colors.red,
                elevation: 5,
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontStyle: FontStyle.italic),
              ),
              onPressed: () async {
                XFile? _imageFile = await openPhoneCameraOrGallery(true);

                Get.back(result: _imageFile);
              },
            ),
          ),
        ],
      );
    },
  );
}


Future<XFile?> openPhoneCameraOrGallery(bool isCamera) async {
  // final pickedFile = await imagePicker.getImage(source: ImageSource.camera);

  final imagePicker = ImagePicker();

  XFile? pickedFile;
  if (isCamera) {
    pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
  } else {
    pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
  }
  if (pickedFile != null) {
    return pickedFile;
  } else {
    return null;
  }
}