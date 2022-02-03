<template>
    <div class="card card-default">
        <div class="card-header">
            <h4 class="brandText mb-0">All Products</h4>
        </div>
         <div class="card-body">
             <div class="d-flex justify-content-around align-items-center mb-3">
                 <button type="button" class="btn brandButton" @click="this.$router.push('/products/add')">Create New Product</button>
                 <div class="col-sm-6">
                     <input class="form-control brandTextField text-center" type="text" placeholder="Search existing products..." v-model="keyword">
                 </div>
             </div>
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
                        <td>£{{ product.price }}</td>
                        <td class="d-flex justify-content-around">
                            <router-link :to="{name: 'editproduct', params: { id: product.id }}" class="btn brandButton btn-sm">Edit</router-link>
                            <button class="btn btn-danger btn-sm" @click="deleteProduct(product.id)">Remove</button>
                        </td>
                    </tr>
                </tbody>
            </table>
         </div>
    </div>

    <router-link :to="{name: 'dashboard'}" class="text-xl fw-bold brandText">&#60;&#60;&#60; Go Back</router-link>
</template>

<script>
export default {
    data() {
        return {
            // The live search products
            products: {},
            // The live search keyword
            keyword: null,
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
