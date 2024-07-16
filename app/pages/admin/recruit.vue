<script setup lang="ts">
import OtherIndex from './components/OtherIndex.vue'
definePageMeta({
    layout: 'admin',
    title: '人才招聘',
    icon: 'i-ep-list',
    sort: 25,
    // fixed: true,
    // isAffix: true,
})

</script>

<template>
    <OtherIndex type="recruit" />
</template>

<style scoped lang="scss">

</style>

