class LoginData {
  String? firstName;
  String? lastName;
  String? wowId;
  String? id;

  LoginData({this.firstName, this.lastName, this.wowId,this.id});

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'wowId': wowId,
      'id':id
    };
  }

  // Convert JSON back to object
  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      firstName: json['firstName'],
      lastName: json['lastName'],
      wowId: json['wowId'],
      id: json['id']
    );
  }
}
