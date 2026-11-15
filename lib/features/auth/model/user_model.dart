class UserModel {
  final String uid;
  final String email;
  final String name;
  final String phone;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phone': phone,
    };
  }
}