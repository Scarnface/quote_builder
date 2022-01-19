<template>
    <div class="d-flex">
        <div class="w-75">
            <h4 class="text-center">Edit Client Details</h4>
            <div class="row">
                <div class="col-md-6">
                    <form @submit.prevent="updateQuote">
                        <div class="form-group">
                            <label>First Name</label>
                            <input type="text" class="form-control" v-model="quote.first_name">
                        </div>
                        <div class="form-group">
                            <label>Last Name</label>
                            <input type="text" class="form-control" v-model="quote.last_name">
                        </div>
                        <div class="form-group">
                            <label>Email</label>
                            <input type="text" class="form-control" v-model="quote.email">
                        </div>
                        <div class="form-group">
                            <label>Address</label>
                            <input type="text" class="form-control" v-model="quote.address">
                        </div>
                        <button type="submit" class="btn btn-primary">Update Client Details</button>
                    </form>
                </div>
            </div>
        </div>
        <edit-quote-billing :quote="quote" />
    </div>
    <edit-quote-product-search @updateproductlist="addProduct" />
    <edit-quote-product-list :quote="quote" />
</template>

<script>
import EditQuoteBilling from "./partials/EditQuoteBilling";
import EditQuoteProductList from "./partials/EditQuoteProductList";
import EditQuoteProductSearch from "./partials/EditQuoteProductSearch";

export default {
    components : {
        EditQuoteProductSearch,
        EditQuoteProductList,
        EditQuoteBilling,
    },
    data() {
        return {
            quote: {
                products: {}
            }
        }
    },
    created() {
        this.$axios.get('/sanctum/csrf-cookie').then(response => {
            this.$axios.get(`/api/quotes/edit/${this.$route.params.id}`)
                .then(response => {
                    this.quote = response.data;
                })
                .catch(function (error) {
                    console.error(error);
                });
        })
    },
    methods: {
        updateQuote() {
            this.$axios.get('/sanctum/csrf-cookie').then(response => {
                this.$axios.post(`/api/quotes/update/${this.$route.params.id}`, this.quote)
                    .then(response => {
                        this.$router.push({name: 'quotes'});
                    })
                    .catch(function (error) {
                        console.error(error);
                    });
            })
        },
        addProduct(product) {
            const updateData = {
                quote_id: this.quote.id,
                product_id: product.id,
            }
            const i = this.quote.products.length + 1;

            this.$axios.get('/sanctum/csrf-cookie').then(response => {
                this.$axios.post('/api/productQuote/add/', updateData)
                    .then(response => {
                        this.quote.products["i"] = {
                            id: product.id,
                            name: product.name,
                            description: product.description,
                            price: product.price,
                            pivot: product.pivot,
                        }
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
