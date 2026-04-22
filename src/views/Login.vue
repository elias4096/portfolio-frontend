<script setup>
import { ref } from 'vue'

const email = ref('')
const password = ref('')

async function onLogin() {
    const response = await fetch('http://localhost:8080/api/auth/login', {
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
        console.error('Login failed')
        return
    }

    const data = await response.json()
    console.log('Login success:', data)
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