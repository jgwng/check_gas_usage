class User{
  String userKey;
  String name;
  String phoneNumber;
  String firstAddress;
  String secondAddress;
  bool userState;

  User({this.userKey, this.name,this.phoneNumber,this.firstAddress,this.secondAddress,this.userState : false});




  factory User.fromJson(Map<String, dynamic> map,String userKey) {
    return new User(
      userKey: userKey,
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      firstAddress: map['firstAddress'] as String,
      secondAddress: map['secondAddress'] as String,
      userState: map['userState'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userKey': this.userKey,
      'name': this.name,
      'phoneNumber': this.phoneNumber,
      'firstAddress': this.firstAddress,
      'secondAddress': this.secondAddress,
      'userState': this.userState,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return new User(
      userKey: map['userKey'] as String,
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      firstAddress: map['firstAddress'] as String,
      secondAddress: map['secondAddress'] as String,
      userState: map['userState'] as bool,
    );
  }
}