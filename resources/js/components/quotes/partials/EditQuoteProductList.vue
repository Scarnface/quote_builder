Vue.component('edit-quote-product-list', {
    <template>
        <div class="card card-default">
            <div class="card-header">
                <h4 class="brandText mb-0">Products Included In Quote</h4>
            </div>
            <div class="card-body">
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
                                <input type="number" min="1" class="form-control form-control-sm brandTextField" v-model="product.quantity">
                            </td>
                            <td>
                                <div class="d-flex justify-content-center btn-group" role="group">
                                    <button class="btn btn-danger btn-sm" @click="this.$emit('deletequoteproduct', product)">Remove</button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
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
