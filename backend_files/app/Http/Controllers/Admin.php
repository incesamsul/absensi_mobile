<?php

namespace App\Http\Controllers;

use App\Models\InfoModel;
use App\Models\KategoriModel;
use App\Models\KritikSaranModel;
use App\Models\KuisionerModel;
use App\Models\Musik;
use App\Models\PenilaianModel;
use App\Models\ProfileUserModel;
use App\Models\SoalEssay;
use App\Models\SoalEvaluasi;
use App\Models\SubInfo;
use App\Models\User;
use App\Models\Video;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;


class Admin extends Controller
{

    protected $userModel;
    protected $profileUserModel;
    protected $kritikSaranModel;
    protected $kuisionerModel;
    protected $penilaianModel;


    public function __construct()
    {
        $this->userModel = new User();
    }

    public function pengguna()
    {
        $data['pengguna'] = $this->userModel->getAllUser();
        return view('pages.pengguna.index', $data);
    }

    public function info($idKategori, $idInfo = null)
    {
        $data['info'] = InfoModel::where('id_kategori', $idKategori)->get();
        $data['jenis_informasi'] = getNamaKategoriById($idKategori)->nama_kategori;
        $data['id_kategori'] = $idKategori;
        $data['edit'] = [];
        if ($idInfo) {
            $data['edit'] = InfoModel::where('id_info', $idInfo)->first();
        }
        return view('pages.info.main', $data);
    }

    public function subInfo($idInfo, $idSubInfo = null)
    {
        $data['sub_info'] = SubInfo::where('id_info', $idInfo)->get();
        $data['jenis_informasi'] = getNamaInfoById($idInfo)->judul_info;
        $data['id_info'] = $idInfo;
        $data['edit'] = [];
        if ($idSubInfo) {
            $data['edit'] = SubInfo::where('id_sub_info', $idSubInfo)->first();
        }
        return view('pages.sub_info.main', $data);
    }

    public function kategori($idKategori = null)
    {
        $data['edit'] = [];
        if ($idKategori) {
            $data['edit'] = KategoriModel::where('id_kategori', $idKategori)->first();
        }
        $data['kategori'] = KategoriModel::all();
        return view('pages.info.kategori', $data);
    }

    public function video()
    {
        $data['video'] = Video::all();
        return view('pages.video.index', $data);
    }

    public function musik()
    {
        $data['musik'] = Musik::all();
        return view('pages.music.index', $data);
    }

    public function evaluasi($idSoalEvaluasi = null)
    {
        $data['edit'] = [];
        if ($idSoalEvaluasi) {
            $data['edit'] = SoalEvaluasi::where('id_soal_evaluasi', $idSoalEvaluasi)->first();
        }
        $data['soal'] = SoalEvaluasi::all();
        return view('pages.evaluasi.index', $data);
    }

    public function evaluasiEssay($idSoalEssay = null)
    {
        $data['edit'] = [];
        if ($idSoalEssay) {
            $data['edit'] = SoalEssay::where('id_soal_essay', $idSoalEssay)->first();
        }
        $data['soal'] = SoalEssay::all();
        return view('pages.evaluasi.essay', $data);
    }

    public function deleteSoal(Request $request)
    {
        SoalEvaluasi::where('id_soal_evaluasi', $request->id_data)->delete();
        return 1;
    }

    public function deleteSoalEssay(Request $request)
    {
        SoalEssay::where('id_soal_essay', $request->id_data)->delete();
        return 1;
    }

    public function createSoal(Request $request)
    {
        if ($request->id_soal_evaluasi) {
            SoalEvaluasi::where('id_soal_evaluasi', $request->id_soal_evaluasi)->update([
                'soal' => $request->soal,
                'a' => $request->jawaban_a,
                'b' => $request->jawaban_b,
                'c' => $request->jawaban_c,
                'd' => $request->jawaban_d,
                'jawaban' => $request->jawaban_benar,
                'pembahasan' => $request->pembahasan,
            ]);
        } else {
            SoalEvaluasi::create([
                'soal' => $request->soal,
                'a' => $request->jawaban_a,
                'b' => $request->jawaban_b,
                'c' => $request->jawaban_c,
                'd' => $request->jawaban_d,
                'jawaban' => $request->jawaban_benar,
                'pembahasan' => $request->pembahasan,
            ]);
        }


        return redirect()->back()->with('message', 'berhasil menambah soal');
    }

    public function createSoalEssay(Request $request)
    {
        if ($request->id_soal_essay) {
            SoalEssay::where('id_soal_essay', $request->id_soal_essay)->update([
                'soal' => $request->soal,
            ]);
        } else {
            SoalEssay::create([
                'soal' => $request->soal,
            ]);
        }


        return redirect()->back()->with('message', 'berhasil menambah soal');
    }

