abstract class DeviceTokenRepository{
  saveDeviceToken(String deviceToken , String id);

  Future<String> getDeviceToken();


}