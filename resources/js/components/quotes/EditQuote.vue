<template>
    <div class="d-flex">
        <div class="w-75">
            <h4 class="text-center">Edit Client Details</h4>
            <div class="row">
                <div class="col-md-6">
                    <form @submit.prevent="saveClientDetails">
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
                    </form>
                </div>
            </div>
        </div>
        <edit-quote-billing
            :quote="quote" />
    </div>
    <edit-quote-product-search
        @addquoteproduct="addQuoteProduct" />
    <edit-quote-product-list
        :quote="quote"
        @deletequoteproduct="deleteQuoteProduct"
    />
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
        addQuoteProduct(product) {
            product.quantity = 1;
            let i = this.quote.products.length + 1;
            this.quote.products.splice(i, 0, product);
        },
        deleteQuoteProduct(id) {
            let i = this.quote.products.map(item => item.id).indexOf(id);
            this.quote.products.splice(i, 1);
        },
        saveQuoteDetails(quote) {
            // const updateData = {
            //     quote_id: this.quote.id,
            //     product_id: product.id,
            // }
            //
            // this.$axios.get('/sanctum/csrf-cookie').then(response => {
            //     this.$axios.post('/api/productQuote/add/', updateData)
            //         .catch(function (error) {
            //             console.error(error);
            //         });
            // })
            //
            // this.$axios.get('/sanctum/csrf-cookie').then(response => {
            //     this.$axios.delete(`/api/productQuote/delete/${id}`)
            //         .then(response => {
            //             let i = this.quote.products.map(item => item.id).indexOf(id); // find index of your object
            //             this.quote.products.splice(i, 1)
            //         })
            //         .catch(function (error) {
            //             console.error(error);
            //         });
            // })
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
