<?php

namespace App\Http\Controllers;

use App\Http\Resources\Quote as QuoteResource;
use App\Mail\QuoteMail;
use App\Models\Quote;
use Mail;

class EmailController extends Controller
{
    public function send($id)
    {
        $quote = new QuoteResource(Quote::find($id));
        Mail::to($quote->email)->send(new QuoteMail($quote));

        return response()->json('Email Sent');
    }
}
