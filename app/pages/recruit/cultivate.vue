<template>
    <section>
        <CiSubMenu />
        <div class="container py50px ma px10px">
            <h3 class="mb10px text-18px font-bold">
                {{ $lang(comData?.title, comData?.title_en) }}
            </h3>
            <div class="min-h-300px pb50px" v-html="$lang(comData?.content, comData?.content_en)" />
        </div>
    </section>
</template>

<script lang="ts" setup>
import type { Prisma } from '@prisma/client'
const { $lang } = useNuxtApp()
definePageMeta({
    layout: 'home',
})

const { data } = await useCustomFetch<Prisma.OtherMaxAggregateOutputType>('/api/v1/page/other', {
    params: {
        type: 'recruit-cultivate',
    },
})
const comData = data.value?.data
</script>

<style lang="scss" scoped></style>
