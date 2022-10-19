<?php

namespace App\Http\Controllers;

use App\Models\AbsensiModel;
use Illuminate\Http\Request;

class AbsensiController extends Controller
{

    public function absen($id)
    {
        return response([
            'absen' => AbsensiModel::where('id_user', $id)->get()
        ], 200);
    }

    public function absenCheck($id, $tgl, $kode)
    {
        return response([
            'absen' => AbsensiModel::where('id_user', $id)->where('tgl', $tgl)->where('kode_kelas', $kode)->get()
        ], 200);
    }

    public function absenAll()
    {
        return response([
            'absen' => AbsensiModel::all()
        ], 200);
    }

    public function saveAbsen(Request $request)
    {
        $attrs = $request->validate([
            'status' => 'required|string',
            'tgl' => 'required|string',
            'jam' => 'required|string',
        ]);

        $cekAabsen = AbsensiModel::where('kode_kelas', $request->kode_kelas)->where('id_user', $request->id_user)->where('tgl', $attrs['tgl'])->first();

        if (!$cekAabsen) {
            $absen = AbsensiModel::create([
                'id_user' => $request->id_user,
                'status' => $attrs['status'],
                'tgl' => $attrs['tgl'],
                'jam' => $attrs['jam'],
                'icon' => $request->icon,
                'kode_kelas' => $request->kode_kelas,
            ]);
            $message = 'absen berhasil di lakukan';
        } else {
            $absen = [];
            $message = 'anda sudah melakukan absen hari ini';
        }

        return response([
            'absen' => $absen,
            'message' => $message
        ], 200);
    }
}
