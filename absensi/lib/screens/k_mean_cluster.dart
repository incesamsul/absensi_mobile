import 'package:absensi/constant.dart';
import 'package:absensi/models/absen.dart';
import 'package:absensi/repository.dart';
import 'package:absensi/screens/absen_user.dart';
import 'package:absensi/screens/login.dart';
import 'package:absensi/screens/routing.dart';
import 'package:absensi/services/user_service.dart';
import 'package:absensi/widget/bottom_nav_bar.dart';
import 'package:absensi/widget/logs_card.dart';
import 'package:absensi/widget/menu_card.dart';
import 'package:absensi/widget/search_bar.dart';
import 'package:absensi/widget/user_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KMeanCluster extends StatefulWidget {
  @override
  _KMeanClusterState createState() => _KMeanClusterState();
}

class _KMeanClusterState extends State<KMeanCluster> {
  List dataKelas = [];

  Repository repository = Repository();
  getData() async {
    dataKelas = await repository.getAllKelas();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future refresh() async {
    setState(() {
      dataKelas = getData();
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          // Here the height of the container is 45% of our total height
          height: MediaQuery.of(context).size.height * .25,
          decoration: BoxDecoration(
            color: kSecondColor,
            image: DecorationImage(
              alignment: Alignment.centerLeft,
              image: AssetImage("assets/images/undraw_pilates_gpdb.png"),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    alignment: Alignment.center,
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                      color: kSecondColor,
                      shape: BoxShape.circle,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Routing()));
                      },
                      child: Container(
                        height: 57.6,
                        width: 57.6,
                        padding: EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9.6),
                          color: Color(0x080a0928),
                        ),
                        child: SvgPicture.asset("assets/icons/menu.svg"),
                      ),
                    ),
                  ),
                ),
                Center(
                    child: Column(
                  children: [
                    Text(
                      "K-mean cluster ",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w500,
                          fontSize: 50),
                    ),
                    Text(
                      "Semua data kelas",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  ],
                )),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    padding: EdgeInsets.all(20.0),
                    child: FittedBox(
                      child: DataTable(columns: [
                        DataColumn(
                          label: Text('Kode'),
                        ),
                        DataColumn(
                          label: Text('Nama'),
                        ),
                        DataColumn(
                          label: Text('Mahasisswa'),
                        ),
                        DataColumn(
                          label: Text('Dosen'),
                        ),
                        DataColumn(
                          label: Text('Matakuliah'),
                        ),
                      ], rows: [
                        for (var item in dataKelas)
                          DataRow(cells: [
                            DataCell(Text(item['kode_kelas'])),
                            DataCell(Text(item['nama_kelas'])),
                            DataCell(Text(item['mahasiswa']['name'])),
                            DataCell(Text(item['dosen']['name'])),
                            DataCell(
                                Text(item['matakuliah']['nama_matakuliah'])),
                          ])
                      ]),
                    ))
              ],
            ),
          ),
        )
      ],
    ));
  }
}
