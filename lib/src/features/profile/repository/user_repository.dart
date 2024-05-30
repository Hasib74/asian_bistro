import 'package:dartz/dartz.dart';
import 'package:pizza_user_app/src/features/profile/repository/user_remote_repository.dart';

import '../../../core/Error/failures.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
class UserRepository {
  UserRemoteRepository _userRemoteRepository = UserRemoteRepository();

  Future<Either<Failure, http.Response>?> getUser() async {
    print("UserRepository getUser");
    Either<Failure, http.Response>? data = await _userRemoteRepository.getUser();

    return data?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<dynamic, Failure>?>? updateProfile(
      {user, File? file, String? imageKey}) async {
    Either<dynamic, Failure>? response;

    Either<dynamic, Failure>? vendorResponse = await _userRemoteRepository
        .updateUserProfile(user: user, file: file, imageKey: imageKey);

    vendorResponse.fold((l) {
      response = Left(l);
    }, (r) {
      response = Right(r);
    });

    return response;
  }

  Future<Either<dynamic, Failure>> updatePassword(body) async {
    Either<dynamic, Failure> data =
    await _userRemoteRepository.updateNewPassword(body);

    return data.fold((l) => Left(l), (r) => Right(r));
  }
}