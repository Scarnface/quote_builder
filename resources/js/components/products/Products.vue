<template>
    <div>
        <h4 class="text-center">All Products</h4><br/>

        <button type="button" class="btn btn-info" style="margin-bottom: 1rem" @click="this.$router.push('/products/add')">Add Product</button><br/>

        <input style="margin-bottom: 1rem" type="text" placeholder="Search..." v-model="keyword">

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
            <tr v-for="product in products">
                <td>{{ product.name }}</td>
                <td>{{ product.description }}</td>
                <td>{{ product.price }}</td>
                <td>
                    <div class="btn-group" role="group">
                        <router-link :to="{name: 'editproduct', params: { id: product.id }}" class="btn btn-primary">Edit</router-link>
                        <button class="btn btn-danger" @click="deleteProduct(product.id)">Delete</button>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
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
    created() {
        this.$axios.get('/sanctum/csrf-cookie').then(response => {
            this.$axios.get('/api/products')
                .then(response => {
                    this.products = response.data;
                })
                .catch(function (error) {
                    console.error(error);
                });
        })
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
                this.$axios.get('/sanctum/csrf-cookie').then(response => {
                    this.$axios.get('/api/products')
                        .then(response => {
                            this.products = response.data;
                        })
                        .catch(function (error) {
                            console.error(error);
                        });
                })
            }
        },
        deleteProduct(id) {
            this.$axios.get('/sanctum/csrf-cookie').then(response => {
                this.$axios.delete(`/api/products/delete/${id}`)
                    .then(response => {
                        let i = this.products.map(item => item.id).indexOf(id);
                        this.products.splice(i, 1)
                    })
                    .catch(function (error) {
                        console.error(error);
                    });
            })
        }
    },
    beforeRouteEnter(to, from, next) {
        if (!window.Laravel.isLoggedin) {
            window.location.href = "/";
        }
        next();
    }
}
</script>
