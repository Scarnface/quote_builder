Vue.component('edit-quote-product-list', {
    <template>
        <div class="border border-3 rounded my-4 p-4">
            <h4 class="text-info text-center">Products Included In Quote</h4><br/>

            <table class="table table-bordered table-sm">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th class="col-sm-2">Quantity</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="product in quote.products" :key="product.id">
                        <td>{{ product.name }}</td>
                        <td>{{ product.description }}</td>
                        <td>{{ product.price }}</td>
                        <td>
                            <input type="number" min="1" class="form-control form-control-sm" v-model="product.quantity">
                        </td>
                        <td>
                            <div class="d-flex justify-content-center btn-group" role="group">
                                <button class="btn btn-danger btn-sm" @click="this.$emit('deletequoteproduct', product)">Delete</button>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </template>

    <script>
    export default {
        props: {
            quote: {
                type: Object,
            }
        }
    }
    </script>
)}
