<script setup>
import { ref, onMounted } from 'vue'
import { apiFetch } from '@/api/ApiFetch'
import { VueDraggableNext } from 'vue-draggable-next'
import Base from '@/views/Base.vue'

const projects = ref([])
const loading = ref(true)
const error = ref(null)

onMounted(readProjects)

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

async function onReorder() {
    const reordered = projects.value.map((p, index) => ({
        id: p.id,
        displayOrder: index
    }))

    try {
        await apiFetch('/api/projects/reorder', {
            method: 'POST',
            body: JSON.stringify(reordered),
        })
    } catch {
        error.value = 'Failed to reorder projects.'
    }
}
</script>

<template>
    <Base :loading="loading" :error="error">
        <table class="table">
            <thead>
                <tr>
                    <th>Order</th>
                    <th>Markdown</th>
                    <th>Manage</th>
                </tr>
            </thead>

            <VueDraggableNext v-model="projects" tag="tbody" handle=".drag-handle" @change="onReorder">
                <tr v-for="p in projects" :key="p.id">
                    <td class="drag-handle">☰</td>
                    <td>{{ p.markdown }}</td>
                    <td class="text-end">
                        <button class="btn btn-outline-warning mx-1">Update</button>
                        <button class="btn btn-outline-danger mx-1">Delete</button>
                    </td>
                </tr>
            </VueDraggableNext>
        </table>
    </Base>
</template>

<style>
.drag-handle {
    cursor: grab;
}
</style>
