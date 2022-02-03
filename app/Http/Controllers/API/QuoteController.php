<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\Quote as QuoteResource;
use App\Models\Quote;
use Illuminate\Http\Request;
use App\Http\Requests\QuoteRequest;

class QuoteController extends Controller
{
    // all quotes
    public function index()
    {
        $quote =  QuoteResource::collection(Quote::all());
        return response()->json($quote);
    }

    // add quote
    public function add(QuoteRequest $request)
    {
        Quote::create($request->validated());

        return response()->json('The quote was successfully added');
    }

    // edit quote page
    public function edit($id)
    {
        $quote = new QuoteResource(Quote::find($id));
        return response()->json($quote);
    }

    // update quote
    public function update(QuoteRequest $request, $id)
    {
        Quote::find($id)->update($request->validated());

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
