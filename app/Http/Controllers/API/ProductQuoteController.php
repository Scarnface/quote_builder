<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\ProductQuote;
use Illuminate\Http\Request;

class ProductQuoteController extends Controller
{
    // add product to quote
    public function add(Request $request)
    {
        $productQuote = new ProductQuote([
            'quote_id' => $request->quote_id,
            'product_id' => $request->product_id,
            'quantity' => $request->quantity,
        ]);
        $productQuote->save();
    }

    // update product in quote
    public function update($id, Request $request)
    {
        $productQuote = ProductQuote::find($id);
        $productQuote->update($request->all());

        return response()->json('The productQuote successfully updated');
    }

    // delete product from quote
    public function delete($id)
    {
        $productQuote = ProductQuote::find($id);
        $productQuote->delete();

        return response()->json('The productQuote successfully deleted');
    }
}
