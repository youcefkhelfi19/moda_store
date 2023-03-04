
class Admin {
  String username;
  String email;
  String? adminId;
  String phone;
  String address;
   String image;
  Admin({required this.image,required this.address,required this.username, required this.email, this.adminId, required this.phone});

  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
    'adminId': adminId,
    'phone': phone,
    'address':address,
    'image':image,
  };

  static Admin fromJson(Map<String, dynamic> json) {
    return Admin(
      username: json['username'],
      email: json['email'],
      adminId: json['adminId'],
      phone: json['phone'],
      image: json['image'],
      address: json['address'],
    );
  }
}
