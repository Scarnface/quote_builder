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
                                    <button class="btn btn-success btn-sm" @click="this.$emit('addquoteproduct', product); this.clearKW()">Add</button>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <pagination v-model="pagination.page"
                                :records="this.pagination.total_items"
                                :per-page="this.pagination.items_per_page"
                                @paginate="getResults()"/>
                </div>
            </div>
        </div>
    </template>

    <script>
    import Pagination from 'v-pagination-3';

    export default {
        components: {
            Pagination
        },
        data() {
            return {
                // The live search keyword
                keyword: null,
                // The live search products
                products: {},
                // Pagination data
                pagination: {
                    page: 1,
                    total_items: 0,
                    items_per_page: 0,
                }
            }
        },
        created() {
            // Fetch initial results
            this.getResults();
        },
        watch: {
            // Triggers search whenever users add characters to the keyword
            keyword(after, before) {
                // Reset first page before search to prevent being on a non-existent page when results update
                this.pagination.page = 1;
                this.getResults();
            }
        },
        methods: {
            getResults(page = this.pagination.page) {
                this.$axios.get('/sanctum/csrf-cookie').then(response => {
                    this.$axios.get('/api/products/?page=' + page, { params: { keyword: this.keyword } })
                        .then(response => {
                            this.products = response.data.data;
                            this.pagination.total_items = response.data.pagination.total;
                            this.pagination.items_per_page = response.data.pagination.per_page;
                        })
                        .catch(function (error) {
                            console.error(error);
                        });
                })
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
