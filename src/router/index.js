import Admin from "@/views/Admin.vue";
import Home from "@/views/Home.vue";
import Login from "@/views/Login.vue";
import { createRouter, createWebHistory } from "vue-router";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    { path: "/", component: Home },
    { path: "/login", component: Login },
    { path: "/admin", component: Admin },
  ],
});

export default router;
