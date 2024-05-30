import 'package:dartz/dartz.dart';

import 'package:http/http.dart' as http;

import '../../../core/Error/failures.dart';
import '../../../core/Network/network_info.dart';
import '../../../core/app_snack_bar/app_snack_bar.dart';
import '../../../core/remote/app_helper/app_remote_helper.dart';
import '../../../core/remote/urls/app_urls.dart';

class OtpRemoteRepository {
  Future<Either<dynamic, Failure>> getCountries() async {
    try {
      if (await NetworkInfoController.to.isConnected) {
        print("SUB BODY country ");
        dynamic response = await ApiClient.Request(
            url: "${ApiUrls.country_list}",
            enableHeader: false,
            body: null,
            method: Method.GET);

        return Left(response);
      } else {
        print("network error is occured");
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      print("Error : ${err}");
      return Right(ServerFailure());
    }
  }

  Future<Either<http.Response, Failure>> sentOTPRemote(
      String phoneNo, String OTPCode) async {
    try {
      if (await NetworkInfoController.to.isConnected) {
        print("SUB BODY OTP Send ${phoneNo} code ${OTPCode}");



        AppSnackBar.successSnackbar(msg: "The otp code is ${OTPCode}" ,  sec:  10);



        dynamic response = await ApiClient.Request(
            url:
            "${ApiUrls.phone_no_verificaton}?phoneno=${phoneNo}&otpcode=${OTPCode}",
            //ApiUrls.phone_no_verificaton,//
            enableHeader: false,
            body: {'phoneno': phoneNo, 'otpcode': OTPCode},
            method: Method.GET);
        return Left(response);
      } else {
        print("network error is occured");
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      print("Error : ${err}");
      return Right(ServerFailure());
    }
  }

  Future<Either<http.Response, Failure>> checkPhoneVerficationOTPCode(
      String phoneNo, String OTPCode) async {
    try {
      if (await NetworkInfoController.to.isConnected) {
        print("SUB BODY ${phoneNo}");
        dynamic response = await ApiClient.Request(
            url:
            "${ApiUrls.phone_verfication_OTP_checking}?phoneno=${phoneNo}&otpcode=${OTPCode}",
            enableHeader: false,
            body: {'phoneno': phoneNo, 'otpcode': OTPCode},
            method: Method.POST);

        return Left(response);
      } else {
        print("network error is occured");
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      print("Error : ${err}");
      return Right(ServerFailure());
    }
  }
}
