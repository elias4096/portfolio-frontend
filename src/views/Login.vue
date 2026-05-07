<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { apiFetch } from '@/api/ApiFetch.js'
import Base from './Base.vue'

const router = useRouter()

const userEmail = ref('')
const userPassword = ref('')
const errorMessage = ref(null)

async function login() {
    errorMessage.value = null

    try {
        await apiFetch('/api/auth/login', {
            method: 'POST',
            body: JSON.stringify({
                email: userEmail.value,
                password: userPassword.value,
            }),
        })

        router.replace('/admin')
    } catch (error) {
        if (error?.message) {
            errorMessage.value = error.message
        }
    }
}
</script>

<template>
    <Base>
        <div class="col-4">
            <div class="card p-4">
                <form @submit.prevent="login">
                    <h1 class="text-center">Admin Login</h1>

                    <div v-if="errorMessage" class="alert alert-danger my-2 text-center" role="alert">
                        {{ errorMessage }}
                    </div>

                    <div class="form-group my-2">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" placeholder="Email" v-model="userEmail" required>
                    </div>

                    <div class="form-group my-2">
                        <label class="form-label">Password</label>
                        <input type="password" class="form-control" placeholder="Password" v-model="userPassword"
                            required>
                    </div>

                    <button type="submit" class="btn btn-secondary w-100">Login</button>
                </form>
            </div>
        </div>
    </Base>
</template>
