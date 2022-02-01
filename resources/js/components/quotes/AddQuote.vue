<template>
    <div>
        <h4 class="text-center">Add Quote</h4>
        <div class="row">
            <div class="col-md-6">
                <form @submit.prevent="addQuote">
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
                    <button type="submit" class="btn btn-primary">Add Quote</button>
                </form>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            // The specific quote to be added
            quote: {}
        }
    },
    methods: {
        // Saves the new quote to the DB
        addQuote() {
            this.$axios.get('/sanctum/csrf-cookie').then(response => {
                this.$axios.post('/api/quotes/add', this.quote)
                    .then(response => {
                        this.$router.push({name: 'quotes'})
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
