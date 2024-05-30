import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../../features/profile/screen/EditProfileController/ProfileController.dart';
import '../FirebaseKey/firebase_key.dart';
class FBTokenRepository {
  String _TAG = "FBTokenRepository";

/*  tokenGetAndSendToFirebaseDB() {
    FirebaseMessaging.instance.getToken().then((value) {
      print("${_TAG} token is : ${value}");
      FirebaseDatabase.instance
          .ref()
          .child(FirebaseKey.DEVICE_TOKEN)
          .child(FirebaseKey.USER)
          .child(ProfileController.to.user.value.phone)
          .set({FirebaseKey.TOKEN: value});
    });
  }*/

  getFirebaseDeviceToken() async {
    String? _token = await FirebaseMessaging.instance.getToken();

    print("Device token is :: ${_token}");
    return _token;
  }

  test() {
    print("Testing...............");
  }
}
