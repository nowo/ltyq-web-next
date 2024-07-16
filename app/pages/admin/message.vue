<script setup lang="ts">
import OtherIndex from './components/OtherIndex.vue'
definePageMeta({
    layout: 'admin',
    title: '客户留言',
    icon: 'i-ep-chat-line-square',
    sort: 50,
    // fixed: true,
    // isAffix: true,
})

</script>

<template>
    <OtherIndex type="message" />
</template>

<style scoped lang="scss">

</style>

