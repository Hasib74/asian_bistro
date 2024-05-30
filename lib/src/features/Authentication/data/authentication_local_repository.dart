import '../../../core/database/local/LocalDataSourceController.dart';
import '../../auth/domain/model/token.dart';

class AuthenticationLocalRepository {
  storeToken(Token token) {
    LocalDataSourceController.to.setToken(token);
  }

  Future<Token?> getToken() {
    return LocalDataSourceController.to.getToken();
  }
}
