<template>
    <header>
        <div class="container py-3 d-flex justify-content-between align-items-center">
            <a href="https://github.com/elias4096" class="title-text">
                <img src="@/assets/icons/github.svg" height="32" alt="GitHub" />
            </a>

            <RouterLink to="/" class="fs-2 title-text">
                Elias Detlefsen
            </RouterLink>

            <RouterLink to="/admin" class="title-text">
                <img src="@/assets/icons/account.svg" height="32" alt="Account" />
            </RouterLink>
        </div>
    </header>
</template>

<style scoped>
.title-text:hover {
    filter: invert(25%);
}
</style>
