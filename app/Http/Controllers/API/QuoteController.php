<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\Quote as QuoteResource;
use App\Models\Quote;
use Illuminate\Http\Request;

class QuoteController extends Controller
{
    // all quotes
    public function index()
    {
        return QuoteResource::collection(Quote::all());
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

        return response()->json('The quote was successfully added');
    }

    // edit quote
    public function edit($id)
    {
        $quote = Quote::with(['products' => function ($query) {
        $query->select('products.id', 'name', 'description', 'price');
        }])->find($id, ['id', 'first_name', 'last_name', 'email', 'address']);

        return response()->json($quote);
    }

    // update quote
    public function update($id, Request $request)
    {
        $quote = Quote::find($id);
        $quote->update($request->except(['products']));

        return response()->json('The quote was successfully updated');
    }

    // delete quote
    public function delete($id)
    {
        $quote = Quote::find($id);
        $quote->delete();

        return response()->json('The quote was successfully deleted');
    }
}
