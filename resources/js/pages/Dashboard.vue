<template>
    <div class="d-flex align-items-center">
        <h1 class="text-center w-100 mt-5 pt-5">Welcome {{ name }}</h1>
    </div>
</template>

<script>
export default {
    name: "Dashboard",
    data() {
        return {
            name: null,
        }
    },
    created() {
        if (window.Laravel.user) {
            this.name = window.Laravel.user.name
            this.$swal({
                toast: true,
                position: 'bottom-end',
                icon: 'success',
                showConfirmButton: false,
                timer: 3000,
                title: 'Logged In',
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
