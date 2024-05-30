import 'package:dartz/dartz.dart';

import '../../../core/Error/failures.dart';
import '../../auth/domain/model/token.dart';
import 'authentication_local_repository.dart';
import 'authentication_remote_repository.dart';
import 'package:http/http.dart' as http;

class AuthenticationRepository {
  AuthenticationLocalRepository _authenticationLocalRepository =
  new AuthenticationLocalRepository();
  AuthenticationRemoteRepository _userSignupRemoteRepository =
  new AuthenticationRemoteRepository();

  Future<Either<dynamic, Failure>?>? userSignUp(body) async {
    Either<dynamic, Failure>? response;
    var either = await _userSignupRemoteRepository.signUp(body);

    Either<dynamic, Failure> userResponse = either;
    userResponse.fold((l) {
      response = Left(l);
    }, (r) {
      response = Right(r);
    });

    return response;
  }

  Future<Either<dynamic, Failure>?> signIn(body) async {
    Either<dynamic, Failure>? response;
    var either = await _userSignupRemoteRepository.signIn(body);

    Either<dynamic, Failure>? userResponse = either;
    userResponse.fold((l) {
      response = Left(l);
    }, (r) {
      response = Right(r);
    });

    return response;
  }


  Future<Either<http.Response, Failure>?> sendAccountRecoveryPassword(String phoneNo) async {
    Either<http.Response,Failure>? response;
    Either<http.Response,Failure>? responseResult = await _userSignupRemoteRepository.sendAccountRecoveryPassword(phoneNo);
    responseResult.fold((l){
      return response = Left(l);
    },(r) {
      return response = Right(r);
    });
    return response;
  }

  Future<Either<http.Response, Failure>?> logOut() async {
    Either<http.Response,Failure>? response;
    Either<http.Response,Failure>? responseResult = await _userSignupRemoteRepository.logOut();
    responseResult.fold((l){
      return response = Left(l);
    },(r) {
      return response = Right(r);
    });
    return response;
  }


  Future<Token?> getToken() {
    return _authenticationLocalRepository.getToken();
  }
}
