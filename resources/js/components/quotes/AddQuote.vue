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
                        <input id="aqfname"
                               type="text"
                               class="form-control brandTextField"
                               placeholder="Enter clients first name..."
                               v-model="quote.first_name">
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-2" for="aqlname">Last Name</label>
                    <div class="col-sm-10">
                        <input id="aqlname"
                               type="text"
                               class="form-control brandTextField"
                               placeholder="Enter clients last name..."
                               v-model="quote.last_name">
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-2" for="aqemail">Email</label>
                    <div class="col-sm-10">
                        <input id="aqemail"
                               type="text"
                               class="form-control brandTextField"
                               placeholder="Enter clients email address..."
                               v-model="quote.email">
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-2" for="aqaddress">Address</label>
                    <div class="col-sm-10">
                        <input id="aqaddress"
                               type="text"
                               class="form-control brandTextField"
                               placeholder="Enter clients delivery address..."
                               v-model="quote.address">
                    </div>
                </div>
                <div v-if="errors" class="pt-3">
                    <div v-for="(v, k) in errors" :key="k">
                        <p class="text-danger fw-bold" v-for="error in v" :key="error">
                            {{ error }}
                        </p>
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
            quote: {},
            // Validation error messages
            errors: null,
        }
    },
    methods: {
        // Saves the new quote to the DB
        addQuote() {
            this.$axios.get('/sanctum/csrf-cookie').then(response => {
                this.$axios.post('/api/quotes/add', this.quote)
                    .then(response => {
                        this.$swal({
                            toast: true,
                            position: 'bottom-end',
                            icon: 'success',
                            showConfirmButton: false,
                            timer: 3000,
                            title: response.data,
                        });
                        this.$router.push({name: 'quotes'})
                    })
                    .catch(e => {
                        this.errors = e.response.data.errors;
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
