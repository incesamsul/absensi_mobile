class User {
  int? id;
  String? name;
  String? image;
  String? email;
  String? no_hp;
  String? alamat;
  String? role;
  String? token;

  User({
    this.id,
    this.name,
    this.image,
    this.email,
    this.no_hp,
    this.alamat,
    this.role,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      name: json['user']['name'],
      image: json['user']['image'],
      email: json['user']['email'],
      no_hp: json['user']['no_hp'],
      alamat: json['user']['alamat'],
      role: json['user']['role'],
      token: json['user']['token'],
    );
  }
}
