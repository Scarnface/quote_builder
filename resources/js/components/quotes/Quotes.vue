<template>
    <div class="card card-default">
        <div class="card-header">
            <h4 class="brandText mb-0">All Quotes</h4>
        </div>
        <div class="card-body">
            <button type="button" class="btn brandButton mb-3" @click="this.$router.push('/quotes/add')">Create New Quote</button>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Email</th>
                        <th>Address</th>
                        <th>Sub Total</th>
                        <th>Vat</th>
                        <th>Total</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="quote in quotes" :key="quote.id">
                        <td>{{ quote.first_name }}</td>
                        <td>{{ quote.last_name }}</td>
                        <td>{{ quote.email }}</td>
                        <td>{{ quote.address }}</td>
                        <td>£{{ quote.sub_total }}</td>
                        <td>£{{ quote.vat }}</td>
                        <td>£{{ quote.total }}</td>
                        <td class="d-flex justify-content-around">
                            <router-link class="btn brandButton btn-sm" :to="{name: 'editquote', params: { id: quote.id }}">Edit</router-link>
                            <button class="btn brandButton btn-sm" @click="sendQuoteEmail(quote.id)">Email Quote</button>
                            <button class="btn btn-danger btn-sm" @click="deleteQuote(quote.id)">Remove</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <router-link :to="{name: 'dashboard'}" class="text-xl fw-bold brandText">&#60;&#60;&#60; Go Back</router-link>
</template>

<script>
export default {
    data() {
        return {
            quotes: []
        }
    },
    created() {
        this.$axios.get('/sanctum/csrf-cookie').then(response => {
            this.$axios.get('/api/quotes')
                .then(response => {
                    this.quotes = response.data;
                })
                .catch(function (error) {
                    console.error(error);
                });
        })
    },
    methods: {
        deleteQuote(id) {
            this.$axios.get('/sanctum/csrf-cookie').then(response => {
                this.$axios.delete(`/api/quotes/delete/${id}`)
                    .then(response => {
                        let i = this.quotes.map(item => item.id).indexOf(id);
                        this.quotes.splice(i, 1);
                    })
                    .catch(function (error) {
                        console.error(error);
                    });
            })
        },
        sendQuoteEmail(id) {
            this.$axios.get('/sanctum/csrf-cookie').then(response => {
                this.$axios.get(`/api/send/${id}`)
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
