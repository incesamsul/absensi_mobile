class Absen {
  final String id_user;
  final String status;
  final String tgl;
  final String jam;
  final String icon;

  Absen({
    required this.id_user,
    required this.status,
    required this.tgl,
    required this.jam,
    required this.icon,
  });

  factory Absen.fromJson(Map<String, dynamic> json) {
    return Absen(
      id_user: json['id_user'],
      status: json['status'],
      tgl: json['tgl'],
      jam: json['jam'],
      icon: json['icon'],
    );
  }
}
