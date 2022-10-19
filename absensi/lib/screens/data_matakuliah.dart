import 'package:absensi/components/rounded_button.dart';
import 'package:absensi/components/rounded_input_field.dart';
import 'package:absensi/constant.dart';
import 'package:absensi/models/absen.dart';
import 'package:absensi/models/api_response.dart';
import 'package:absensi/repository.dart';
import 'package:absensi/screens/absen_user.dart';
import 'package:absensi/screens/login.dart';
import 'package:absensi/screens/routing.dart';
import 'package:absensi/screens/view_data_matakuliah.dart';
import 'package:absensi/services/user_service.dart';
import 'package:absensi/widget/bottom_nav_bar.dart';
import 'package:absensi/widget/logs_card.dart';
import 'package:absensi/widget/menu_card.dart';
import 'package:absensi/widget/search_bar.dart';
import 'package:absensi/widget/user_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DataMatakuliah extends StatefulWidget {
  @override
  _DataMatakuliahState createState() => _DataMatakuliahState();
}

class _DataMatakuliahState extends State<DataMatakuliah> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController txtKodeMatakuliah = TextEditingController();
  TextEditingController txtNamaMatakuliah = TextEditingController();
  bool loading = false;

  validation() {
    if (txtKodeMatakuliah.text.trim().isEmpty ||
        txtKodeMatakuliah.text.trim() == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('kode Matakuliah harus di isi !'),
        ),
      );
      return;
    }
    if (txtNamaMatakuliah.text.trim().isEmpty ||
        txtNamaMatakuliah.text.trim() == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('nama Matakuliah harus di isi !'),
        ),
      );
      return;
    } else {
      if (!mounted) return;
      setState(() {
        loading = true;
      });
      _simpanMatakuliah();
    }
  }

  void _simpanMatakuliah() async {
    ApiResponse response =
        await simpanMatakuliah(txtKodeMatakuliah.text, txtNamaMatakuliah.text);
    if (response.error == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('berhasil di simpan')));
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
          child: SingleChildScrollView(
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
                              builder: (context) => Routing()));
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
                        "Matakuliah",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500,
                            fontSize: 50),
                      ),
                      Text(
                        "data matakuliah",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ],
                  )),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Stack(
                    children: <Widget>[
                      SafeArea(
                          child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  margin: const EdgeInsets.only(
                                      top: 10.0, bottom: 20.0),
                                  child: Container()),
                              Column(
                                children: [
                                  SizedBox(height: 30),
                                  RoundedInputField(
                                    controller: txtKodeMatakuliah,
                                    hintText: "kode Matakuliah ",
                                    onChanged: (value) {},
                                  ),
                                  RoundedInputField(
                                    controller: txtNamaMatakuliah,
                                    hintText: "nama Matakuliah",
                                    onChanged: (value) {},
                                  ),
                                  loading
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : RoundedButton(
                                          text: "Simpan",
                                          press: () {
                                            validation();
                                          },
                                        ),
                                  RoundedButton(
                                    text: "Lihat",
                                    press: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ViewDataMatakuliah()));
                                    },
                                    color: kSecondColor,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
