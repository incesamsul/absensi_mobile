import 'package:absensi/screens/data_absen.dart';
import 'package:absensi/screens/data_kelas.dart';
import 'package:absensi/screens/data_matakuliah.dart';
import 'package:absensi/screens/login.dart';
import 'package:absensi/screens/pengguna.dart';
import 'package:absensi/widget/menu_card.dart';
import 'package:flutter/material.dart';

class AdminMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: .85,
      crossAxisSpacing: 20,
      mainAxisSpacing: 6,
      children: <Widget>[
        MenuCard(
          title: 'Pengguna',
          svgSrc: "assets/icons/hadir.svg",
          press: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Pengguna()));
          },
        ),
        MenuCard(
          title: 'Data absen',
          svgSrc: "assets/icons/alfa.svg",
          press: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => DataAbsen()));
          },
        ),
        MenuCard(
          title: 'Data Kelas',
          svgSrc: "assets/icons/sakit.svg",
          press: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => DataKelas()));
          },
        ),
        MenuCard(
          title: 'Data Matakuliah',
          svgSrc: "assets/icons/izin.svg",
          press: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => DataMatakuliah()));
          },
        ),
      ],
    );
  }
}
