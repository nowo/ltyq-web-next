<template>
    <section>
        <CiSubMenu />
        <div class="container ma px10px text-16px">
            <!-- 关于我们 -->
            <article class="py50px">
                <div class="mb30px">
                    <h3 class="text-center text-32px font-bold">
                        {{ $lang(comData?.title, comData?.title_en) }}
                    </h3>
                    <div class="line-icon">
                    </div>
                </div>
                <div class="about_box">
                    <figure v-if="comData?.img" class="about-img">
                        <!-- <img src="static/picture/厂房效果图.jpg"> -->
                        <img :src="comData?.img || ''">
                    </figure>
                    <h1 class="about_title font-bold">
                        {{ $lang(systemInfo?.company, systemInfo?.company_en) }}
                    </h1>
                    <div class="about_content" v-html="$lang(comData?.content, comData?.content_en)" />
                </div>
            </article>

        </div>
        <div class="about-banner">
            <div class="container ma px">

                <Swiper :modules="[SwiperNavigation, SwiperPagination]" :slides-per-view="1" navigation>
                    <SwiperSlide v-for="(item, idx) in photoList" :key="idx" class="w100%">
                        <img class="w100%" :src="item.img" :alt="item.title">
                    </SwiperSlide>
                </Swiper>
            </div>
        </div>
    </section>
</template>

<script lang="ts" setup>
import type { Prisma, Link, Other } from '@prisma/client'


const { $lang } = useNuxtApp()

definePageMeta({
    layout: 'home',
})
const { systemInfo } = await useSystemState()
const { data } = await useCustomFetch<Other>('/api/v1/page/other', {
    params: {
        type: 'about',
    },
})

const comData = data.value?.data

const { data: photo } = await useCustomFetch<{ list: Link[] }>('/api/v1/page/link', {
    method: 'post',
    body: {
        type: 9,
        isPage: 1,
    },
})

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
</script>

<style lang="scss" scoped>
// @import url('@/assets/css/about.css');
.about-img {
    width: 32.875rem;
    float: left;
    margin: 0 2.5rem 2.5rem 0;
    position: relative;

    &:after {
        position: absolute;
        left: -5rem;
        bottom: -2.125rem;
        content: '';
        width: 15.75rem;
        height: 15.75rem;
        background-color: var(--co-main-color);
        z-index: -1;
    }
}

.about-banner {
    background-image: url(@/assets/image/home_bg.png);
    background-size: cover;
    background-position: center center;
    background-repeat: no-repeat;
    padding: 60px 0;

    :deep(.swiper) {

        .swiper-button-prev,
        .swiper-button-next {
            width: 50px;
            height: 50px;
            background-color: var(--ci-main-color);
            color: #fff;
            border-radius: 50%;

            &::after {
                font-size: 20px;
            }
        }
    }


}
</style>
