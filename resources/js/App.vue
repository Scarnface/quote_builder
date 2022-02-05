<template>
    <div class="container">
        <div class="d-flex justify-content-center my-4">
            <img class="w-50" style="height: 5rem; object-fit: cover;" src="/images/logo/vector/default.svg" alt="Quote Builder Logo"><br>
        </div>

        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="collapse navbar-collapse">
                <!-- for logged-in user-->
                <div class="navbar-nav w-100" v-if="isLoggedIn">
                    <router-link to="/dashboard" class="h3 mb-0 nav-item nav-link">Dashboard</router-link>
                    <router-link to="/quotes" class="h3 mb-0 nav-item nav-link">Quotes</router-link>
                    <router-link to="/products" class="h3 mb-0 nav-item nav-link">Products</router-link>
                    <a class="h3 mb-0 nav-item nav-link ms-auto" style="cursor: pointer;" @click="logout">Logout</a>
                </div>
                <!-- for non-logged in user-->
                <div class="navbar-nav" v-else>
                    <router-link to="/login" class="h3 mb-0 nav-item nav-link">Login</router-link>
                    <router-link to="/register" class="h3 mb-0 nav-item nav-link">Register</router-link>
                </div>
            </div>
        </nav>
        <router-view/>
    </div>
</template>

<script>
export default {
    name: "App",
    data() {
        return {
            isLoggedIn: false,
        }
    },
    created() {
        if (window.Laravel.isLoggedin) {
            this.isLoggedIn = true
        }
    },
    methods: {
        logout(e) {
            this.$swal({
                title: 'Are you sure you want to logout?',
                confirmButtonColor: "#df4759",
                showCancelButton: true,
                confirmButtonText: 'Logout',
            }).then((result) => {
                if (result.isConfirmed) {
                    e.preventDefault()
                    this.$axios.get('/sanctum/csrf-cookie').then(response => {
                        this.$axios.post('/api/logout')
                            .then(response => {
                                if (response.data.success) {
                                    window.location.href = "/"
                                } else {
                                    console.log(response)
                                }
                            })
                            .catch(function (error) {
                                console.error(error);
                            });
                    })
                }
            })
        },
    },
}
</script>
