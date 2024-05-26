class UserData {
  final String name;
  final String phone;
  final String email;


  UserData({
    required this.name,
    required this.phone,
    required this.email,

  });

  Map<String, dynamic> toJson() =>
      {'name': name, 'phone': phone, 'email': email};
  static UserData fromJson(Map<String, dynamic> json) => UserData(
        name: json['name'],
        phone: json['phone'],
        email: json['email'],
      );
}
