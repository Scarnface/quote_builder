<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\Product as ProductResource;
use App\Models\Product;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    // search or all products
    public function index(Request $request)
    {
        if($request->keyword) {
            $product = ProductResource::collection(Product::where('name', 'like', '%'.$request->keyword.'%')
                ->orWhere('description', 'like', '%'.$request->keyword.'%')
                ->orderByRaw('name like ? desc', $request->keyword)
                ->get());
        } else {
            $product =  ProductResource::collection(Product::all());
        }

        return response()->json($product);
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

    // edit product page
    public function edit($id)
    {
        $product = new ProductResource(Product::find($id));
        return response()->json($product);
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
