<template>
    <section>
        <CiSubMenu />

        <div class="container ma px10px">
            <div class="py50px  <md:py35px">
                <ClientOnly>
                    <h3 class="text-center text-32px  <md:text-28px">
                        {{ $lang(nowMenu?.title, nowMenu?.title_en) }}
                    </h3>
                </ClientOnly>
                <div class="line-icon">
                </div>
            </div>

            <ul class="grid gap-30px mb60px min-h200px grid-cols-4 <lg:grid-cols-3 <md:grid-cols-2">
                <li v-for="(item, index) in photoList" :key="item.id" class="certification_li">
                    <CoImage class="w100% pb137% block!" :src="item?.img || ''" :preview-src-list="srcList"
                        :initial-index="index" :alt="item?.title" />
                </li>
            </ul>
        </div>
    </section>
</template>

<script lang="ts" setup>
import type { Prisma, Link, Other } from '@prisma/client'

const { $lang } = useNuxtApp()
definePageMeta({
    layout: 'home',
})

const { data: photo } = await useCustomFetch<{ list: Link[] }>('/api/v1/page/link?type=8')
const srcList = photo.value?.data?.list?.map(item => item.img)
const photoList = computed(() => {
    let list = photo.value?.data.list || []
    let end = list.filter((item) => item.img).map(item => {
        return {
            ...item,
            img: item.img || '',
            title: item.title || ''
        }
    })
    return end
})

const { nowMenu } = await useMenuState()
</script>

<style lang="scss" scoped>
@import url('@/assets/css/about.css');
</style>
