<template>
    <section>
        <!-- 分类 -->
        <CiSubMenu :value="news?.type" />
        <div class="container ma px10px py50px">
            <article class="news-detail">
                <h1 class="news-title text-26px text-center">
                    {{ $lang(news?.title, news?.title_en) }}
                </h1>
                <div class="flex justify-center gap-30px c-[#888] pt20px">
                    <span>{{ formatTime(new Date(news!.createdAt), 'YYYY-mm-dd') }}</span>
                    <span>{{ $lang('作者', 'Author') }}: {{ news?.author }}</span>
                </div>
                <div class="news-cont min-h200px py20px" v-html="$lang(news?.content, news?.content_en)" />
                <div class="text-right ">
                    <NuxtLinkLocale :to="`/news${news?.type === 2 ? '/industry' : ''}`"
                        class="inline-block min-w110px bg-[--ci-main-color] c-[#fff] p10px text-center">
                        {{ $lang('返回列表', 'Go Back') }}
                    </NuxtLinkLocale>
                </div>
            </article>
            <ul class="pt30px mt30px b-t-1px b-[#ddd]">

                <li class="line-height-30px">
                    <!-- <a target="" href="/home/News/detail/id/94?lang=zh-Hans">上一篇: 鹰测技术2024年春节放假安排</a> -->
                    <NuxtLinkLocale v-if="prevNews?.id" :to="`/news/${prevNews?.id}`" class="hover:c-[--ci-main-color]">
                        <!-- {{ $t('prev') }} -->
                        {{ $lang('上一篇', 'Prev') }}： {{ $lang(prevNews?.title, prevNews?.title_en) }}
                    </NuxtLinkLocale>
                    <span v-else>
                        <!-- {{ $t('prev') }}：{{ $t('none') }} -->
                        {{ $lang('上一篇', 'Prev') }}：{{ $lang('无', 'none') }}
                    </span>
                </li>
                <li class="line-height-30px">
                    <NuxtLinkLocale v-if="nextNews?.id" :to="`/news/${nextNews?.id}`" class="hover:c-[--ci-main-color]">
                        <!-- {{ $t('next') }} -->
                        {{ $lang('下一篇', 'Next') }}： {{ $lang(nextNews?.title, nextNews?.title_en) }}
                    </NuxtLinkLocale>
                    <span v-else>
                        <!-- {{ $t('next') }}：{{ $t('none') }}  -->
                        {{ $lang('下一篇', 'Next') }}：{{ $lang('无', 'none') }}
                    </span>
                </li>
            </ul>

        </div>
    </section>
</template>

<script lang="ts" setup>
import type { News } from '@prisma/client'
import { formatTime } from '@cooj/utils'

const { $lang } = useNuxtApp()
definePageMeta({
    layout: 'home',
})

const id = useRouteParam('id')

const { data } = await useCustomFetch<Record<'nextNews' | 'prevNews' | 'data', News>>('/api/v1/page/news/detail', {
    params: {
        id: id.value,
        // type: props.type,
    },
})
if (!data.value) {
    showErrorPage()
}

const news = data.value?.data.data
const nextNews = data.value?.data.nextNews
const prevNews = data.value?.data.prevNews
</script>
