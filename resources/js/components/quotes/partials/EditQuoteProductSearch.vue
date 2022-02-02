Vue.component('edit-quote-product-search', {
    <template>
        <div class="my-4">
            <div class="card card-default">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h4 class="brandText mb-0">Add Products</h4>
                    <button type="button" class="btn brandButton" @click="this.$router.push('/products/add')">Create New Product</button>
                    <div class="col-sm-6">
                        <input class="form-control brandTextField text-center" type="text" placeholder="Search existing products..." v-model="keyword">
                    </div>
                </div>
                <div v-if="keyword" class="card-body">
                    <table class="table table-bordered table-sm">
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
                            <td>£{{ product.price }}</td>
                            <td>
                                <div class="d-flex justify-content-center btn-group" role="group">
                                    <button class="btn btn-success btn-sm" @click="this.$emit('addquoteproduct', product)">Add</button>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
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
