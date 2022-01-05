<?php

use App\Http\Controllers\API\UserController;
use App\Http\Controllers\API\QuoteController;
use App\Http\Controllers\API\ProductController;
use App\Http\Controllers\API\ProductListController;
use Illuminate\Support\Facades\Route;

Route::post('login', [UserController::class, 'login']);
Route::post('register', [UserController::class, 'register']);
Route::post('logout', [UserController::class, 'logout'])->middleware('auth:sanctum');

Route::group(['prefix' => 'quotes', 'middleware' => 'auth:sanctum'], function () {
    Route::get('/', [QuoteController::class, 'index']);
    Route::post('add', [QuoteController::class, 'add']);
    Route::get('edit/{id}', [QuoteController::class, 'edit']);
    Route::post('update/{id}', [QuoteController::class, 'update']);
    Route::delete('delete/{id}', [QuoteController::class, 'delete']);
});

Route::group(['prefix' => 'products', 'middleware' => 'auth:sanctum'], function () {
    Route::get('/', [ProductController::class, 'index']);
    Route::post('add', [ProductController::class, 'add']);
    Route::get('edit/{id}', [ProductController::class, 'edit']);
    Route::post('update/{id}', [ProductController::class, 'update']);
    Route::delete('delete/{id}', [ProductController::class, 'delete']);
});

Route::group(['prefix' => 'productLists', 'middleware' => 'auth:sanctum'], function () {
    Route::get('/{id}', [ProductListController::class, 'index']);
    Route::post('add', [ProductListController::class, 'add']);
    Route::get('edit/{id}', [ProductListController::class, 'edit']);
    Route::post('update/{id}', [ProductListController::class, 'update']);
    Route::delete('delete/{id}', [ProductListController::class, 'delete']);
});
