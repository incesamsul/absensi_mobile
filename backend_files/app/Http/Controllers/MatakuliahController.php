<?php

namespace App\Http\Controllers;


use App\Models\MatakuliahModel;
use Illuminate\Http\Request;

class MatakuliahController extends Controller
{

    public function matakuliah()
    {
        return response([
            'matakuliah' => MatakuliahModel::all()
        ], 200);
    }

    public function saveMatakuliah(Request $request)
    {
        $attrs = $request->validate([
            'kode_matakuliah' => 'required|string',
            'nama_matakuliah' => 'required|string',
        ]);

        $cekMatakuliah = MatakuliahModel::where('kode_matakuliah', $request->kode_matakuliah)->where('nama_matakuliah', $attrs['nama_matakuliah'])->first();

        if (!$cekMatakuliah) {
            $matakuliah = MatakuliahModel::create([
                'kode_matakuliah' => $attrs['kode_matakuliah'],
                'nama_matakuliah' => $attrs['nama_matakuliah'],
            ]);
            $message = 'matakuliah berhasil di lakukan';
        } else {
            $matakuliah = [];
            $message = 'Matakuliah ini sdah diinput sblmnya';
        }

        return response([
            'matakuliah' => $matakuliah,
            'message' => $message
        ], 200);
    }
}
