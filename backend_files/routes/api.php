<?php

use App\Http\Controllers\AbsensiController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\VideoController;
use App\Http\Controllers\CommentController;
use App\Http\Controllers\InfoController;
use App\Http\Controllers\KelasController;
use App\Http\Controllers\LikeController;
use App\Http\Controllers\MatakuliahController;
use App\Http\Controllers\SoalEvaluasiController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });


Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::post('/update_profile', [AuthController::class, 'updateProfile']);
Route::post('/save_absen', [AbsensiController::class, 'saveAbsen']);
Route::post('/save_kelas', [KelasController::class, 'saveKelas']);
Route::post('/save_matakuliah', [MatakuliahController::class, 'saveMatakuliah']);





// User
Route::get('/matakuliah', [MatakuliahController::class, 'matakuliah']);
Route::get('/kelas', [KelasController::class, 'kelas']);
Route::get('/kelas_per_dosen/{id}', [KelasController::class, 'kelasPerDosen']);
Route::get('/peserta_kelas/{kode_kelas}', [KelasController::class, 'pesertaKelas']);
Route::get('/absen/{id}', [AbsensiController::class, 'absen']);
Route::get('/absen_check/{id}/{tgl}/{kode}', [AbsensiController::class, 'absenCheck']);
Route::get('/user/{id}', [AuthController::class, 'user']);
Route::get('/user', [AuthController::class, 'allUser']);
Route::get('/mahasiswa', [AuthController::class, 'mahasiswa']);
Route::get('/dosen', [AuthController::class, 'dosen']);
Route::put('/user', [AuthController::class, 'update']);
Route::post('/logout', [AuthController::class, 'logout']);
// Route::group(['middleware' => ['auth:sanctum']], function () {
//     Route::post('/logout', [AuthController::class, 'logout']);
//     Route::get('/user', [AuthController::class, 'user']);


//     // Category
//     Route::get('/category/{id_category}', [CategoryController::class, 'show']);
//     Route::put('/category/{id_category}', [CategoryController::class, 'update']);
//     Route::post('/category/', [CategoryController::class, 'store']);
//     Route::delete('/category/{id_category}', [CategoryController::class, 'destroy']);

//     // Comment
//     Route::get('/info/{id_info}/comments', [CommentController::class, 'index']);
//     Route::post('/info/{id_info}/comments', [CommentController::class, 'store']);
//     Route::put('/comments/{id_comments}', [CommentController::class, 'update']);
//     Route::delete('/comment/{id_comments}', [CommentController::class, 'destroy']);

//     // like
//     Route::post('/info/{id_info/likes', [LikeController::class, 'likeOrUnlike']);
//     // User
// });
