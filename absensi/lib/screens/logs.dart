import 'package:absensi/constant.dart';
import 'package:absensi/models/absen.dart';
import 'package:absensi/repository.dart';
import 'package:absensi/screens/login.dart';
import 'package:absensi/services/user_service.dart';
import 'package:absensi/widget/bottom_nav_bar.dart';
import 'package:absensi/widget/logs_card.dart';
import 'package:absensi/widget/menu_card.dart';
import 'package:absensi/widget/search_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logs extends StatefulWidget {
  @override
  _LogsState createState() => _LogsState();
}

class _LogsState extends State<Logs> {
  List dataAbsen = [];

  Repository repository = Repository();
  getData() async {
    int idUser = await getUserId();
    print(idUser);
    if (idUser == '') {
      print('no id');
    } else {
      dataAbsen = await repository.getAbsen(idUser);
      setState(() {});
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future refresh() async {
    setState(() {
      dataAbsen = getData();
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
                      "LOGS ",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w500,
                          fontSize: 70),
                    ),
                    Text(
                      "log absensi pengguna",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  ],
                )),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var item in dataAbsen)
                      LogsCard(
                        status: item['status'],
                        tgl: item['tgl'],
                        jam: item['jam'],
                        svgSrc: item['icon'],
                        press: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                      ),
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
