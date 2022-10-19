import 'dart:async';

import 'package:absensi/components/admin_menu.dart';
import 'package:absensi/components/dosen_menu.dart';
import 'package:absensi/constant.dart';
import 'package:absensi/models/api_response.dart';
import 'package:absensi/models/user.dart';
import 'package:absensi/repository.dart';
import 'package:absensi/screens/login.dart';
import 'package:absensi/screens/peserta_kelas.dart';
import 'package:absensi/services/user_service.dart';
import 'package:absensi/widget/absen_card.dart';
import 'package:absensi/widget/bottom_nav_bar.dart';
import 'package:absensi/widget/menu_card.dart';
import 'package:absensi/widget/search_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class Absensi extends StatefulWidget {
  Absensi({
    Key? key,
    required this.kode_kelas,
    required this.id_user,
  }) : super(key: key);

  final String kode_kelas;
  final String id_user;

  @override
  _AbsensiState createState() => _AbsensiState();
}

class _AbsensiState extends State<Absensi> {
  bool loading = false;
  void _saveAbsen(String id, String status, String icon) async {
    ApiResponse response = await simpanAbsen(
        id, status, icon, _dateString, _timeString, widget.kode_kelas);
    if (response.error == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.data.toString())));
      setState(() {
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

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

  List dataAbsen = [];

  Repository repository = Repository();

  getData() async {
    int idUser = await getUserId();
    print("iduser: " + idUser.toString());
    if (idUser == '') {
    } else {
      dataAbsen = await repository.cekAbsen(
          widget.id_user, _dateString, widget.kode_kelas);
      setState(() {});
    }
  }

  @override
  void initState() {
    getData();
    _timeString = _formatTime(DateTime.now());
    _dateString = _formatDate(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  Future refresh() async {
    setState(() {});
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    String status = '';
    for (var item in dataAbsen) status = item['status'];
    print(status);
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
                            builder: (context) => PesertaKelas(
                                  kode_kelas: widget.kode_kelas,
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
                      _timeString,
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w500,
                          fontSize: 70),
                    ),
                    Text(
                      _dateString,
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  ],
                )),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Expanded(
                    child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: .85,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: <Widget>[
                    AbsenCard(
                      bg: status == 'hadir' ? Colors.greenAccent : Colors.white,
                      color: status == 'hadir' ? Colors.white : Colors.green,
                      title: 'Hadir',
                      icon: Icons.account_balance_outlined,
                      press: () {
                        _saveAbsen(widget.id_user, 'hadir',
                            'Icons.account_balance_outlined');
                      },
                    ),
                    AbsenCard(
                      bg: status == 'alfa' ? Colors.greenAccent : Colors.white,
                      color: status == 'alfa' ? Colors.white : Colors.red,
                      title: 'Alfa',
                      icon: Icons.no_backpack,
                      press: () {
                        _saveAbsen(widget.id_user, 'alfa', 'Icons.no_backpack');
                      },
                    ),
                    AbsenCard(
                      bg: status == 'sakit' ? Colors.greenAccent : Colors.white,
                      color: status == 'sakit' ? Colors.white : Colors.purple,
                      title: 'Sakit',
                      icon: Icons.sick,
                      press: () {
                        _saveAbsen(widget.id_user, 'sakit', 'Icons.sick');
                      },
                    ),
                    AbsenCard(
                      bg: status == 'izin' ? Colors.greenAccent : Colors.white,
                      color: status == 'izin' ? Colors.white : Colors.yellow,
                      title: 'Izin',
                      icon: Icons.party_mode,
                      press: () {
                        _saveAbsen(widget.id_user, 'izin', 'Icons.party_mode');
                      },
                    )
                  ],
                )),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
