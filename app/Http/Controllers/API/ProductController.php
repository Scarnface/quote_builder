<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Product;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    // all products
    public function index()
    {
        $products = Product::all()->toArray();
        return array_reverse($products);
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

        return response()->json('The product successfully added');
    }

    // edit product
    public function edit($id)
    {
        $product = Product::find($id);
        return response()->json($product);
    }

    // update product
    public function update($id, Request $request)
    {
        $product = Product::find($id);
        $product->update($request->all());

        return response()->json('The product successfully updated');
    }

    // delete product
    public function delete($id)
    {
        $product = Product::find($id);
        $product->delete();

        return response()->json('The product successfully deleted');
    }
}
