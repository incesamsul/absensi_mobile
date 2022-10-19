import 'package:absensi/constant.dart';
import 'package:absensi/repository.dart';
import 'package:absensi/screens/about.dart';
import 'package:absensi/screens/home.dart';
import 'package:absensi/screens/login.dart';
import 'package:absensi/screens/logs.dart';
import 'package:absensi/services/user_service.dart';
import 'package:absensi/widget/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class Routing extends StatefulWidget {
  @override
  _RoutingState createState() => _RoutingState();
}

class _RoutingState extends State<Routing> {
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
    super.initState();
  }

  Future refresh() async {
    setState(() {});
  }

  @override
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    String name = '';

    String role = '';
    for (var item in dataUser) {
      name = item['name'];
      role = item['role'];
    }
    print(role);
    Widget child = Container();
    print(dataUser);
    switch (_index) {
      case 0:
        child = Home();
        break;

      case 1:
        child = role == 'admin' ? About() : About();
        break;
    }

    return Scaffold(
      bottomNavigationBar: _bottomTab(role),
      body: SizedBox.expand(child: child),
    );
  }

  Widget _bottomTab(String role) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting, // Shifting
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      currentIndex: _index,
      onTap: (int index) => setState(() => _index = index),
      items: role == 'admin'
          ? [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: kMainColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.info),
                label: 'About',
                backgroundColor: kSecondColor,
              ),
            ]
          : [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Absensi',
                backgroundColor: kMainColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.info),
                label: 'About',
                backgroundColor: kSecondColor,
              ),
            ],
    );
  }
}
