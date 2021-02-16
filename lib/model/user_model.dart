import 'dart:convert';

List<UserModel> userModelFromJson(String str) {
  List<dynamic> jsonData = json.decode(str)['data'];
  List<UserModel> _listUser = List<UserModel>();
  for (var i = 0; i < jsonData.length; i++) {
    UserModel _userModel = UserModel(
      id: jsonData[i]['id'],
      email: jsonData[i]["email"],
      firstName: jsonData[i]["first_name"],
      lastName: jsonData[i]["last_name"],
      avatar: jsonData[i]["avatar"],
    );
    _listUser.add(_userModel);
  }
  return _listUser;
  // return List<UserModel>.from(
  //     json.decode(str)['data'].map((x) => {UserModel.fromJson(x)}));
}

class UserModel {
  UserModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  // factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
  //   id: json["id"],
  //   email: json["email"],
  //   firstName: json["first_name"],
  //   lastName: json["last_name"],
  //   avatar: json["avatar"],
  // );
  //
  // Map<String, dynamic> toJson() => {
  //   "email": email,
  //   "id": id,
  //   "firstName": firstName,
  //   "lastName": lastName,
  //   "avatar": avatar,
  // };

  @override
  String toString() {
    return 'UserModel{id: $id, email: $email, firstName: $firstName, lastName: $lastName, avatar: $avatar}';
  }
}
