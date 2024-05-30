class AppNotificationResponse{

  var  success ;

  AppNotificationResponse.fromJson(json){

    this.success = json["success"] ;

  }

}