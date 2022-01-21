<template>
    <div>
        <h4 class="text-center">All Products</h4><br/>

        <button type="button" class="btn btn-info" @click="this.$router.push('/products/add')">Add Product</button>

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
            <tr v-for="product in products.data" :key="product.id">
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
            products: []
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
    methods: {
        deleteProduct(id) {
            this.$axios.get('/sanctum/csrf-cookie').then(response => {
                this.$axios.delete(`/api/products/delete/${id}`)
                    .then(response => {
                        let i = this.products.data.map(item => item.id).indexOf(id);
                        this.products.data.splice(i, 1)
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
