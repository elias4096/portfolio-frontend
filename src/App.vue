<script setup>
import AppFooter from './components/layout/AppFooter.vue'
import AppHeader from './components/layout/AppHeader.vue'
</script>

<template>
  <div class="d-flex flex-column min-vh-100 c-bg-darkest">
    <AppHeader />

    <main class="flex-fill c-bg-dark">
      <RouterView />
    </main>

    <AppFooter />
  </div>
</template>

<style>
@font-face {
  font-family: "Fira Sans";
  src: url("@/assets/fonts/FiraSans-Black.ttf") format("truetype");
}

.c-bg-dark {
  background-color: rgb(50, 50, 50);
}

.c-bg-darkest {
  background-color: rgb(25, 25, 25);
}
</style>