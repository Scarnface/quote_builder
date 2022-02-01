Vue.component('edit-quote-product-search', {
    <template>
        <div>
            <h4 class="text-center">Search For Product</h4><br/>

            <div>
                <input type="text" v-model="keyword">
                <table v-if="keyword" class="table table-bordered table-sm">
                    <thead>
                    <tr>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr v-for="product in products" :key="product.id">
                        <td>{{ product.name }}</td>
                        <td>{{ product.description }}</td>
                        <td>{{ product.price }}</td>
                        <td>
                            <div class="btn-group" role="group">
                                <button class="btn btn-primary" @click="this.$emit('addquoteproduct', product)">Add</button>
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
        data() {
            return {
                // The live search keyword
                keyword: null,
                // The live search products
                products: {}
            }
        },
        watch: {
            // Triggers search whenever users add characters to the keyword
            keyword(after, before) {
                this.liveSearch();
            }
        },
        methods: {
            // Searches for products by keyword
            liveSearch() {
                if(this.keyword !== '') {
                    this.$axios.get('/sanctum/csrf-cookie').then(response => {
                        this.$axios.get('/api/products/', { params: { keyword: this.keyword } })
                            .then(response => {
                                this.products = response.data;
                            })
                            .catch(function (error) {
                                console.error(error);
                            });
                    })
                    // Removes search table by resetting variable if user deletes keyword from search
                } else {
                    this.products = {};
                }
            },
        },
        beforeRouteEnter(to, from, next) {
            if (!window.Laravel.isLoggedin) {
                window.location.href = "/";
            }
            next();
        }
    }
    </script>
})
