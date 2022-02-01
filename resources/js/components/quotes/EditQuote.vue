<template>
    <div class="d-flex justify-content-between">
        <div class="border border-3 rounded p-4" style="width: 66%">
            <h4 class="text-info text-center">Edit Client Details</h4>

            <form>
                <div class="row mb-3">
                    <label class="col-sm-2" for="fname">First Name</label>
                    <div class="col-sm-10">
                        <input id="fname" type="text" class="form-control" v-model="quote.first_name">
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-2" for="lname">Last Name</label>
                    <div class="col-sm-10">
                        <input id="lname" type="text" class="form-control" v-model="quote.last_name">
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-2" for="email">Email</label>
                    <div class="col-sm-10">
                        <input id="email" type="text" class="form-control" v-model="quote.email">
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-2" for="address">Address</label>
                    <div class="col-sm-10">
                        <input id="address" type="text" class="form-control" v-model="quote.address">
                    </div>
                </div>
            </form>
        </div>
        <div class="border border-3 rounded p-4" style="width: 30%">
            <h4 class="text-info text-center mb-4">Billing</h4><br>
            <h5 class="text-center mb-3">Sub Total: £{{ subTotal }}</h5>
            <h5 class="text-center mb-3">VAT: £{{ vat }}</h5>
            <h5 class="text-center mb-3">Total: £{{ total }}</h5>
        </div>
    </div>
    <edit-quote-product-search
        @addquoteproduct="addQuoteProduct" />
    <edit-quote-product-list
        :quote="quote"
        @deletequoteproduct="deleteQuoteProduct"
    />
    <button class="btn btn-primary mb-4" @click="this.saveQuoteDetails()">Update Quote</button>
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
            // The quote data with all its products
            quote: {
                products: {}
            },
            // An array to track products removed from live data but not the DB
            removedProducts: [],
        }
    },
    created() {
        // Loads the quote data from the DB and assigns it to the local data variable
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
    computed: {
        // Calls the objToArray method to allow math functions
        subTotal: function () {
            const resultArray = this.objToArray(this.quote.products);
            // Multiplies products.price * products.quantity and returns rounded to 2 D.P.
            return resultArray.reduce(function (a, c) {
                return a + Number((c[3] * c[4]) || 0)
            }, 0).toFixed(2);
        },
        vat: function () {
            // Multiply subtotal by 20% for VAT
            return Number(this.subTotal * 0.2).toFixed(2);
        },
        total: function () {
            // Adds VAT to subtotal and returns total
            return (Number(this.subTotal) + Number(this.vat)).toFixed(2);
        }
    },
    methods: {
        // Converts JSON to arrays
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
            // Tests if the product is already in the quote
            if(this.quote.products.findIndex(x => x.id === product.id) === -1) {
                // If false, set quantity to 1 and add it
                product.quantity = 1;
                let i = this.quote.products.length + 1;
                this.quote.products.splice(i, 0, product);
            } else {
                // If true, alert the user
                alert("Product already added to quote");
                return;
            }

            // Tests if the product being added has previously been removed from the live data
            if(this.removedProducts.findIndex(x => x.id === product.id) !== -1) {
                // If true, remove from the removedProducts array to prevent deletion during save
                let j = this.removedProducts.indexOf(product)
                this.removedProducts.splice(j, 1);
            }
        },
        deleteQuoteProduct(product) {
            // Remove the product from the live data
            let i = this.quote.products.map(item => item.id).indexOf(product.id);
            this.quote.products.splice(i, 1);
            // Record its removal in the removedProducts array
            this.removedProducts.push(product)
        },
        // Updates the DB with all local data
        saveQuoteDetails() {
            this.$axios.get('/sanctum/csrf-cookie').then(response => {

                // Loop all products in live data and create or update existing products in the quote via the pivot table
                for(let product of this.quote.products) {
                    // Construct the pivot entry
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
                for(let product of this.removedProducts) {
                    this.$axios.delete(`/api/productQuote/delete/${product.pivotID}`)
                        .catch(function (error) {
                            console.error(error);
                        });
                }

                // Assign the totals to the quote data to be saved
                this.quote.sub_total = this.subTotal;
                this.quote.vat = this.vat;
                this.quote.total = this.total;

                // Save customer details and totals
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
