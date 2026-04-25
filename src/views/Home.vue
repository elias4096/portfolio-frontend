<script setup>
import { ref, onMounted } from 'vue'
import ProjectTextCard from '@/components/ui/ProjectTextCard.vue'
import ProjectImageCard from '@/components/ui/ProjectImageCard.vue'

const projects = ref([])

onMounted(async () => {
    loadProjects()
})

async function loadProjects() {
    const res = await fetch('/api/projects', { credentials: 'include' })
    projects.value = await res.json()
}
</script>

<template>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12 col-lg-10">

                <div class="mx-auto" style="max-width: 1000px;" v-for="(p, i) in projects">
                    <div class="row my-5 justify-content-center">

                        <template v-if="i % 2 === 0">
                            <ProjectTextCard :project="p" />
                            <ProjectImageCard :project="p" />
                        </template>

                        <template v-else>
                            <ProjectImageCard :project="p" />
                            <ProjectTextCard :project="p" />
                        </template>

                    </div>
                </div>

            </div>
        </div>
    </div>
</template>
