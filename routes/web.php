<?php

use App\Http\Controllers\HomeController;
use Illuminate\Support\Facades\Route;

Route::get('{any}', function () {
    return view('app');
})->where('any', '.*');

Auth::routes();

Route::get('/', [HomeController::class, 'index'])->name('home');
