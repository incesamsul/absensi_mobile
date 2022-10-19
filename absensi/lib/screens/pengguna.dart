import 'package:absensi/components/rounded_button.dart';
import 'package:absensi/components/rounded_input_field.dart';
import 'package:absensi/constant.dart';
import 'package:absensi/models/api_response.dart';
import 'package:absensi/models/user.dart';
import 'package:absensi/repository.dart';
import 'package:absensi/screens/view_data_user.dart';
import 'package:absensi/services/user_service.dart';
import 'package:absensi/widget/bottom_nav_bar.dart';
import 'package:absensi/widget/navbar.dart';
import 'package:absensi/widget/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Pengguna extends StatefulWidget {
  @override
  _PenggunaState createState() => _PenggunaState();
}

class _PenggunaState extends State<Pengguna> {
  List<User> dataUser = [];

  Repository repository = Repository();
  int idUser = 0;
  getData() async {
    idUser = await getUserId();
    print(idUser);
    if (idUser == '') {
      print('no id');
    } else {}
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future refresh() async {
    setState(() {
      dataUser = getData();
    });
  }

  validation() {
    if (txtEmail.text.trim().isEmpty || txtEmail.text.trim() == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email harus di isi !'),
        ),
      );
      return;
    }
    if (txtno_hp.text.trim().isEmpty || txtno_hp.text.trim() == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('no hp di isi !'),
        ),
      );
      return;
    }
    if (txtalamat.text.trim().isEmpty || txtalamat.text.trim() == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('alamat di isi !'),
        ),
      );
      return;
    }
    if (txtNama.text.trim().isEmpty || txtNama.text.trim() == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('nama harus di isi !'),
        ),
      );
      return;
    } else {
      if (!mounted) return;
      setState(() {
        loading = true;
      });
      _updatePengguna();
    }
  }

  void _updatePengguna() async {
    ApiResponse response = await updateUser(txtNama.text, txtEmail.text,
        txtno_hp.text, txtalamat.text, _selectedRole);
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

  bool loading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController txtNama = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtno_hp = TextEditingController();
  TextEditingController txtalamat = TextEditingController();

  List<String> role = ['Pilih role', 'mahasiswa', 'dosen']; // Option 2
  String _selectedRole = 'Pilih role';

  @override
  Widget build(BuildContext context) {
    print(dataUser.toList());
    return Scaffold(
        drawer: Navbar(
          id: 1,
          name: 'what',
          role: '',
        ),
        appBar: AppBar(
          title: Text('Pengguna'),
          backgroundColor: kActiveIconColor,
        ),
        body: Stack(
          children: <Widget>[
            SafeArea(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                        child: Container()),
                    Column(
                      children: [
                        Text(
                          'Manajemen pengguna',
                          style: TextStyle(
                              color: kMainColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        ),
                        SizedBox(height: 30),
                        RoundedInputField(
                          controller: txtNama,
                          hintText: "nama ",
                          onChanged: (value) {},
                        ),
                        RoundedInputField(
                          controller: txtEmail,
                          hintText: "email",
                          onChanged: (value) {},
                        ),
                        RoundedInputField(
                          controller: txtno_hp,
                          hintText: "no_hp",
                          onChanged: (value) {},
                        ),
                        RoundedInputField(
                          controller: txtalamat,
                          hintText: "alamat",
                          onChanged: (value) {},
                        ),
                        DropdownButton(
                          hint: Text(
                              'Please choose a location'), // Not necessary for Option 1
                          value: _selectedRole,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedRole = newValue.toString();
                            });
                          },
                          items: role.map((location) {
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
                          color: kSecondColor,
                          press: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ViewDataUser()));
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ))
          ],
        ));
  }
}
