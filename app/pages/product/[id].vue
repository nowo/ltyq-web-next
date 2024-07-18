<template>
    <section>
        <CiClassify v-if="product?.classify?.type" :id="product?.classify?.id" :type="product?.classify?.type || 1" />

        <div class="container ma px10px">
            <!-- 商品详情 -->
            <div class="flex py45px <lg:flex-wrap">
                <div class="w50% <md:w100%">
                    <ClientOnly>
                        <Swiper :thumbs="{ swiper: thumbsSwiper }" :modules="modules" class="gallery-top">
                            <SwiperSlide v-for="item in photoList" :key="item.id">
                                <CoImage class="w100% pb100% block!" :src="item.img" />
                            </SwiperSlide>
                        </Swiper>
                        <div class="gallery-base">
                            <div class="swiper-button-prev goods_btn goods_btn-left" />
                            <Swiper :space-between="10" :slides-per-view="4" :free-mode="true"
                                :watch-slides-progress="true" :modules="modules" :navigation="navigation"
                                class="gallery-thumbs" @swiper="setThumbsSwiper">
                                <SwiperSlide v-for="item in photoList" :key="item.id">
                                    <CoImage class="w100% pb100% block!" :src="item.img" />
                                    <!-- <img src="https://swiperjs.com/demos/images/nature-1.jpg"> -->
                                </SwiperSlide>
                            </Swiper>
                            <div class="swiper-button-next goods_btn goods_btn-right" />
                        </div>
                    </ClientOnly>
                </div>
                <div class="w50% pl40px  <md:w100%  <md:pl0 <md:pt20px">
                    <h1 class="goods-name">
                        {{ $lang(product?.title, product?.title_en) }}
                        <CiClassifyName :item="product?.classify" />
                    </h1>
                    <div class="pt10px text-16px" v-html="$lang(product?.describe, product?.describe_en)" />
                </div>
            </div>
            <!-- 产品简介 -->
            <article class="width_box info_module">
                <div class="tab-btn">
                    <a v-for="item in contentData" :key="item.key" :class="{ active: active === item.key }"
                        @click="setActiveValue(item.key)">
                        <p>{{ item.title }}</p>
                    </a>
                    <div class="cols-line">
                        <span class="sp1" />
                        <span class="sp2 opacity-80" />
                        <span class="sp3 opacity-55" />
                    </div>
                    <!-- <figure><img class="co-filter-color" src="assets/image/icon_rectangle.png" alt=""></figure> -->
                </div>
                <ul class="tab-ul">
                    <li v-for="item in contentData" :key="item.key" :class="{ active: active === item.key }">
                        <ul v-if="item.key === 4" class="download_ul">
                            <li v-for="opt in downloadList" :key="opt.id" class="download_li">
                                <h1 class="download_name">
                                    {{ $lang(opt.title, opt.title_en) }}
                                </h1>
                                <CoImage class="download_img w100% pb100%" :src="opt.img || photoList?.[0]?.img" />
                                <p class="download_info">
                                    {{ $lang(opt.content, opt.content_en) }}
                                </p>
                                <div class="download_base">
                                    <p class="download_date">
                                        {{ formatTime(new Date(opt!.created_at)) }}
                                    </p>
                                    <a target="" :href="opt.href||''" class="download_icon" download="">
                                        <img class="co-filter-color" src="assets/image/icon_download.png" alt="">
                                    </a>
                                </div>
                            </li>
                        </ul>
                        <div v-else class="tab-content" v-html="item.content" />
                    </li>
                </ul>
            </article>
        </div>
    </section>
</template>

<script lang="ts" setup>
import type { ThumbsOptions } from 'swiper/types'
import { FreeMode, Navigation, Thumbs } from 'swiper/modules'
import { formatTime } from '@cooj/utils'

definePageMeta({
    layout: 'home',
})

const { $lang } = useNuxtApp()
const active = ref(1)
const setActiveValue = (val: number) => {
    active.value = val
}

const navigation = {
    nextEl: '.goods_btn-right',
    prevEl: '.goods_btn-left',
}
const modules = ref([FreeMode, Navigation, Thumbs])
const thumbsSwiper = ref<ThumbsOptions['swiper']>()

const setThumbsSwiper = (swiper: ThumbsOptions['swiper']) => {
    thumbsSwiper.value = swiper
}

const { systemInfo } = await useSystemState()

const id = useRouteParam('id')
const { data } = await useCustomFetch<Record<'nextNews' | 'prevNews' | 'data', IGoodsGetListItem>>('/api/v1/page/product/detail', {
    params: {
        id: id.value,
        // type: props.type,
    },
})
if (!data.value) {
    showErrorPage()
}
console.log(data.value)
const product = data.value?.data.data
console.log(product)
// const photoList = []
const photoList = computed(() => product?.links?.filter(item => item.type === 2) || [])
const downloadList = computed(() => product?.links?.filter(item => item.type === 3) || [])

