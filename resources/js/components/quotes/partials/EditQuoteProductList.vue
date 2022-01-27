Vue.component('edit-quote-product-list', {
    <template>
        <div>
            <h4 class="text-center">Products Included In Quote</h4><br/>

            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="product in quote.products" :key="product.id">
                    <td>{{ product.name }}</td>
                    <td>{{ product.description }}</td>
                    <td>{{ product.price }}</td>
                    <td>{{ product.quantity }}</td>
                    <td>
                        <div class="btn-group" role="group">
                            <button class="btn btn-secondary" :disabled="product.quantity === 1" @click="product.quantity--">&nbsp;-&nbsp;</button>
                            <button class="btn btn-secondary" @click="product.quantity++">&nbsp;+&nbsp;</button>
                            <button class="btn btn-danger" @click="this.$emit('deletequoteproduct', product.id)">Delete</button>
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
