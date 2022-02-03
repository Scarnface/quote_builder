@component('mail::message')

Hello **{{$quote->first_name}} {{$quote->last_name}}**,

Thank you for choosing Quote Builder!

Please find your project quote below:

Client Email: {{$quote->email}}

Delivery Address: {{$quote->address}}

Subtotal: £{{$quote->sub_total}}

VAT: £{{$quote->vat}}

Total: £{{$quote->total}}

@component('mail::button', ['url' => env('APP_URL') . '/quotes/edit/' . $quote->id])
    View Quote
@endcomponent

Sincerely,
Quote Builder team.

@endcomponent
