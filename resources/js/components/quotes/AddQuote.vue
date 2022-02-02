<template>
    <div class="card card-default">
        <div class="card-header">
            <h4 class="brandText mb-0">Create New Quote</h4>
        </div>
        <div class="card-body">
            <form @submit.prevent="addQuote">
                <div class="row mb-3">
                    <label class="col-sm-2" for="aqfname">First Name</label>
                    <div class="col-sm-10">
                        <input id="aqfname" type="text" class="form-control brandTextField" v-model="quote.first_name">
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-2" for="aqlname">Last Name</label>
                    <div class="col-sm-10">
                        <input id="aqlname" type="text" class="form-control brandTextField" v-model="quote.last_name">
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-2" for="aqemail">Email</label>
                    <div class="col-sm-10">
                        <input id="aqemail" type="text" class="form-control brandTextField" v-model="quote.email">
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-2" for="aqaddress">Address</label>
                    <div class="col-sm-10">
                        <input id="aqaddress" type="text" class="form-control brandTextField" v-model="quote.address">
                    </div>
                </div>
                <button type="submit" class="btn brandButton mt-3">Create Quote</button>
            </form>
        </div>
    </div>
    <router-link :to="{name: 'quotes'}" class="text-xl fw-bold brandText">&#60;&#60;&#60; Go Back</router-link>
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
