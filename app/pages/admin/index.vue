<script setup lang="ts">
import OtherIndex from './components/OtherIndex.vue'
definePageMeta({
    layout: 'admin',
    title: '后台主页',
    icon: 'i-ep-home-filled',
    sort: -999,
    fixed: true,
    isAffix: true,
})

</script>

<template>
    <OtherIndex type="banner" />
</template>

<style scoped lang="scss">

</style>

