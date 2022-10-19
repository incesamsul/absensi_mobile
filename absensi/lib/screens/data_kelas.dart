import 'package:absensi/components/rounded_button.dart';
import 'package:absensi/components/rounded_input_field.dart';
import 'package:absensi/constant.dart';
import 'package:absensi/models/absen.dart';
import 'package:absensi/models/api_response.dart';
import 'package:absensi/repository.dart';
import 'package:absensi/screens/absen_user.dart';
import 'package:absensi/screens/login.dart';
import 'package:absensi/screens/routing.dart';
import 'package:absensi/screens/view_data_kelas.dart';
import 'package:absensi/services/user_service.dart';
import 'package:absensi/widget/bottom_nav_bar.dart';
import 'package:absensi/widget/logs_card.dart';
import 'package:absensi/widget/menu_card.dart';
import 'package:absensi/widget/search_bar.dart';
import 'package:absensi/widget/user_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DataKelas extends StatefulWidget {
  @override
  _DataKelasState createState() => _DataKelasState();
}

class _DataKelasState extends State<DataKelas> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController txtKodeKelas = TextEditingController();
  TextEditingController txtNamaKelas = TextEditingController();
  bool loading = false;

  validation() {
    if (txtKodeKelas.text.trim().isEmpty || txtKodeKelas.text.trim() == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('kode kelas harus di isi !'),
        ),
      );
      return;
    }
    if (txtNamaKelas.text.trim().isEmpty || txtNamaKelas.text.trim() == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('nama kelas harus di isi !'),
        ),
      );
      return;
    } else {
      if (!mounted) return;
      setState(() {
        loading = true;
      });
      _simpanKelas();
    }
  }

  void _simpanKelas() async {
    ApiResponse response = await simpanKelas(
        txtKodeKelas.text,
        txtNamaKelas.text,
        _selectedMahasiswa,
        _selectedDosen,
        _selectedMatakuliah);
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

  List dataMahasiswa = [];
  List dataDosen = [];
  List dataMatakuliah = [];

  Repository repository = Repository();
  getData() async {
    dataMahasiswa = await repository.getMahasiswa();
    dataDosen = await repository.getDosen();
    dataMatakuliah = await repository.getAllMatakuliah();
    setState(() {
      for (var item in dataMahasiswa) _mahasiswa.add(item['name']);
      for (var item in dataDosen) _dosen.add(item['name']);
      for (var item in dataMatakuliah) _matakuliah.add(item['nama_matakuliah']);
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  List<String> _matakuliah = ['Pilih matakuliah']; // Option 2
  String _selectedMatakuliah = 'Pilih matakuliah';

  List<String> _dosen = ['Pilih dosen']; // Option 2
  String _selectedDosen = 'Pilih dosen';

  List<String> _mahasiswa = ['Pilih mahasiswa']; // Option 2
  String _selectedMahasiswa = 'Pilih mahasiswa';

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
                        "DataKelas ",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500,
                            fontSize: 50),
                      ),
                      Text(
                        "Manajemen kelas",
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
                                    controller: txtKodeKelas,
                                    hintText: "kode kelas ",
                                    onChanged: (value) {},
                                  ),
                                  RoundedInputField(
                                    controller: txtNamaKelas,
                                    hintText: "nama kelas",
                                    onChanged: (value) {},
                                  ),
                                  DropdownButton(
                                    hint: Text(
                                        'Please choose a location'), // Not necessary for Option 1
                                    value: _selectedMahasiswa,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedMahasiswa =
                                            newValue.toString();
                                      });
                                    },
                                    items: _mahasiswa.map((location) {
                                      return DropdownMenuItem(
                                        child: new Text(location),
                                        value: location,
                                      );
                                    }).toList(),
                                  ),
                                  SizedBox(height: 10),
                                  DropdownButton(
                                    hint: Text(
                                        'Please choose a location'), // Not necessary for Option 1
                                    value: _selectedDosen,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedDosen = newValue.toString();
                                      });
                                    },
                                    items: _dosen.map((location) {
                                      return DropdownMenuItem(
                                        child: new Text(location),
                                        value: location,
                                      );
                                    }).toList(),
                                  ),
                                  DropdownButton(
                                    hint: Text(
                                        'Please choose a location'), // Not necessary for Option 1
                                    value: _selectedMatakuliah,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedMatakuliah =
                                            newValue.toString();
                                      });
                                    },
                                    items: _matakuliah.map((location) {
                                      return DropdownMenuItem(
                                        child: new Text(location),
                                        value: location,
                                      );
                                    }).toList(),
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
                                                  ViewDataKelas()));
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
