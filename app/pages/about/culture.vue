<template>
    <section>
        <CiSubMenu />
        <article class="container ma px10px py50px text-16px min-h200px">
            <div v-html="$lang(comData?.content, comData?.content_en)" />
</article>
    </section>
</template>

<script lang="ts" setup>
import type { Other } from '@prisma/client'

const { $lang } = useNuxtApp()

definePageMeta({
    layout: 'home',
})
const { data } = await useCustomFetch<Other>('/api/v1/page/other', {
    params: {
        type: 'culture',
    },
})

const comData=data.value?.data

</script>

<style lang="scss" scoped></style>
