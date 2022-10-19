import 'dart:async';

import 'package:absensi/components/admin_menu.dart';
import 'package:absensi/components/dosen_menu.dart';
import 'package:absensi/constant.dart';
import 'package:absensi/models/api_response.dart';
import 'package:absensi/models/user.dart';
import 'package:absensi/repository.dart';
import 'package:absensi/screens/login.dart';
import 'package:absensi/services/user_service.dart';
import 'package:absensi/widget/bottom_nav_bar.dart';
import 'package:absensi/widget/menu_card.dart';
import 'package:absensi/widget/search_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

  List dataUser = [];

  Repository repository = Repository();

  getData() async {
    int idUser = await getUserId();
    print("iduser: " + idUser.toString());
    if (idUser == '') {
    } else {
      dataUser = await repository.getUserData(idUser);
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
    String name = '';

    String role = '';
    for (var item in dataUser) {
      name = item['name'];
      role = item['role'];
    }

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
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Login()));
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
                Expanded(child: role == 'dosen' ? DosenMenu() : AdminMenu()),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
