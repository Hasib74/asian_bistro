class User {
  var customer_id;
  var fullName;
  var address;
  var email;
  var phone;
  var photo;
  var genderId;
  var countryId;
  var description;
  var cardNumber;
  var cardCvc;
  var lat_value;
  var long_value;
  var createdAt;
  var updatedAt;

  User(
      {this.customer_id,
      this.fullName,
      this.address,
      this.email,
      this.lat_value,
      this.long_value,
      this.phone,
      this.photo,
      this.genderId,
      this.countryId,
      this.description,
      this.cardNumber,
      this.cardCvc,
      this.createdAt,
      this.updatedAt});

  User.fromJson(dynamic json) {
    // print("IDDDDDDDDDDDDDD => ${json[0]['id']}");

    if (json != null) {
      customer_id = json[0]['customer_id'];
      fullName = json[0]['full_name'];
      address = json[0]['address'];
      email = json[0]['email'];
      phone = json[0]['phone'];
      photo = json[0]['photo'];
      genderId = json[0]['gender_id'];
      countryId = json[0]['country_id'];
      description = json[0]['description'];
      cardNumber = json[0]['card_number'];
      cardCvc = json[0]['card_cvc'];
      lat_value = json[0]["lat_value"];
      long_value = json[0]["long_value"];
      createdAt = json[0]['created_at'];
      updatedAt = json[0]['updated_at'];
    }
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['customer_id'] = this.customer_id;
    data['full_name'] = this.fullName;
    data['address'] = this.address;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['photo'] = this.photo;
    data['gender_id'] = this.genderId;
    data['country_id'] = this.countryId;
    data['description'] = this.description;
    data['card_number'] = this.cardNumber;
    data['card_cvc'] = this.cardCvc;
    data["lat_value"] = this.lat_value ?? "";
    data["long_value"] = this.long_value ?? "";
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
