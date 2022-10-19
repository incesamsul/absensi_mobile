import 'package:absensi/constant.dart';
import 'package:absensi/models/absen.dart';
import 'package:absensi/repository.dart';
import 'package:absensi/screens/absen_user.dart';
import 'package:absensi/screens/absensi.dart';
import 'package:absensi/screens/data_absen.dart';
import 'package:absensi/screens/login.dart';
import 'package:absensi/services/user_service.dart';
import 'package:absensi/widget/bottom_nav_bar.dart';
import 'package:absensi/widget/logs_card.dart';
import 'package:absensi/widget/menu_card.dart';
import 'package:absensi/widget/peserta_card.dart';
import 'package:absensi/widget/search_bar.dart';
import 'package:absensi/widget/user_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class PesertaKelas extends StatefulWidget {
  PesertaKelas({Key? key, required this.kode_kelas}) : super(key: key);

  final String kode_kelas;

  @override
  _PesertaKelasState createState() => _PesertaKelasState();
}

class _PesertaKelasState extends State<PesertaKelas> {
  late String _timeString;
  late String _dateString;

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedTime = _formatTime(now);
    final String formattedDate = _formatDate(now);
    setState(() {
      _timeString = formattedTime;
      _dateString = formattedDate;
    });
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('hh:mm').format(dateTime);
  }

  String _formatDate(DateTime dateTime) {
    return DateFormat('E, dd MMMM yy').format(dateTime);
  }

  List dataKelas = [];
  List dataAbsen = [];
  List cekAbsen = [];

  Repository repository = Repository();
  getData() async {
    dataKelas = await repository.getPesertaKelas(widget.kode_kelas);
    for (var item in dataKelas) {
      dataAbsen = await repository.cekAbsen(
          item['id_mahasiswa'].toString(), _dateString, widget.kode_kelas);
      cekAbsen.add(dataAbsen.length);
    }
    setState(() {});
  }

  @override
  void initState() {
    getData();
    _timeString = _formatTime(DateTime.now());
    _dateString = _formatDate(DateTime.now());
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    print(cekAbsen);

    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          // Here the height of the container is 45% of our total height
          height: MediaQuery.of(context).size.height * .33,
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AbsenUser(
                                  id_user: 1.toString(),
                                )));
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
                      "Peserta kelas ",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w500,
                          fontSize: 50),
                    ),
                    Text(
                      "presensi mahasiswa",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  ],
                )),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                for (var item in dataKelas)
                  PesertaCard(
                      icon: Icons.supervised_user_circle,
                      status: item['mahasiswa']['name'],
                      tgl: '',
                      jam: '',
                      color: cekAbsen[dataKelas.indexWhere(((data) =>
                                  data['id_mahasiswa'] ==
                                  item['id_mahasiswa']))] ==
                              1
                          ? Colors.greenAccent
                          : Colors.white,
                      press: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Absensi(
                                  kode_kelas: item['kode_kelas'],
                                  id_user: item['id_mahasiswa'].toString(),
                                )));
                      })
              ],
            ),
          ),
        )
      ],
    ));
  }
}
