<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ProductRequest extends FormRequest
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
            'name' => 'required|max:255|unique:products',
            'description' => 'required|max:255',
            'price' => 'required|numeric',
        ];
    }

    protected function update()
    {
        return [
            'name' => 'required|max:255|unique:products,name,' .$this->route('id'),
            'description' => 'required|max:255',
            'price' => 'required|numeric',
        ];
    }
}
