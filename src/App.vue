<script setup>
import AppFooter from './components/layout/AppFooter.vue';
import AppHeader from './components/layout/AppHeader.vue';
</script>

<template>
  <div class="app">
    <AppHeader />

    <main class="content">
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

* {
  margin: 0;
  padding: 0;
  font-family: "Fira Sans";
}

.app {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.content {
  flex: 1;
}
</style>
