<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'

// Todo: display message when response != ok.

const router = useRouter()
const email = ref('')
const password = ref('')

async function onLogin() {
    const response = await fetch('/api/auth/login', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            email: email.value,
            password: password.value
        })
    })

    if (!response.ok) {
        return
    }

    router.replace('/admin')
}
</script>

<template>
    <div class="container my-5 d-flex justify-content-center align-items-center">
        <div class="card p-4 w-100" style="max-width: 400px;">
            <form @submit.prevent="onLogin">
                <h1 class="text-center">Admin Login</h1>

                <div class="form-group my-2">
                    <input type="email" class="form-control" placeholder="Email" v-model="email" required>
                </div>

                <div class="form-group my-2">
                    <input type="password" class="form-control" placeholder="Password" v-model="password" required>
                </div>

                <button type="submit" class="btn btn-secondary w-100">Login</button>
            </form>
        </div>
    </div>
</template>
