<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'

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
        const errorText = await response.text()
        console.error('Login failed: ', response.status, errorText)
        return
    }

    router.replace('/admin')
}
</script>

<template>
    <div class="container d-flex justify-content-center">
        <form @submit.prevent="onLogin">
            <div class="form-group my-2">
                <input type="email" class="form-control" placeholder="Email" v-model="email" required>
            </div>

            <div class="form-group my-2">
                <input type="password" class="form-control" placeholder="Password" v-model="password" required>
            </div>

            <button type="submit" class="btn btn-dark w-100">
                Login
            </button>
        </form>
    </div>
</template>