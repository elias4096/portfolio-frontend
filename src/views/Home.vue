<script setup>
import { ref, onMounted } from 'vue'
import { apiFetch } from '@/api/ApiFetch.js'
import Base from './Base.vue'
import ProjectTextCard from '@/components/ui/ProjectTextCard.vue'
import ProjectImageCard from '@/components/ui/ProjectImageCard.vue'

const projects = ref([])
const loading = ref(true)
const error = ref(null)

onMounted(() => {
    readProjects()
})

async function readProjects() {
    try {
        projects.value = await apiFetch('/api/projects')
    } catch {
        projects.value = []
        error.value = 'Failed to load projects.'
    } finally {
        loading.value = false
    }
}
</script>

<template>
    <Base :loading="loading" :error="error">
        <div class="col-10">
            <div v-for="(p, i) in projects">
                <div class="row">
                    <component :is="i % 2 === 0 ? ProjectTextCard : ProjectImageCard" :project="p" />
                    <component :is="i % 2 === 0 ? ProjectImageCard : ProjectTextCard" :project="p" />
                </div>
            </div>
        </div>
    </Base>
</template>
