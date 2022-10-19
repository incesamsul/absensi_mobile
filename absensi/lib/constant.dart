// const baseURL = 'http://127.0.0.1:8000/api';
import 'package:flutter/material.dart';

const basePath = 'http://10.42.0.252:8000';
const baseURL = 'http://10.42.0.252:8000/api';
const loginURL = baseURL + '/login';
const updateProfileURL = baseURL + '/update_profile';
const saveAbsenURL = baseURL + '/save_absen';
const simpanKelasURL = baseURL + '/save_kelas';
const simpanMatakuliahURL = baseURL + '/save_matakuliah';
const registerURL = baseURL + '/register';
const logoutURL = baseURL + '/logout';
const userURL = baseURL + '/user';
const mahasiswaURL = baseURL + '/mahasiswa';
const dosenURL = baseURL + '/dosen';
const kelasURL = baseURL + '/kelas';
const kelasPerDosenURL = baseURL + '/kelas_per_dosen';
const pesertaKelasURL = baseURL + '/peserta_kelas';
const cekAbsenURL = baseURL + '/absen_check';
const matakuliahURL = baseURL + '/matakuliah';
const absenURL = baseURL + '/absen';

const serverError = 'server error';
const unauthorized = 'unauthorized';
const somethingWengWrong = 'ada yang salah';

InputDecoration kInputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    contentPadding: EdgeInsets.all(8.0),
  );
}

TextButton kTextButton(String label, Function onPressed) {
  return TextButton(
    child: Text(label, style: TextStyle(color: Colors.white)),
    style: ButtonStyle(
      backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue),
      padding: MaterialStateProperty.resolveWith(
        (states) => EdgeInsets.symmetric(vertical: 10),
      ),
    ),
    onPressed: () => onPressed(),
  );
}

Row kLoginRegisterHind(String text, String label, Function onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text),
      GestureDetector(
        child: Text(label, style: TextStyle(color: Colors.blue)),
        onTap: () => onTap(),
      )
    ],
  );
}

const kBackgroundColor = Color(0xFFF8F8F8);
const kMainColor = Color.fromARGB(255, 6, 53, 71);
const kSecondColor = Color.fromARGB(185, 6, 53, 71);
const kActiveIconColor = Color.fromARGB(255, 6, 53, 71);
const kTextColor = Color.fromARGB(185, 6, 53, 71);
const kBlueLightColor = Color(0xFFC7B8F5);
const kBlueColor = Color(0xFF817DC0);
const kShadowColor = Color(0xFFE6E6E6);
