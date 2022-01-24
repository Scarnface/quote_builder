Vue.component('edit-quote-product-search', {
    <template>
        <div>
            <h4 class="text-center">Search For Product</h4><br/>

            <div>
                <input type="text" v-model="keyword">
                <table class="table table-bordered">
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
                keyword: null,
                products: {}
            }
        },
        watch: {
            keyword(after, before) {
                this.liveSearch();
            }
        },
        methods: {
            liveSearch() {
                if(this.keyword !== '') {
                    this.$axios.get('/sanctum/csrf-cookie').then(response => {
                        this.$axios.get('/api/products/livesearch', { params: { keyword: this.keyword } })
                            .then(response => {
                                this.products = response.data.data;
                            })
                            .catch(function (error) {
                                console.error(error);
                            });
                    })
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
