<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\Product as ProductResource;
use App\Models\Product;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    // all products
    public function index()
    {
        return ProductResource::collection(Product::all());
    }

    // live search
    public function liveSearch(Request $request)
    {
        return ProductResource::collection(Product::where('name', 'like', '%'.$request->keyword.'%')
            ->orWhere('description', 'like', '%'.$request->keyword.'%')
            ->orderByRaw('name like ? desc', $request->keyword)
            ->get());
    }

    // add product
    public function add(Request $request)
    {
        $product = new Product([
            'name' => $request->name,
            'description' => $request->description,
            'price' => $request->price,
        ]);
        $product->save();

        return response()->json('The product was successfully added');
    }

    // edit product
    public function edit($id)
    {
        return new ProductResource(Product::find($id));
    }

    // update product
    public function update($id, Request $request)
    {
        $product = Product::find($id);
        $product->update($request->all());

        return response()->json('The product was successfully updated');
    }

    // delete product
    public function delete($id)
    {
        $product = Product::find($id);
        $product->delete();

        return response()->json('The product was successfully deleted');
    }
}
