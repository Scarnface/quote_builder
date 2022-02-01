<template>
    <div>
        <h4 class="text-center">All Quotes</h4><br/>

        <button type="button" class="btn btn-info" style="margin-bottom: 1rem" @click="this.$router.push('/quotes/add')">Add Quote</button>

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
                <td>{{ quote.sub_total }}</td>
                <td>{{ quote.vat }}</td>
                <td>{{ quote.total }}</td>
                <td>
                    <div class="btn-group" role="group">
                        <router-link :to="{name: 'editquote', params: { id: quote.id }}" class="btn btn-primary">Edit</router-link>
                        <button class="btn btn-danger" @click="deleteQuote(quote.id)">Delete</button>
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
                        this.quotes.splice(i, 1)
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
