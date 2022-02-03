<?php

namespace App\Http\Controllers;

use App\Mail\QuoteMail;
use App\Models\Quote;
use Mail;

class EmailController extends Controller
{
    public function send($id)
    {
        $quote = Quote::find($id);
        Mail::to($quote->email)->send(new QuoteMail($quote));
    }
}
