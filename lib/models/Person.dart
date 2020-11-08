class Person {
  String uid;
  String name;
  String email;
  String username;
  int state;

  Person({
    this.uid,
    this.name,
    this.email,
    this.username,
    this.state,
  });

  Map toMap(Person user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['name'] = user.name;
    data['email'] = user.email;
    data['username'] = user.username;
    data["state"] = user.state;
    return data;
  }

  // Named constructor
  Person.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.name = mapData['name'];
    this.email = mapData['email'];
    this.username = mapData['username'];
    this.state = mapData['state'];
  }
}
