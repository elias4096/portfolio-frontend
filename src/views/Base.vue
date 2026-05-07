<script setup>
defineProps({
    loading: Boolean,
    error: String,
})
</script>

<template>
    <div class="container my-5">

        <div v-if="loading" class="d-flex justify-content-center">
            <div class="spinner-border"></div>
        </div>

        <div v-else-if="error" class="d-flex justify-content-center">
            <div class="alert alert-danger text-center">
                {{ error }}
            </div>
        </div>

        <div v-else class="row justify-content-center">
            <slot></slot>
        </div>

    </div>
</template>
