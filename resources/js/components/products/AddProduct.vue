<template>
    <div class="card card-default">
        <div class="card-header">
            <h4 class="brandText mb-0">Create New Product</h4>
        </div>
        <div class="card-body">
            <form @submit.prevent="addProduct">
                <div class="row mb-3">
                    <label class="col-sm-2" for="apname">Name</label>
                    <div class="col-sm-10">
                        <input id="apname"
                               type="text"
                               class="form-control brandTextField"
                               placeholder="Enter a short name i.e. BrandX white paint..."
                               v-model="product.name">
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-2" for="apdescription">Description</label>
                    <div class="col-sm-10">
                        <input id="apdescription"
                               type="text"
                               class="form-control brandTextField"
                               placeholder="Enter full product details..."
                               v-model="product.description">
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-2" for="apprice">Price (GBP)</label>
                    <div class="col-sm-10">
                        <span class="input-symbol">
                            <input id="apprice"
                                   type="text"
                                   class="form-control brandTextField"
                                   placeholder="Enter a price i.e. 0.50/9.99..."
                                   v-model="product.price">
                        </span>
                    </div>
                </div>
                <div v-if="errors" class="pt-3">
                    <div v-for="(v, k) in errors" :key="k">
                        <p class="text-danger fw-bold" v-for="error in v" :key="error">
                            {{ error }}
                        </p>
                    </div>
                </div>
                <button type="submit" class="btn brandButton mt-3">Create Product</button>
            </form>
        </div>
    </div>
    <router-link :to="{name: 'products'}" class="text-xl fw-bold brandText">&#60;&#60;&#60; Go Back</router-link>
</template>

<script>
export default {
    data() {
        return {
            // The specific product to be added
            product: {},
            // Validation error messages
            errors: null,
        }
    },
    methods: {
        // Saves the new product to the DB
        addProduct() {
            this.$axios.get('/sanctum/csrf-cookie').then(response => {
                this.$axios.post('/api/products/add', this.product)
                    .then(response => {
                        this.$swal({
                            toast: true,
                            position: 'bottom-end',
                            icon: 'success',
                            showConfirmButton: false,
                            timer: 3000,
                            title: response.data,
                        });
                        this.$router.back();
                    })
                    .catch(e => {
                        this.errors = e.response.data.errors;
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
