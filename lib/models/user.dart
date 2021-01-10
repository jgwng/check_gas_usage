class UserInfo {
  String name;
  String phoneNumber;
  String firstAddress;
  String secondAddress;

  UserInfo({this.name,this.phoneNumber,this.firstAddress,this.secondAddress});

  Map<String, dynamic> toJson () => <String, dynamic>{
    'firstAddress': this.firstAddress,
    'name' : this.name,
    'phoneNumber': this.phoneNumber,
    'secondAddress': this.secondAddress,
  };
}