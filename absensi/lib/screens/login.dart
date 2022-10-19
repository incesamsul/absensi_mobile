import 'package:absensi/components/already_have_an_account_check.dart';
import 'package:absensi/components/background.dart';
import 'package:absensi/components/rounded_button.dart';
import 'package:absensi/components/rounded_input_field.dart';
import 'package:absensi/components/rounded_password_field.dart';
import 'package:absensi/constant.dart';
import 'package:absensi/models/api_response.dart';
import 'package:absensi/models/user.dart';
import 'package:absensi/screens/home.dart';
import 'package:absensi/screens/routing.dart';
import 'package:absensi/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool loading = false;

  void loginUser() async {
    ApiResponse response = await login(txtEmail.text, txtPassword.text);
    if (response.error == null) {
      saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(user.id);
    await pref.setString('token', user.token ?? '');
    await pref.setInt('user_id', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Routing()), (route) => false);
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
    if (txtPassword.text.trim().isEmpty || txtPassword.text.trim() == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password harus di isi !'),
        ),
      );
      return;
    } else {
      if (!mounted) return;
      setState(() {
        loading = true;
      });
      loginUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                "assets/icons/present.svg",
                height: MediaQuery.of(context).size.height * 0.35,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                "MASUK",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: kBackgroundColor),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Aplikasi absensi",
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 1.5),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              RoundedInputField(
                controller: txtEmail,
                hintText: "Email Anda",
                onChanged: (value) {},
              ),
              RoundedPasswordField(
                controller: txtPassword,
                onChanged: (value) {},
              ),
              loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RoundedButton(
                      text: "MASUK",
                      press: () {
                        validation();
                      },
                    ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