    public function hapusInfo(Request $request)
    {
        InfoModel::where('id_info', $request->id_info)->delete();
        return 1;
    }

    public function hapusSubInfo(Request $request)
    {
        SubInfo::where('id_sub_info', $request->id_sub_info)->delete();
        return 1;
    }

    public function hapusKategori(Request $request)
    {
        KategoriModel::where('id_kategori', $request->id_kategori)->delete();
        return 1;
    }

    public function simpanInfo(Request $request)
    {
        if ($request->id_info) {
            if ($request->file('foto1')) {
                $foto1 = $request->file('foto1');
                $random = uniqid();
                InfoModel::where('id_info', $request->id_info)->update([
                    'judul_info' => $request->judul,
                    'foto1' => 'data/data_upload/info/' . $random . '/' . $random . '_.' . $foto1->extension(),
                    'foto2' => 'nothing',
                    'foto3' => 'nothing',
                    'deskripsi' => $request->deskripsi,
                ]);
                $this->uploadFile($foto1, $random, '', 'info');
                return redirect()->back()->with('message', 'file berhasil di simpan');
            } else {
                InfoModel::where('id_info', $request->id_info)->update([
                    'judul_info' => $request->judul,
                    'foto3' => 'nothing',
                    'deskripsi' => $request->deskripsi,
                ]);
                return redirect()->back()->with('message', 'file berhasil di simpan');
            }
        } else {
            $judul = str_replace(" ", "", $request->judul);
            $foto1 = $request->file('foto1');
            $foto2 = $request->file('foto2');
            $foto3 = $request->file('foto3');

            $random = uniqid();
            InfoModel::create([
                'id_kategori' => $request->kategori,
                'judul_info' => $request->judul,
                'foto1' => 'data/data_upload/info/' . $random . '/' . $random . '_.' . $foto1->extension(),
                'foto2' => 'nothing',
                'foto3' => 'nothing',
                'deskripsi' => $request->deskripsi,
            ]);

            $this->uploadFile($foto1, $random, '', 'info');
            // $this->uploadFile($foto2, 'foto2', $judul, 'info');
            // $this->uploadFile($foto3, 'foto3', $judul, 'info');

            return redirect()->back()->with('message', 'file berhasil di simpan');
        }
    }

    public function simpanSubInfo(Request $request)
    {
        if ($request->id_sub_info) {
            if ($request->file('foto1')) {
                $foto1 = $request->file('foto1');
                $random = uniqid();
                SubInfo::where('id_sub_info', $request->id_sub_info)->update([
                    'judul_sub_info' => $request->judul,
                    'foto1' => 'data/data_upload/info/' . $random . '/' . $random . '_.' . $foto1->extension(),
                    'deskripsi' => $request->deskripsi,
                ]);
                $this->uploadFile($foto1, $random, '', 'info');
                return redirect()->back()->with('message', 'file berhasil di simpan');
            } else {
                SubInfo::where('id_sub_info', $request->id_sub_info)->update([
                    'judul_sub_info' => $request->judul,
                    'deskripsi' => $request->deskripsi,
                ]);
                return redirect()->back()->with('message', 'file berhasil di simpan');
            }
        } else {
            $judul = str_replace(" ", "", $request->judul);
            $foto1 = $request->file('foto1');

            $random = uniqid();
            SubInfo::create([
                'id_info' => $request->info,
                'judul_sub_info' => $request->judul,
                'foto1' => 'data/data_upload/info/' . $random . '/' . $random . '_.' . $foto1->extension(),
                'deskripsi' => $request->deskripsi,
            ]);

            $this->uploadFile($foto1, $random, '', 'info');

            return redirect()->back()->with('message', 'file berhasil di simpan');
        }
    }

