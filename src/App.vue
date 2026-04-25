<script setup>
import AppHeader from './components/layout/AppHeader.vue'
import AppFooter from './components/layout/AppFooter.vue'
</script>

<template>
  <div class="d-flex flex-column min-vh-100">
    <AppHeader />

    <main class="flex-fill surface">
      <RouterView />
    </main>

    <AppFooter />
  </div>
</template>

<style>
:root {
  --charcoal-1: #1A1D21;
  --charcoal-2: #1C2025;
  --charcoal-3: #1D2126;
}

@font-face {
  font-family: "Fira Sans";
  src: url("@/assets/fonts/FiraSans-Black.ttf") format("truetype");
}

body {
  background: var(--charcoal-1) !important;
}

.surface {
  background: var(--charcoal-2) !important;
}

.surface-alt {
  background: var(--charcoal-3) !important;
}

.title-text {
  color: whitesmoke;
  font-family: "Fira Sans";
  text-decoration: none;
}
</style>