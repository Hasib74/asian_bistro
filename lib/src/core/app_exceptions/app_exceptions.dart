import '../Error/failures.dart';
import '../app_snack_bar/app_snack_bar.dart';

class AppExceptionHandle {
  static exceptionHandle(Failure failure) {
    if (failure is ServerFailure) {
      AppSnackBar.errorSnackbar(msg: "Server Exception }");
    } else if (failure is NoConnectionFailure) {

      failure.errorMessage ;

      AppSnackBar.errorSnackbar(msg: "Please check your internet connection");
    }
  }

  static errorMessage(String message) {
    AppSnackBar.errorSnackbar(msg: message);
  }
}
