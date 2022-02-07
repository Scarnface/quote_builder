<template>
    <div class="card card-default">
        <div class="card-header">
            <h4 class="brandText mb-0">Edit Product</h4>
        </div>
        <div class="card-body">
            <form @submit.prevent="updateProduct">
                <div class="row mb-3">
                    <label class="col-sm-2" for="epname">Name</label>
                    <div class="col-sm-10">
                        <input id="epname" type="text" class="form-control brandTextField" v-model="product.name">
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-2" for="epdescription">Description</label>
                    <div class="col-sm-10">
                        <input id="epdescription" type="text" class="form-control brandTextField" v-model="product.description">
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-2" for="epprice">Price</label>
                    <div class="col-sm-10">
                        <input id="epprice" type="text" class="form-control brandTextField" v-model="product.price">
                    </div>
                </div>
                <button type="submit" class="btn brandButton mt-3">Update Product</button>
            </form>
        </div>
    </div>
    <router-link :to="{name: 'products'}" class="text-xl fw-bold brandText">&#60;&#60;&#60; Go Back</router-link>
</template>

<script>
export default {
    data() {
        return {
            // The specific product requested
            product: {}
        }
    },
    // Loads the product data from the DB and assigns it to the local data variable
    created() {
        this.$axios.get('/sanctum/csrf-cookie').then(response => {
            this.$axios.get(`/api/products/edit/${this.$route.params.id}`)
                .then(response => {
                    this.product = response.data;
                })
                .catch(function (error) {
                    console.error(error);
                });
        })
    },
    methods: {
        // Updates the DB with local data
        updateProduct() {
            this.$axios.get('/sanctum/csrf-cookie').then(response => {
                this.$axios.put(`/api/products/update/${this.$route.params.id}`, this.product)
                    .then(response => {
                        this.$swal({
                            toast: true,
                            position: 'bottom-end',
                            icon: 'success',
                            showConfirmButton: false,
                            timer: 3000,
                            title: response.data,
                        });
                        this.$router.push({name: 'products'});
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
