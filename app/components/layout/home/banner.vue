<template>
    <div class="banner min-h-100px">
        <!-- <el-skeleton :loading="!activeMenu" animated>
            <template #template>
                <el-skeleton-item variant="image" class="h450px!" />
            </template>
</el-skeleton> -->
        <ClientOnly>
            <Swiper v-if="activeMenu?.href === '/'"
                :modules="[SwiperAutoplay, SwiperEffectCreative, SwiperNavigation, SwiperPagination]"
                :slides-per-view="1" :loop="true" :autoplay="{ delay: 8000, disableOnInteraction: true }"
                :pagination="{ clickable: true }">
                <!-- navigation effect="creative" :creative-effect="effect" -->
                <SwiperSlide v-for="(item, idx) in bannerList" :key="idx" class="w100%">
                    <NuxtLinkLocale :to="item.href" class="banner-link">
                        <img :src="item.img || ''" :alt="item.title || ''">
                    </NuxtLinkLocale>
                </SwiperSlide>
            </Swiper>

            <template v-else>
                <!-- banner图 -->
                <div class="banner_img min-h-50px">
                    <img :src="activeMenu?.img || ''" class="w100%" alt="">
                </div>

                <!-- 面包屑 -->
                <div class="container ma px10px">
                    <nav class="flex justify-end py30px <md:py20px">
                        <!-- {{ $lang('当前位置', 'Location') }}： -->
                        <ClientOnly>
                            <el-breadcrumb :separator-icon="ArrowRight" class="bread-box">
                                <el-breadcrumb-item>
                                    <i class="i-ep-home-filled mr10px inline-block align-start" />
                                    <NuxtLinkLocale to="/">
                                        <!-- {{ $t('home') }} -->
                                        {{ $lang('首页', 'Home') }}
                                    </NuxtLinkLocale>
                                </el-breadcrumb-item>
                                <el-breadcrumb-item>
                                    <NuxtLinkLocale :to="activeMenu?.href">
                                        {{ $lang(activeMenu?.title, activeMenu?.title_en) }}
                                    </NuxtLinkLocale>
                                </el-breadcrumb-item>
                            </el-breadcrumb>
                        </ClientOnly>
                    </nav>
                </div>
            </template>
        </ClientOnly>
    </div>
</template>

<script lang="ts" setup>
import type { Link } from '@prisma/client'
import { ArrowRight } from '@element-plus/icons-vue'
const { $lang } = useNuxtApp()

const { activeMenu, menuList } = await useMenuState()
// :creative-effect="{
//             prev: {
//                 shadow: false,
//                 translate: ['-20%', 0, -1]
//             },
//             next: { translate: ['100%', 0, 0] }
//         }"

// const menu = computed(() => activeMenu.value)

const effect = {
    // prev: {
    //     shadow: false,
    //     translate: ['-20%', 0, -1],
    // },
    next: { translate: ['100%', 0, 0] },
}

const { data: banner } = await useCustomFetch<{ list: Link[] }>('/api/v1/page/banner', {
    method: 'post',
    body: {
        type: 1,
        isPage: 1,
    },
})
const bannerList = banner.value?.data.list || []
</script>

<style lang="scss" scoped>
.banner {
    --swiper-theme-color: var(--co-main-color);
    --swiper-pagination-bullet-size: 12px;
}

.banner-link {
    display: block;
    width: 100%;
    // height: 600px;
    padding-bottom: 38%;
    position: relative;
    top: 0;
    left: 0;
    // padding-bottom: 30%;

    >img {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
    }
}

.bread-box {
    font-size: 16px;
    color: var(--el-text-color-regular);
    --el-text-color-primary: var(--el-text-color-regular);
}
</style>
