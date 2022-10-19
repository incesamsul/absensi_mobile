import 'dart:convert';

import 'package:absensi/constant.dart';
import 'package:absensi/models/api_response.dart';
import 'package:absensi/models/user.dart';
import 'package:absensi/services/user_service.dart';
import 'package:http/http.dart' as http;

class Repository {
  Future getUserData(id) async {
    String strId = '/' + id.toString();
    try {
      final response = await http.get(Uri.parse(userURL + strId));
      if (response.statusCode == 200) {
        // Iterable it = jsonDecode(response.body);
        // List<User> user = it.map((e) => User.fromJson(e)).toList();
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["user"];
        return data;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getAbsen(id) async {
    String strId = '/' + id.toString();
    try {
      final response = await http.get(Uri.parse(absenURL + strId));
      if (response.statusCode == 200) {
        // Iterable it = jsonDecode(response.body);
        // List<User> user = it.map((e) => User.fromJson(e)).toList();
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["absen"];
        return data;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getAllUser() async {
    try {
      final response = await http.get(Uri.parse(userURL));
      if (response.statusCode == 200) {
        // Iterable it = jsonDecode(response.body);
        // List<User> user = it.map((e) => User.fromJson(e)).toList();
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["user"];
        return data;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getMahasiswa() async {
    try {
      final response = await http.get(Uri.parse(mahasiswaURL));
      if (response.statusCode == 200) {
        // Iterable it = jsonDecode(response.body);
        // List<User> user = it.map((e) => User.fromJson(e)).toList();
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["mahasiswa"];
        return data;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getDosen() async {
    try {
      final response = await http.get(Uri.parse(dosenURL));
      if (response.statusCode == 200) {
        // Iterable it = jsonDecode(response.body);
        // List<User> user = it.map((e) => User.fromJson(e)).toList();
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["dosen"];
        return data;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getAllKelas() async {
    try {
      final response = await http.get(Uri.parse(kelasURL));
      if (response.statusCode == 200) {
        // Iterable it = jsonDecode(response.body);
        // List<User> user = it.map((e) => User.fromJson(e)).toList();
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["kelas"];
        return data;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getKelasPerDosen(id) async {
    try {
      String strId = '/' + id.toString();
      final response = await http.get(Uri.parse(kelasPerDosenURL + strId));
      if (response.statusCode == 200) {
        // Iterable it = jsonDecode(response.body);
        // List<User> user = it.map((e) => User.fromJson(e)).toList();
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["kelas"];
        return data;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getPesertaKelas(kode) async {
    try {
      String kodeStr = '/' + kode;
      final response = await http.get(Uri.parse(pesertaKelasURL + kodeStr));
      if (response.statusCode == 200) {
        // Iterable it = jsonDecode(response.body);
        // List<User> user = it.map((e) => User.fromJson(e)).toList();
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["kelas"];
        return data;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future cekAbsen(id, tgl, kode_kelas) async {
    try {
      String param = '/' + id + '/' + tgl + '/' + kode_kelas;
      final response = await http.get(Uri.parse(cekAbsenURL + param));
      if (response.statusCode == 200) {
        // Iterable it = jsonDecode(response.body);
        // List<User> user = it.map((e) => User.fromJson(e)).toList();
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["absen"];
        return data;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getAllMatakuliah() async {
    try {
      final response = await http.get(Uri.parse(matakuliahURL));
      if (response.statusCode == 200) {
        // Iterable it = jsonDecode(response.body);
        // List<User> user = it.map((e) => User.fromJson(e)).toList();
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["matakuliah"];
        return data;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

// END FO REPO CLASS

// Update user
Future<ApiResponse> updateUser(
    String name, String email, String no_hp, String alamat, String role) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response =
        await http.post(Uri.parse(updateProfileURL.toString()), headers: {
      'Accept': 'application/json',
    }, body: {
      'name': name,
      'email': email,
      'no_hp': no_hp,
      'alamat': alamat,
      'role': role,
    });
    // user can update his/her name or name and ilustrasi_kategori

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWengWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = e.toString();
  }
  return apiResponse;
}

// simpan absen
Future<ApiResponse> simpanAbsen(String id, String status, String icon,
    String tgl, String jam, String kode_kelas) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    int userId = await getUserId();
    final response =
        await http.post(Uri.parse(saveAbsenURL.toString()), headers: {
      'Accept': 'application/json',
    }, body: {
      'id_user': id,
      'status': status,
      'icon': icon,
      'tgl': tgl,
      'jam': jam,
      'kode_kelas': kode_kelas,
    });
    // user can update his/her name or name and ilustrasi_kategori

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWengWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = e.toString();
  }
  return apiResponse;
}

// simpan kelas
Future<ApiResponse> simpanKelas(String kode_kelas, String nama_kelas,
    String mahasiswa, String dosen, String matakuliah) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response =
        await http.post(Uri.parse(simpanKelasURL.toString()), headers: {
      'Accept': 'application/json',
    }, body: {
      'kode_kelas': kode_kelas,
      'nama_kelas': nama_kelas,
      'mahasiswa': mahasiswa,
      'dosen': dosen,
      'matakuliah': matakuliah,
    });
    // user can update his/her name or name and ilustrasi_kategori

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        print(response.body);
        apiResponse.error = somethingWengWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = e.toString();
  }
  return apiResponse;
}

// simpan Matakuliah
Future<ApiResponse> simpanMatakuliah(
    String kode_matakuliah, String nama_matakuliah) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response =
        await http.post(Uri.parse(simpanMatakuliahURL.toString()), headers: {
      'Accept': 'application/json',
    }, body: {
      'kode_matakuliah': kode_matakuliah,
      'nama_matakuliah': nama_matakuliah,
    });
    // user can update his/her name or name and ilustrasi_kategori

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWengWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = e.toString();
  }
  return apiResponse;
}
