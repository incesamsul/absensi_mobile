<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateProfileTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('profile', function (Blueprint $table) {
            $table->increments('id_profile');
            $table->unsignedBigInteger('id_user');
            $table->enum('jenis_kelamin', ['L', 'P'])->nullable();
            $table->string('nisn', 30)->nullable();
            $table->string('nip', 30)->nullable();
            $table->string('golongan', 75)->nullable();
            $table->string('jabatan', 75)->nullable();
            $table->string('alamat', 75)->nullable();
            $table->string('no_telp', 75)->nullable();
            $table->string('kelas', 75)->nullable();
            $table->timestamps();
            $table->foreign('id_user')->references('id')->on('users')->onUpdate('cascade')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('profile');
    }
}
