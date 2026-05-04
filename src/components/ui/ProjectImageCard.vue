<script setup>
const props = defineProps({
    project: {
        type: Object,
        required: true
    }
})
</script>

<template>
    <div class="col-12 col-md-6 d-flex justify-content-center align-items-center">
        <div class="card p-4 w-100 surface-alt rounded-5" style="max-width: 500px;">
            <img v-if="project.imageUuid" :src="`/api/images/${project.imageUuid}`" class="img-fluid" alt="">
        </div>
    </div>
</template>
