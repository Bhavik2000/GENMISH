class Persons {
  String uid;
  String otp;
  String email;
  String country;
  String payment;
  int status;
  String reason;
  String name;

  Persons(
      {this.uid,
      this.otp,
      this.email,
      this.payment,
      this.status,
      this.reason,
      this.country,
      this.name});

  Map toMap(Persons user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['otp'] = user.otp;
    data['email'] = user.email;
    data['payment'] = user.payment;
    data['status'] = user.status;
    data['country'] = user.country;
    data['name'] = user.name;
    data['reason'] = user.reason;
    return data;
  }

  // Named constructor
  Persons.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.otp = mapData['otp'];
    this.email = mapData['email'];
    this.payment = mapData['payment'];
    this.status = mapData['status'];
    this.country = mapData['country'];
    this.name = mapData['name'];
    this.reason = mapData['reason'];
  }
}
