<template>
    <header>
        <div class="container py-3 d-flex align-items-center justify-content-between">
            <a href="https://github.com/elias4096" class="link-item">
                <img src="@/assets/icons/GitHub_Invertocat_White.svg" height="32" alt="GitHub" />
            </a>

            <RouterLink to="/" class="fs-2 text-white text-decoration-none link-item">
                Elias Detlefsen
            </RouterLink>

            <RouterLink to="/admin" class="fs-5 text-white text-decoration-none link-item">
                Admin
            </RouterLink>
        </div>
    </header>
</template>

<style scoped>
.link-item {
    font-family: "Fira Sans";
}

.link-item:hover {
    filter: invert(25%);
}
</style>
