<?php

namespace App\Http\Controllers;

use App\Models\InfoModel;
use App\Models\KategoriModel;
use App\Models\User;
use Illuminate\Http\Request;


class Home extends Controller
{

    protected $userModel;
    protected $testimoniModel;
    protected $profileUserModel;

    public function __construct()
    {
        $this->userModel = new User();
    }

    public function index()
    {
        return view('pages.halaman_depan.index');
    }
}
