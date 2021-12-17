<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\ProductList;
use Illuminate\Http\Request;

class ProductListController extends Controller
{
    // all productLists
    public function index()
    {
        $productLists = ProductList::all()->toArray();
        return array_reverse($productLists);
    }

    // add productList
    public function add(Request $request)
    {
        $productList = new ProductList([
            'name' => $request->name,
            'author' => $request->author
        ]);
        $productList->save();

        return response()->json('The productList successfully added');
    }

    // edit productList
    public function edit($id)
    {
        $productList = ProductList::find($id);
        return response()->json($productList);
    }

    // update productList
    public function update($id, Request $request)
    {
        $productList = ProductList::find($id);
        $productList->update($request->all());

        return response()->json('The productList successfully updated');
    }

    // delete productList
    public function delete($id)
    {
        $productList = ProductList::find($id);
        $productList->delete();

        return response()->json('The productList successfully deleted');
    }
}
