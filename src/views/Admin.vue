<script setup>
import { onMounted, ref } from 'vue'
import { useRouter } from 'vue-router'
import { apiFetch } from '@/api/ApiFetch'
import Base from './Base.vue'
import ProjectDashboard from '@/components/ui/ProjectDashboard.vue'

const router = useRouter()

const user = ref(null)
const loading = ref(true)

onMounted(() => {
    me()
})

async function me() {
    try {
        user.value = await apiFetch('/api/auth/me')
    } catch (error) {
        if (error?.message) {
            console.error(error)
        }

        router.replace('/login')
    } finally {
        loading.value = false
    }
}

async function logout() {
    try {
        await apiFetch('/api/auth/logout', { method: 'POST' })
    } catch (error) {
        if (error?.message) {
            console.error(error)
        }
    } finally {
        router.replace('/login')
    }
}
</script>

<template>
    <Base :loading="loading">
        <div class="col-10">
            <div v-if="user" class="card p-4">
                <div class="d-flex justify-content-between">
                    <h5>Admin Dashboard</h5>
                    <button class="btn btn-sm btn-outline-danger" @click="logout">Logout</button>
                </div>

                <p>Logged in as <strong>{{ user.email }}</strong></p>

                <ProjectDashboard></ProjectDashboard>
            </div>
        </div>
    </Base>
</template>
