class ApiUrls {
  // static String download_base_url = "https://singlevendor.baadhan.com/";
/*   static String download_base_url =
      "https://wingsthingsandpizzas.eventsandimage.com/";*/
  static String download_base_url =
      "https://asian-bistro.tech365.cloud/";
 // static String download_base_url = "https://sva2.frontiersalesforce.com/";

//  static String base_url = "https://singlevendor.baadhan.com/api/";
  //static String base_url = "https://onlineordering201.com/api/";
/*  static String base_url =
      "https://wingsthingsandpizzas.eventsandimage.com/api/";*/
    static String base_url =
      "https://asian-bistro.tech365.cloud/api/";
//  static String base_url = "https://sva2.frontiersalesforce.com/api/";
  static String vendor_offer = "${base_url}restaurant-service";
  static String vendor_type = "${base_url}productTypes";
  static String product_stock = "${base_url}productStock";
  static String user_signup = "${base_url}user-registration-with-phone";
  static String user_signIN = "${base_url}user/login";

  //Accout Recovery
  static String account_recovery = "${base_url}customer/account-recovery";
  static String order = "${base_url}create/order";
  static String orderTracking = "${base_url}customer/order-status";
  static String userProfile = "${base_url}customer/my-profile";
  static var demoImage =
      "https://thumbs.dreamstime.com/b/monarch-orange-butterfly-bright-summer-flowers-background-blue-foliage-fairy-garden-macro-artistic-image-monarch-167030287.jpg";
  static var userProfileUpdate = "${base_url}customer/my-profile/update";
  static var changePassword = "${base_url}vendor/change-password";
  static String country_list = "${base_url}get-countries";
  static String phone_no_verificaton = "${base_url}getphone-otpcode";
  static String phone_verfication_OTP_checking =
      "${base_url}checkphone-otpcode";
  static String stripe_create_customer = "${base_url}stripe-create-customer";
  static String stripe_create_payment_method =
      "${base_url}stripe-create-payment-method";
  static String stripe_create_payment_intent =
      "${base_url}stripe-create-payment-intent";
  static String stripe_payment_confirmation =
      "${base_url}stripe-payment-confirmation";

  static var logOut = "${base_url}logout";
  static var updateDeviceToken = "${base_url}customer/update-device-token";

  /*
  *http://127.0.0.1:8000/api/add-customer/rating?customer_id=dsjfdsk&comments=no comments&rating_value=4.5&order_id=1&service_provider_id=1&deliverymen_id=1&deliverymen_comments=good work&daliverymen_rating_value=5.0
  *
  * */

  static var feed_back = "${base_url}add-customer/rating";
  static String check_rating_aviable = "${base_url}customer/check-rating";

  static var vendor_offer_search = "${base_url}search-optin/user";

  static var getOrderProductList = "${base_url}customer/order/product-list/";

  static var banner = "${base_url}banners";
  static var all_summer_offer = "${base_url}all-summer-offer/product";
  static var all_winter_offer = "${base_url}all-winter-offer/product";
}
