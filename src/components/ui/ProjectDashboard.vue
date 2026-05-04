<script setup>
import { ref, onMounted } from 'vue'

const projects = ref([])
const isEditing = ref(false)

const form = ref({
    id: null,
    displayOrder: null,
    markdown: '',
    imageUuid: null,
    file: null
})

onMounted(loadProjects)

async function loadProjects() {
    const res = await fetch('/api/projects', { credentials: 'include' })
    projects.value = await res.json()
}

async function maybeCreateImage() {
    if (!form.value.file) return null
    return await createImage()
}

async function createProject() {
    let imageUuid = null

    try {
        imageUuid = await maybeCreateImage()
    } catch { }

    await fetch('/api/projects', {
        method: 'POST',
        credentials: 'include',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            displayOrder: form.value.displayOrder,
            markdown: form.value.markdown,
            imageUuid
        })
    })

    await loadProjects()
}

async function updateProject() {
    let imageUuid = form.value.imageUuid

    try {
        const uploaded = await maybeCreateImage()
        if (uploaded) imageUuid = uploaded
    } catch { }

    await fetch(`/api/projects/${form.value.id}`, {
        method: 'PUT',
        credentials: 'include',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            displayOrder: form.value.displayOrder,
            markdown: form.value.markdown,
            imageUuid
        })
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

async function createImage() {
    const res = await fetch('/api/images', {
        method: 'POST',
        headers: { 'Content-Type': 'image/png' },
        body: form.value.file
    })

    if (!res.ok) throw new Error('Image upload failed')
    return await res.text()
}

function openCreate() {
    form.value = {
        id: null,
        displayOrder: projects.value.length + 1,
        markdown: '',
        imageUuid: null,
        file: null
    }
    isEditing.value = false
}

function openEdit(project) {
    form.value = {
        id: project.id,
        displayOrder: project.displayOrder,
        markdown: project.markdown,
        imageUuid: project.imageUuid,
        file: null
    }
    isEditing.value = true
}

function onFileChange(event) {
    form.value.file = event.target.files[0] || null
}
</script>


<template>
    <div class="card p-4">

        <div class="d-flex justify-content-between">
            <h5>Projects</h5>
            <button class="btn btn-sm btn-success" data-bs-toggle="modal" data-bs-target="#projectModal"
                @click="openCreate">
                Create Project
            </button>
        </div>

        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Display Order</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="p in projects" :key="p.id">
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
                    <div class="mb-3">
                        <label class="form-label">Display Order</label>
                        <input type="number" class="form-control" v-model.number="form.displayOrder" step="1" min="0" />
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Markdown</label>
                        <textarea class="form-control form-control-lg" v-model="form.markdown" rows="8"></textarea>
                    </div>

                    <input type="file" accept="image/png" @change="onFileChange" />
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
