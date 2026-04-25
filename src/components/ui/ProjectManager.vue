<script setup>
import { ref, onMounted } from 'vue'

const projects = ref([])
const form = ref({ title: null, displayOrder: null })
const isEditing = ref(false)

onMounted(async () => {
    await loadProjects()
})

async function loadProjects() {
    const res = await fetch('/api/projects', { credentials: 'include' })
    projects.value = await res.json()
}

async function createProject() {
    await fetch('/api/projects', {
        method: 'POST',
        credentials: 'include',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ title: form.value.title, displayOrder: form.value.displayOrder })
    })

    await loadProjects()
}

async function updateProject() {
    await fetch(`/api/projects/${form.value.id}`, {
        method: 'PUT',
        credentials: 'include',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ title: form.value.title, displayOrder: form.value.displayOrder })
    })

    await loadProjects()
}

async function deleteProject(id) {
    await fetch(`/api/projects/${id}`, {
        method: 'DELETE',
        credentials: 'include'
    })

    await loadProjects()
}

function openCreate() {
    let projectNumber = projects.value.length + 1
    form.value = { title: 'New Project ' + projectNumber, displayOrder: projectNumber }
    isEditing.value = false
}

function openEdit(project) {
    form.value = { ...project }
    isEditing.value = true
}
</script>

<template>
    <div class="card p-4">

        <div class="d-flex justify-content-between">
            <h5>Projects</h5>
            <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#projectModal"
                @click="openCreate">
                Create Project
            </button>
        </div>

        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Title</th>
                    <th>Display Order</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="p in projects" :key="p.id">
                    <td>{{ p.title }}</td>
                    <td>{{ p.displayOrder }}</td>
                    <td class="text-end">
                        <button class="btn btn-sm btn-outline-warning" data-bs-toggle="modal"
                            data-bs-target="#projectModal" @click="openEdit(p)">
                            Update
                        </button>
                        <button class="btn btn-sm btn-outline-danger" @click="deleteProject(p.id)">
                            Delete
                        </button>
                    </td>
                </tr>
            </tbody>
        </table>

    </div>

    <!-- TODO: move to seperate .vue file in /ui/modals -->
    <div class="modal" id="projectModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        {{ isEditing ? 'Update Project' : 'Create Project' }}
                    </h5>
                    <button class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">
                    <input class="form-control" placeholder="Title" v-model="form.title" />
                    <input class="form-control" placeholder="Display Order" v-model="form.displayOrder" />
                </div>

                <div class="modal-footer">
                    <button class="btn btn-success" data-bs-dismiss="modal"
                        @click="isEditing ? updateProject() : createProject()">
                        {{ isEditing ? 'Update' : 'Create' }}
                    </button>
                </div>
            </div>
        </div>
    </div>
</template>
