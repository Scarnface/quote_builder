<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductQuote extends Model
{
    use HasFactory;

    protected $guarded=[];

    protected $table = 'product_quote';

    public function quotes()
    {
        return $this->belongsToMany(Quote::class);
    }

    public function products()
    {
        return $this->belongsToMany(Product::class);
    }
}
