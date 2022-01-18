<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\ProductQuote;
use Illuminate\Http\Request;

class ProductQuoteController extends Controller
{
    // all productQuotes
    public function index()
    {
        $productQuote = ProductQuote::all()->toArray();
        return response()->json($productQuote);
    }

    // add productQuote
    public function add(Request $request)
    {
        $productQuote = new ProductQuote([
            'quote_id' => $request->quote_id,
            'product_id' => $request->product_id,
            'quantity' => 1,
        ]);
        $productQuote->save();

        return response()->json('The productQuote successfully added');
    }

    // edit productQuote
    public function edit($id)
    {
        $productQuote = ProductQuote::find($id);
        return response()->json($productQuote);
    }

    // update productQuote
    public function update($id, Request $request)
    {
        $productQuote = ProductQuote::find($id);
        $productQuote->update($request->all());

        return response()->json('The productQuote successfully updated');
    }

    // delete productQuote
    public function delete($id)
    {
        $productQuote = ProductQuote::find($id);
        $productQuote->delete();

        return response()->json('The productQuote successfully deleted');
    }
}
