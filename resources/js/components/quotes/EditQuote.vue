<template>
    <div class="d-flex">
        <div class="w-75">
            <h4 class="text-center">Edit Client Details</h4>
            <div class="row">
                <div class="col-md-6">
                    <form>
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
        <div>
            <h4>Billing</h4>
            <h5>Sub Total</h5>
            <h5>£{{ subTotal }}</h5>
            <h5>VAT</h5>
            <h5>£{{ vat }}</h5>
            <h5>Total</h5>
            <h5>£{{ total }}</h5>
        </div>
    </div>
    <edit-quote-product-search
        @addquoteproduct="addQuoteProduct" />
    <edit-quote-product-list
        :quote="quote"
        @deletequoteproduct="deleteQuoteProduct"
        @updatequantity="updateQuantity"
    />
    <button class="btn btn-primary" @click="this.saveQuoteDetails()">Update Quote</button>
</template>

<script>
import EditQuoteProductList from "./partials/EditQuoteProductList";
import EditQuoteProductSearch from "./partials/EditQuoteProductSearch";

export default {
    components : {
        EditQuoteProductSearch,
        EditQuoteProductList,
    },
    data() {
        return {
            quote: {
                products: {}
            },
        }
    },
    created() {
        this.$axios.get('/sanctum/csrf-cookie').then(response => {
            this.$axios.get(`/api/quotes/edit/${this.$route.params.id}`)
                .then(response => {
                    this.quote = response.data;
                    this.loadedQuote = response.data;
                })
                .catch(function (error) {
                    console.error(error);
                });
        })
    },
    computed: {
        subTotal: function () {
            const resultArray = this.objToArray(this.quote.products);
            return resultArray.reduce(function (a, c) {
                // products.price * products.quantity
                return a + Number((c[3] * c[4]) || 0)
            }, 0).toFixed(2);
        },
        vat: function () {
            return Number(this.subTotal * 0.2).toFixed(2);
        },
        total: function () {
            return (Number(this.subTotal) + Number(this.vat)).toFixed(2);
        }
    },
    methods: {
        objToArray(obj) {
            const result = [];
            for (const prop in obj) {
                const value = obj[prop];
                // If nested object, recurse
                if (typeof value === 'object') {
                    result.push(this.objToArray(value));
                } else {
                    result.push(value);
                }
            }
            return result
        },
        addQuoteProduct(product) {
            product.quantity = 1;
            let i = this.quote.products.length + 1;
            this.quote.products.splice(i, 0, product);
        },
        updateQuantity(id, quantity) {

        },
        deleteQuoteProduct(id) {
            let i = this.quote.products.map(item => item.id).indexOf(id);
            this.quote.products.splice(i, 1);
        },
        saveQuoteDetails() {
            this.$axios.get('/sanctum/csrf-cookie').then(response => {

                // Update or create new and existing products in the quote
                for(let product of this.quote.products) {
                    let productQuote = {
                        quote_id: this.quote.id,
                        product_id: product.id,
                        quantity: product.quantity,
                    }

                    this.$axios.post('/api/productQuote/updateOrCreate', productQuote)
                        .catch(function (error) {
                            console.error(error);
                        });
                }

                // Delete any removed products
                // this.$axios.delete(`/api/productQuote/delete/${id}`)
                //     .catch(function (error) {
                //         console.error(error);
                //     });

                this.quote.sub_total = this.subTotal;
                this.quote.vat = this.vat;
                this.quote.total = this.total;

                this.$axios.post(`/api/quotes/update/${this.$route.params.id}`, this.quote)
                    .then(response => {
                        this.$router.push({name: 'quotes'});
                    })
                    .catch(function (error) {
                        console.error(error);
                    });

            });
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
