<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\Product as ProductResource;
use App\Models\Product;
use Illuminate\Http\Request;
use App\Http\Requests\ProductRequest;

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
    public function add(ProductRequest $request)
    {
        Product::create($request->validated());

        return response()->json('Product added successfully');
    }

    // edit product page
    public function edit($id)
    {
        $product = new ProductResource(Product::find($id));
        return response()->json($product);
    }

    // update product
    public function update(ProductRequest $request, $id)
    {
        Product::find($id)->update($request->validated());

        return response()->json('Product updated successfully');
    }

    // delete product
    public function delete($id)
    {
        $product = Product::find($id);
        $product->delete();

        return response()->json('Product deleted successfully');
    }
}
