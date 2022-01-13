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

    <div>
        <h4 class="text-center">Products Included In Quote</h4><br/>

        <table class="table table-bordered">
            <thead>
            <tr>
                <th>Name</th>
                <th>Description</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="product in quote.products">
                <td>{{ product.name }}</td>
                <td>{{ product.description }}</td>
                <td>{{ product.price }}</td>
                <td>{{ product.pivot.quantity }}</td>
                <td>
                    <div class="btn-group" role="group">
                        <button class="btn btn-secondary" @click="decreaseProduct(product.pivot.id)">&nbsp;-&nbsp;</button>
                        <button class="btn btn-secondary" @click="increaseProduct(product.pivot.id)">&nbsp;+&nbsp;</button>
                        <button class="btn btn-danger" @click="deleteProduct(product.pivot.id)">Delete</button>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</template>

<script>
export default {
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
                })
                .catch(function (error) {
                    console.error(error);
                });
        })
    },
    computed: {
        subTotal: function() {
            const resultArray =  this.objToArray(this.quote.products);
            return this.calculateSubTotal(resultArray);
        },
        vat: function() {
            return Number(this.subTotal*0.2).toFixed(2);
        },
        total: function() {
            return Number(this.subTotal) + Number(this.vat);
        }
    },
    methods: {
        objToArray(obj) {
            const result = [];
            for (const prop in obj) {
                const value = obj[prop];
                if (typeof value === 'object') {
                    result.push(this.objToArray(value));
                } else {
                    result.push(value);
                }
            }
            return result
        },
        calculateSubTotal(array) {
            return array.reduce(function(a, c) {
                return a + Number((c[3]*c[4][3]) || 0)
            }, 0)
        },
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
