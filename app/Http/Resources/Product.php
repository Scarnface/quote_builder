<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class Product extends JsonResource
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
            'name' => $this->name,
            'description' => $this->description,
            'price' => $this->price,
            'quantity' => $this->whenPivotLoaded('product_quote', function (){
                return $this->pivot->quantity;
            }),
            'pivotID' => $this->whenPivotLoaded('product_quote', function (){
                return $this->pivot->id;
            }),
        ];
    }
}
