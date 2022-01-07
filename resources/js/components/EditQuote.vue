<template>
    <div>
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
                        <button class="btn btn-secondary" @click="decreaseProduct(productList.id)">&nbsp;-&nbsp;</button>
                        <button class="btn btn-secondary" @click="increaseProduct(productList.id)">&nbsp;+&nbsp;</button>
                        <button class="btn btn-danger" @click="deleteProduct(productList.id)">Delete</button>
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
            quote: {},
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
