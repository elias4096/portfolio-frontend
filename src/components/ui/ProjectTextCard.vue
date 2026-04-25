<script setup>
import { computed } from 'vue'
import MarkdownIt from 'markdown-it'

const markdown = new MarkdownIt({
    html: false,
    linkify: true,
    breaks: true
})

const props = defineProps({
    project: {
        type: Object,
        required: true
    }
})

const renderedMarkdown = computed(() => {
    if (!props.project || !props.project.markdown) {
        return markdown.render("# Markdown not found.")
    }

    return markdown.render(props.project.markdown)
})
</script>

<template>
    <div class="col-12 col-md-6 d-flex justify-content-center align-items-center">
        <div class="card p-4 w-100 bg-transparent border-0" style="max-width: 500px;">
            <div v-html="renderedMarkdown"></div>
        </div>
    </div>
</template>
