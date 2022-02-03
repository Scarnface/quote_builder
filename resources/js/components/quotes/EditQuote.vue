<template>
    <div class="d-flex justify-content-between">
        <div class="card card-default" style="width: 66%">
            <div class="card-header">
                <h4 class="brandText mb-0">Edit Client Details</h4>
            </div>
            <div class="card-body">
                <form>
                    <div class="row mb-3">
                        <label class="col-sm-2" for="fname">First Name</label>
                        <div class="col-sm-10">
                            <input id="fname" type="text" class="form-control brandTextField" v-model="quote.first_name">
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label class="col-sm-2" for="lname">Last Name</label>
                        <div class="col-sm-10">
                            <input id="lname" type="text" class="form-control brandTextField" v-model="quote.last_name">
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label class="col-sm-2" for="email">Email</label>
                        <div class="col-sm-10">
                            <input id="email" type="text" class="form-control brandTextField" v-model="quote.email">
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label class="col-sm-2" for="address">Address</label>
                        <div class="col-sm-10">
                            <input id="address" type="text" class="form-control brandTextField" v-model="quote.address">
                        </div>
                    </div>
                </form>
            </div>
        </div>


        <div class="card card-default" style="width: 30%">
            <div class="card-header d-flex align-items-center h-20">
                <h4 class="brandText text-center mb-0">Billing</h4><br>
            </div>
            <div class="card-body d-flex align-items-center justify-content-center">
                <div>
                    <h5 class="text-center">Sub Total: £{{ subTotal }}</h5>
                    <h5 class="text-center mt-3">VAT: £{{ vat }}</h5>
                    <h5 class="text-center mt-3">Total: £{{ total }}</h5>
                </div>
            </div>
        </div>
    </div>
    <edit-quote-product-search
        @addquoteproduct="addQuoteProduct" />
    <edit-quote-product-list
        :quote="quote"
        @deletequoteproduct="deleteQuoteProduct"
    />
    <button class="btn brandButton my-4" @click="this.saveQuoteDetails()">Update Quote</button><br>
    <router-link :to="{name: 'quotes'}" class="text-xl fw-bold brandText">&#60;&#60;&#60; Go Back</router-link>
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
        subTotal: function () {
            // Multiplies products.price * products.quantity and returns rounded to 2 D.P.
            let st = 0
            Array.prototype.forEach.call(this.quote.products,product => {
                st += (product.quantity * product.price);
            })
            this.quote.sub_total = st.toFixed(2);
            return this.quote.sub_total
        },
        vat: function () {
            // Multiply subtotal by 20% for VAT
            this.quote.vat = (Number(this.subTotal) * 0.2).toFixed(2);
            return this.quote.vat
        },
        total: function () {
            // Adds VAT to subtotal and returns total
            this.quote.total = (Number(this.subTotal) + Number(this.vat)).toFixed(2);
            return this.quote.total
        }
    },
    methods: {
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

                // Save customer details and totals
                this.$axios.put(`/api/quotes/update/${this.$route.params.id}`, this.quote)
                    .then(response => {
                        alert(response.data);
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