const contentData = computed(() => {
    return [
        {
            key: 1,
            title: $lang('技术参数', 'Technical Parameter'),
            content: $lang(product?.content, product?.content_en),
        },
        {
            key: 2,
            title: $lang('型号对比', 'Model comparison'),
            content: $lang(product?.contrast, product?.contrast_en),
        },
        {
            key: 3,
            title: $lang('包装附件', 'Packaging accessories'),
            content: $lang(product?.annex, product?.annex_en),
        },
        // {
        //     key: 4,
        //     title: $lang('下载', 'File Download'),
        //     content: '',
        // },
    ]
})
useHead({
    title: `${systemInfo.value?.title} - ${product?.title}`,
    // meta: [
    //     {
    //         name: 'description',
    //         content: $lang(product?.describe, product?.describe_en),
    //     },
    //     // {
    //     //     name: 'keywords',
    //     //     content: $lang(product?.keywords, product?.keywords_en),
    //     // }
    // ],
})
</script>


<style lang="scss" scoped>
.gallery-top {
    border: 1px solid #ccc;
    margin-bottom: 15px;
    width: 100%;
}

.gallery-base {
    position: relative;
    --swiper-navigation-color: var(--ci-white);
}

.gallery-thumbs {
    width: 80%;

    .swiper-slide {
        border: 1px solid #ccc;
        overflow: hidden;

        &.swiper-slide-thumb-active {
            border: 1px solid var(--co-main-color);


        }
    }



}

.goods_btn {
    background-color: var(--ci-main-color);
    height: 100%;
    margin-top: 0;
    transform: translateY(-50%);
    width: 36px;
    --swiper-navigation-sides-offset: 0;
    display: flex;
}

.goods-name {
    color: #000;
    display: -webkit-box;
    font-size: 1.75rem;
    position: relative;
    -webkit-line-clamp: 2;
    overflow: hidden;
    text-overflow: ellipsis;
    -webkit-box-orient: vertical;
    line-height: 1.6;
    margin-bottom: 1.25rem;
    padding-bottom: .625rem;

    >span {
        color: #666;
    }

    &:before {
        background-color: var(--co-main-color);
        bottom: 0;
        content: "";
        height: .125rem;
        left: 0;
        position: absolute;
        width: 7.1875rem;
    }
}

.tab-btn {
    display: flex;
    overflow: hidden;
    position: relative;
    --pad-width: 23px;
    --goods-clamp-path: polygon(0 0, calc(100% - var(--pad-width)) 0, 100% 100%, var(--pad-width) 100%);

    >a {
        background-color: #b8b8b8;
        clip-path: var(--goods-clamp-path);
        color: #fff;
        cursor: pointer;
        flex-shrink: 0;
        font-size: 16px;
        line-height: 40px;
        margin: 0 -5px;
        padding: 0 var(--pad-width);
        position: relative;
        text-align: center;
        z-index: 1;
        min-width: 150px;

        &:first-child {
            -webkit-clip-path: polygon(0 0, calc(100% - var(--pad-width)) 0, 100% 100%, 0 100%);
            clip-path: polygon(0 0, calc(100% - var(--pad-width)) 0, 100% 100%, 0 100%);
        }

        &.active,
        &:hover {
            background-color: var(--co-main-color);
            color: #fff;
        }
    }

    .cols-line {
        border-bottom: 3px solid var(--co-main-color);
        -webkit-clip-path: var(--goods-clamp-path);
        clip-path: var(--goods-clamp-path);
        display: flex;
        margin-left: -10px;
        max-width: 100%;
        padding-bottom: 1px;
        width: 500px;

        >span {
            background-color: var(--co-main-color);
            -webkit-clip-path: var(--goods-clamp-path);
            clip-path: var(--goods-clamp-path);
            width: 35px;

            +span {
                margin-left: -20px;
            }
        }
    }
}

.tab-ul {
    padding: 40px 0;
    min-height: 200px;

    li {
        display: none;

        &.active {
            display: block;
        }

        :deep(.tab-content) {
            * {
                max-width: 100% !important;
            }
        }
    }
}

@media screen and (max-width: 768px) {
    .gallery-base{
        --next-prev-width:30px;
        --swiper-navigation-size: 24px;
    
    .gallery-thumbs {
        width: calc(100% - var(--next-prev-width) - var(--next-prev-width) - 20px);
    }

    .goods_btn {
        width: var(--next-prev-width);
}
    }

    .tab-btn {
        flex-wrap: wrap;
        gap: 15px;

        >a {
            width: 100%;
            clip-path: polygon(0 0, calc(100% - var(--pad-width)) 0, 100% 100%, 0 100%);
        }

        .cols-line {
            display: none;
        }
    }
}
</style>
