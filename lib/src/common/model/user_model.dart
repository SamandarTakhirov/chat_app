

class UserModel {
  final String uid;
  final String? name;
  final String email;
  final String password;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.password,
  });

  UserModel copyWith(
          {String? uid, String? name, String? email, String? password}) =>
      UserModel(
          uid: this.uid,
          name: this.name,
          email: this.email,
          password: this.password);


  factory UserModel.fromJson(Map<String, Object?> json) => UserModel(
        uid: json["uid"] as String,
        name: json["name"] as String,
        email: json["email"] as String,
        password: json["password"] as String,
      );

  Map<String, Object?> toJson( ) => <String, Object?>{
        "uid": uid,
        "name": name,
        "email": email,
        "password": password,
      };

  @override
  int get hashCode => uid.hashCode;


  @override
  String toString() {
    return 'UserModel{u id: $uid, name: $name, email: $email, password: $password}';
  }

  @override
  bool operator ==(Object other) =>
      other is UserModel &&
      runtimeType == other.runtimeType &&
      uid == other.uid &&
      name == other.name &&
      email == other.email &&
      password == other.password;
}