    public function simpanKategori(Request $request)
    {

        if ($request->id_kategori) {
            if ($request->file('foto1')) {
                $foto1 = $request->file('foto1');
                KategoriModel::where('id_kategori', $request->id_kategori)->update([
                    'nama_kategori' => $request->nama_kategori,
                    'ilustrasi_kategori' => 'data/data_upload/kategori/' . $request->nama_kategori . '/foto1/' . $this->generateUploadFileName('foto1', $request->nama_kategori, $foto1->extension()),
                    'deskripsi_kategori' => $request->deskripsi,
                ]);
                $this->uploadFile($foto1, 'foto1', $request->nama_kategori, 'kategori');
                return redirect()->back()->with('message', 'file berhasil di simpan');
            } else {
                KategoriModel::where('id_kategori', $request->id_kategori)->update([
                    'nama_kategori' => $request->nama_kategori,
                    'deskripsi_kategori' => $request->deskripsi,
                ]);
                return redirect()->back()->with('message', 'file berhasil di simpan');
            }
        } else {
            $foto1 = $request->file('foto1');

            KategoriModel::create([
                'nama_kategori' => $request->nama_kategori,
                'ilustrasi_kategori' => 'data/data_upload/kategori/' . $request->nama_kategori . '/foto1/' . $this->generateUploadFileName('foto1', $request->nama_kategori, $foto1->extension()),
                'deskripsi_kategori' => $request->deskripsi,
            ]);

            $this->uploadFile($foto1, 'foto1', $request->nama_kategori, 'kategori');
            return redirect()->back()->with('message', 'file berhasil di simpan');
        }
    }

    public function uploadFile($file, $ketFile, $judul, $folderUpload)
    {
        $file->move(public_path('data/data_upload/' . $folderUpload . '/' . $judul . '/' . $ketFile), $this->generateUploadFileName($ketFile, $judul, $file->extension()));
    }

    public function generateUploadFileName($ketGambar, $namaGambar, $ekstensi)
    {
        return $ketGambar  . '_' . $namaGambar . '.' . $ekstensi;
    }



    public function profileUser()
    {
        $data['user'] = User::all();
        $data['profile'] = $this->profileUserModel->getProfileUser();
        return view('pages.rekaptulasi_data.index', $data);
    }






    // fetch data user by admin
    function fetchData(Request $request)
    {
        if ($request->ajax()) {
            $sort_by = $request->get('sortby');
            $sort_type = $request->get('sorttype');
            $query = $request->get('query');
            $query = str_replace(" ", "%", $query);
            if ($request->filter == "") {
                $data['pengguna'] = DB::table('users')
                    ->where('role', '!=', 'Admin')
                    ->Where('name', 'like', '%' . $query . '%')
                    ->Where('email', 'like', '%' . $query . '%')
                    ->orderBy($sort_by, $sort_type)
                    ->paginate(5);
            } else {
                $data['pengguna'] = DB::table('users')
                    ->where('role', '!=', 'Admin')
                    ->Where('role', '=', $request->filter)
                    ->Where('name', 'like', '%' . $query . '%')
                    ->Where('email', 'like', '%' . $query . '%')
                    ->orderBy($sort_by, $sort_type)
                    ->paginate(5);
            }

            return view('pages.pengguna.users_data', $data)->render();
        }
    }

    public function createPengguna(Request $request)
    {
        User::create([
            'name' => $request->nama,
            'email' => $request->email,
            'password' => bcrypt($request->email),
            'role' => $request->tipe_pengguna,
        ]);
        return redirect('/admin/pengguna')->with('message', 'Pengguna Berhasil di tambahkan');
    }

    public function updatePengguna(Request $request)
    {
        $user = User::where([
            ['id', '=', $request->id]
        ])->first();
        $user->update([
            'name' => $request->nama,
            'email' => $request->email,
            'role' => $request->tipe_pengguna,
        ]);
        return redirect('/admin/pengguna')->with('message', 'Pengguna Berhasil di update');
    }

    public function deletePengguna(Request $request)
    {
        User::destroy($request->post('user_id'));
        return 1;
    }

    public function createMusik(Request $request)
    {
        $musik = $request->file('musik');
        $musikName = uniqid() . '.mp3';
        $path = public_path('data/musik');
        $musik->move($path . '/', $musikName);
        Musik::create([
            'judul' => $request->judul_musik,
            'musik' => 'data/musik/' . $musikName,
        ]);

        return redirect()->back()->with('message', 'tersimpan');
    }

    public function deleteMusik(Request $request)
    {
        Musik::where('id_musik', $request->id_musik)->delete();
        return 1;
    }

    public function createVideo(Request $request)
    {
        Video::create([
            'judul_video' => $request->judul_video,
            'kategori' => $request->kategori,
            'id_video_youtube' => $request->id_video_youtube,
        ]);
        return redirect()->back()->with('message', 'video Berhasil di tambahkan');
    }

    public function updateVideo(Request $request)
    {
        $user = Video::where([
            ['id', '=', $request->id]
        ])->first();
        $user->update([
            'nama_video' => $request->nama_video,
            'id_video_youtube' => $request->id_video_youtube,
        ]);
        return redirect()->back()->with('message', 'video Berhasil di update');
    }

    public function deleteVideo(Request $request)
    {
        Video::where('id_video', $request->id_video)->delete();
        return 1;
    }
}
