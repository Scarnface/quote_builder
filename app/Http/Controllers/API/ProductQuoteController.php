<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\ProductQuote;
use Illuminate\Http\Request;

class ProductQuoteController extends Controller
{
    // add or update product in quote
    public function updateOrCreate(Request $request)
    {
        ProductQuote::updateOrCreate(
            [
                'quote_id' => $request->quote_id,
                'product_id' => $request->product_id,
            ],
            [
                'quantity' => $request->quantity,
            ]
        );
    }

    // delete product from quote
    public function delete($id)
    {
        $productQuote = ProductQuote::find($id);
        $productQuote->delete();
    }
}
