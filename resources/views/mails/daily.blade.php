@component('mail::message')

Hello Admin,

Keep up the good work! In accordance with the 263rd rule of acquisition,
please find below details of all new quotes created today.

@component('mail::table')
    |Customer Email          | Total             | Link       |
    | :----------------: | :---------------:  | :---------------: |
    @foreach($quotes as  $q)
    |Client Email: {{ $q->email }}|Total: £{{ $q->total }}|[View Quote]({{ url(env('APP_URL') . 'quotes/edit/' . $q->id) }})
    @endforeach
@endcomponent

Admiringly,\
Your Faithful Service Bot

@endcomponent
