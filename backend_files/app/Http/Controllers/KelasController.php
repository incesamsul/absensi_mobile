<?php

namespace App\Http\Controllers;

use App\Models\KelasModel;
use App\Models\MatakuliahModel;
use App\Models\User;
use Illuminate\Http\Request;

class KelasController extends Controller
{

    public function kelas()
    {
        return response([
            'kelas' => KelasModel::with('mahasiswa')->with('dosen')->with('matakuliah')->get()
        ], 200);
    }

    public function kelasPerDosen($id)
    {
        return response([
            'kelas' => KelasModel::where('id_dosen', $id)->groupBy('kode_kelas')->with('mahasiswa')->with('dosen')->with('matakuliah')->get()
        ], 200);
    }

    public function pesertaKelas($kode)
    {
        return response([
            'kelas' => KelasModel::where('kode_kelas', $kode)->with('mahasiswa')->get()
        ], 200);
    }

    public function saveKelas(Request $request)
    {
        $attrs = $request->validate([
            'kode_kelas' => 'required|string',
            'nama_kelas' => 'required|string',
        ]);

        $idMhs = User::where('name', $request->mahasiswa)->first()->id;
        $idDosen = User::where('name', $request->dosen)->first()->id;
        $idMatakuliah = MatakuliahModel::where('nama_matakuliah', $request->matakuliah)->first()->id_matakuliah;
        $cekKelas = KelasModel::where('kode_kelas', $request->kode_kelas)->where('nama_kelas', $attrs['nama_kelas'])->where('id_mahasiswa', $idMhs)->first();

        if (!$cekKelas) {
            $kelas = KelasModel::create([
                'kode_kelas' => $attrs['kode_kelas'],
                'nama_kelas' => $attrs['nama_kelas'],
                'id_mahasiswa' => $idMhs,
                'id_dosen' => $idDosen,
                'id_matakuliah' => $idMatakuliah,
            ]);
            $message = 'kelas berhasil di lakukan';
        } else {
            $kelas = [];
            $message = 'anda sudah melakukan kelas hari ini';
        }

        return response([
            'kelas' => $kelas,
            'message' => $message
        ], 200);
    }
}
