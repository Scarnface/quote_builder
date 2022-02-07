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
             <pagination v-model="pagination.page"
                         :records="this.pagination.total_items"
                         :per-page="this.pagination.items_per_page"
                         @paginate="getResults()"/>
         </div>
    </div>

    <router-link :to="{name: 'dashboard'}" class="text-xl fw-bold brandText">&#60;&#60;&#60; Go Back</router-link>
</template>

<script>
import Pagination from 'v-pagination-3';

export default {
    components: {
        Pagination
    },
    data() {
        return {
            // The live search products
            products: {},
            // The live search keyword
            keyword: null,
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
        deleteProduct(id) {
            this.$swal({
                title: 'Are you sure?',
                text: "You won't be able to revert this!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#df4759',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    this.$axios.get('/sanctum/csrf-cookie').then(response => {
                        this.$axios.delete(`/api/products/delete/${id}`)
                            .then(response => {
                                let i = this.products.map(item => item.id).indexOf(id);
                                this.products.splice(i, 1);
                                this.$swal({
                                    toast: true,
                                    position: 'bottom-end',
                                    icon: 'success',
                                    showConfirmButton: false,
                                    timer: 3000,
                                    title: response.data,
                                });
                            })
                            .catch(function (error) {
                                console.error(error);
                            });
                    })
                }
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
