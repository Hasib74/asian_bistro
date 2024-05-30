import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../core/Error/failures.dart';
import 'otp_remote_repository.dart';

class OtpRepository {
  OtpRemoteRepository _otpRemoteRepository = new OtpRemoteRepository();

  Future<Either<dynamic, Failure>?>? getAllCountries() async {
    Either<dynamic, Failure>? response;
    Either<dynamic, Failure>? vendorResponse =
    await _otpRemoteRepository.getCountries();

    vendorResponse.fold((l) {
      return response = Left(l);
    }, (r) {
      return response = Right(r);
    });
    return response;
  }

  Future<Either<http.Response, Failure>?> sendPhoneVerificationOTPCode(
      String phoneNo, String OTPCode) async {
    Either<http.Response, Failure>? response;
    Either<http.Response, Failure>? vendorResponse =
    await _otpRemoteRepository.sentOTPRemote(phoneNo, OTPCode);

    vendorResponse.fold((l) {
      return response = Left(l);
    }, (r) {
      return response = Right(r);
    });
    return response;
  }
}
