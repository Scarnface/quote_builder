<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class QuoteRequest extends FormRequest
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return ($this->isMethod('POST') ? $this->add() : $this->update());
    }

    protected function add()
    {
        return [
            'first_name' => 'required|max:255',
            'last_name' => 'required|max:255',
            'email' => 'required|email|max:255',
            'address' => 'required|max:255',
        ];
    }

    protected function update()
    {
        return [
            'first_name' => 'required|max:255',
            'last_name' => 'required|max:255',
            'email' => 'required|email|max:255',
            'address' => 'required|max:255',
            'sub_total' => 'required|numeric',
            'vat' => 'required|numeric',
            'total' => 'required|numeric',
        ];
    }
}
