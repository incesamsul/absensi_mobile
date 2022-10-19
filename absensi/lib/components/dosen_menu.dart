import 'package:absensi/models/api_response.dart';
import 'package:absensi/repository.dart';
import 'package:absensi/screens/absen_user.dart';
import 'package:absensi/screens/k_mean_cluster.dart';
import 'package:absensi/screens/login.dart';
import 'package:absensi/screens/logs.dart';
import 'package:absensi/screens/view_data_kelas.dart';
import 'package:absensi/screens/view_data_matakuliah.dart';
import 'package:absensi/widget/menu_card.dart';
import 'package:flutter/material.dart';

class DosenMenu extends StatelessWidget {
  DosenMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: .85,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      children: <Widget>[
        MenuCard(
          title: 'Absen',
          svgSrc: "assets/icons/hadir.svg",
          press: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AbsenUser(
                      id_user: 1.toString(),
                    )));
          },
        ),
        MenuCard(
          title: 'Kelas',
          svgSrc: "assets/icons/alfa.svg",
          press: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ViewDataKelas()));
          },
        ),
        MenuCard(
          title: 'Matakuliah',
          svgSrc: "assets/icons/sakit.svg",
          press: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ViewDataMatakuliah()));
          },
        ),
        MenuCard(
          title: 'K-mean cluster',
          svgSrc: "assets/icons/izin.svg",
          press: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => KMeanCluster()));
          },
        )
      ],
    );
  }
}
