<template>
    <section>
        <CiSubMenu />
                <!-- 文章 -->
                <article class="container ma px10px flex py65px">
            <div class="w50%">
                <h1 class="text-28px c-[--ci-main-color] mb10px font-bold">
                    {{ $lang(comData?.title, comData?.title_en) }}
                </h1>
                <!-- <p class="article_subhead">
                    All rivers run into sea, is the use
                </p> -->
                <div class="text-16px" v-html="$lang(comData?.content, comData?.content_en)" />
            </div>
            <figure class="w50% pl100px">
                <img :src="comData?.img || ''" alt="">
            </figure>
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
        type: 'recruit-notice',
    },
})
const comData = data.value?.data
</script>

<style lang="scss" scoped>
</style>
