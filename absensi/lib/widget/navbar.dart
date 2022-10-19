import 'package:absensi/screens/login.dart';

import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  @override
  Widget drawerItem(
      {@required String? name,
      @required IconData? icon,
      @required Function()? tap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[600]),
      title: Text(name!, style: TextStyle(color: Colors.grey[600])),
      onTap: tap,
    );
  }

  final String name;
  final String role;
  final int id;
  Navbar({
    Key? key,
    required this.id,
    required this.name,
    required this.role,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        // color: Colors.grey[800],
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.grey[200]),
                accountName:
                    Text(name, style: TextStyle(color: Colors.grey[600])),
                accountEmail:
                    Text(role, style: TextStyle(color: Colors.grey[600])),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/main_top.png'),
                ),
              ),
              if (role == 'guru')
                drawerItem(
                    name: 'Kategori',
                    icon: Icons.category,
                    tap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Login()));
                    }),
              drawerItem(
                  name: 'Beranda',
                  icon: Icons.home,
                  tap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Login()));
                  }),
              drawerItem(
                  name: 'Profile',
                  icon: Icons.person,
                  tap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Login()));
                  }),
              Divider(
                thickness: 1,
                color: Colors.grey[600],
              ),
              Text("Pengaturan Pengguna",
                  style: TextStyle(color: Colors.grey[600])),
              drawerItem(name: 'Change', icon: Icons.lock, tap: () {}),
              drawerItem(
                  name: 'Logout',
                  icon: Icons.login,
                  tap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Login()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
