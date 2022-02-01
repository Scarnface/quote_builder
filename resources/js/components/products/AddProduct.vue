<template>
    <div>
        <h4 class="text-center">Add Product</h4>
        <div class="row">
            <div class="col-md-6">
                <form @submit.prevent="addProduct">
                    <div class="form-group">
                        <label>Name</label>
                        <input type="text" class="form-control" v-model="product.name">
                    </div>
                    <div class="form-group">
                        <label>Description</label>
                        <input type="text" class="form-control" v-model="product.description">
                    </div>
                    <div class="form-group">
                        <label>Price</label>
                        <input type="text" class="form-control" v-model="product.price">
                    </div>
                    <button type="submit" class="btn btn-primary">Add Product</button>
                </form>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            // The specific product to be added
            product: {}
        }
    },
    methods: {
        // Saves the new product to the DB
        addProduct() {
            this.$axios.get('/sanctum/csrf-cookie').then(response => {
                this.$axios.post('/api/products/add', this.product)
                    .then(response => {
                        this.$router.push({name: 'products'})
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
