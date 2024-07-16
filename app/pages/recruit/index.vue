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

        <div class="bg-#f2f6f9 py50px">
            <ul class="container ma px10px grid gap20px">
                <ClientOnly>
                    <li v-for="item in list" :key="item.id" class="bg-#fff">
                        <div class="flex justify-between items-center h-80px px30px cursor-pointer  text-20px"
                            :class="{ 'zp-active': item.id === active }" @click="onToggleItem(item)">
                            <p class="w50%">{{ $lang(item.title, item.title_en) }}</p>
                            <p>{{ $lang('招聘人数', 'Recruiting Numbers') }}：{{ item.people }}</p>
                            <p>{{ $lang('工作地点', 'Work location') }}：{{ $lang(item.address, item.address_en) }}</p>
                            <figure
                                class="flex items-center justify-center bg-#eee w25px h25px b-rounded-50% overflow-hidden">
                                <img :src="systemInfo?.logo || ''">
                            </figure>
                        </div>
                        <div v-if="item.id === active" class="p40px text-16px">
                            <div class="flex justify-between">
                                <div class="w45%" v-html="$lang(item.describe, item.describe_en)" />
                                <div class="w45%" v-html="$lang(item.content, item.content_en)" />
                            </div>
                        </div>
                    </li>
                </ClientOnly>
            </ul>
        </div>

        <!-- 说明 -->
        <div class="container ma px10px">
            <div class="flex justify-between  py50px">
                <div class="state_list">
                    <h3 class="text-16px c-[--ci-main-color] mb8px font-bold">
                        {{ $lang('简历请投至', 'Please submit your resume to') }}
                    </h3>
                    <p class="c-#888">
                        {{ $lang('邮箱', 'Email') }}：{{ systemInfo?.email }}
                    </p>
                </div>
                <div class="state_list">
                    <h3 class="text-16px c-[--ci-main-color] mb8px font-bold">
                        {{ $lang('联系电话', 'Telephone') }}
                    </h3>
                    <p class="c-#888">
                        {{ $lang('客服热线', 'Hotline') }}：{{ systemInfo?.phone }}
                    </p>
                    <!-- <p class="c-#888">
                        {{ $lang('服务热线', 'Service hotline') }}：{{ systemInfo?.phone2 }}
                    </p> -->
                </div>
                <div class="state_list">
                    <h3 class="text-16px c-[--ci-main-color] mb8px font-bold">
                        {{ $lang('联系地址', 'Address') }}
                    </h3>
                    <p class="c-#888">
                        {{ $lang(systemInfo?.address, systemInfo?.address_en) }}
                    </p>
                </div>
                <div class="state_list">
                    <h3 class="text-16px c-[--ci-main-color] mb8px font-bold">
                        {{ $lang('我们的近况', 'Our current situation') }}
                    </h3>
                    <NuxtLinkLocale to="/news" class="c-#888">
                        {{ $lang('了解更多', 'Learn more') }} >>
                    </NuxtLinkLocale>
                </div>
            </div>
        </div>
    </section>
</template>

<script lang="ts" setup>
import type { Other, Recruit } from '@prisma/client'
const { $lang } = useNuxtApp()

definePageMeta({
    layout: 'home',
})
const { systemInfo } = await useSystemState()
const { data } = await useCustomFetch<Other>('/api/v1/page/other', {
    params: {
        type: 'recruit-person',
    },
})

const comData = data.value?.data

const { data: recruit } = await useCustomFetch<{ list: Recruit[] }>('/api/v1/page/recruit', {
    params: {
        status: 1, // 1：启用，2：禁用
    },
})

const list: Recruit[] = recruit.value?.data?.list || []

const active = ref(0)

const onToggleItem = (item: Recruit) => {
    if (item.id === active.value) active.value = 0
    else active.value = item.id
}
</script>

<style lang="scss" scoped>
.zp-active {
    background-color: var(--co-main-color);
    color: #fff;
}
</style>
