<script setup>
import { onMounted, ref } from 'vue'
import { useRouter } from 'vue-router'
import ProjectManager from '@/components/ui/ProjectManager.vue'

const router = useRouter()
const email = ref(null)

onMounted(async () => {
    login()
})

async function login() {
    try {
        const res = await fetch('/api/auth/me', {
            credentials: 'include'
        })

        if (!res.ok) {
            router.replace('/login')
            return
        }

        const data = await res.json()
        email.value = data.email
    } catch {
        router.replace('/login')
    }
}

async function logout() {
    try {
        await fetch('/api/auth/logout', {
            method: 'POST',
            credentials: 'include'
        })
    } finally {
        router.replace('/login')
    }
}
</script>

<template>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12 col-md-8">

                <div v-if="email" class="card p-4">
                    <div class="d-flex justify-content-between">
                        <h5>Admin Panel</h5>
                        <button class="btn btn-sm btn-outline-danger" @click="logout">Logout</button>
                    </div>

                    <p>Logged in as <strong>{{ email }}</strong></p>

                    <ProjectManager></ProjectManager>
                </div>

            </div>
        </div>
    </div>
</template>