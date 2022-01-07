<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\ProductList;
use App\Models\Quote;
use Illuminate\Http\Request;

class QuoteController extends Controller
{
    // all quotes
    public function index()
    {
        $quotes = Quote::all()->toArray();
        return array_reverse($quotes);
    }

    // add quote
    public function add(Request $request)
    {
        $quote = new Quote([
            'first_name' => $request->first_name,
            'last_name' => $request->last_name,
            'email' => $request->email,
            'address' => $request->address,
        ]);
        $quote->save();

        return response()->json('The quote successfully added');
    }

    // edit quote
    public function edit($id)
    {
        $quote = Quote::with('products')->find($id);
        return response()->json($quote);
    }

    // update quote
    public function update($id, Request $request)
    {
        $quote = Quote::find($id);
        $quote->update($request->except(['products']));

        return response()->json('The quote successfully updated');
    }

    // delete quote
    public function delete($id)
    {
        $quote = Quote::find($id);
        $quote->delete();

        return response()->json('The quote successfully deleted');
    }
}
