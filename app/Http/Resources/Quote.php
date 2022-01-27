<?php

namespace App\Http\Resources;

use App\Http\Resources\Product as ProductResource;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class Quote extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  Request  $request
     * @return array
     */
    public function toArray($request): array
    {
        return [
            'id' => $this->id,
            'first_name' => $this->first_name,
            'last_name' => $this->last_name,
            'email' => $this->email,
            'address' => $this->address,
            'sub_total' => $this->sub_total,
            'vat' => $this->vat,
            'total' => $this->total,
            'products' => $this->products,
        ];
    }
}
