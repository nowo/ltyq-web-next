<template>
    <section class="sec-index">
        <!-- 热门推荐 -->
        <div class="container ma px10px">
            <div class="py50px">
                <h3 class="text-center text-36px">
                    {{ $lang('热门产品', 'Hot Product') }}
                </h3>
                <div class="line-icon">
                </div>
            </div>

            <div class="min-h-300px">
                <Swiper :modules="[SwiperAutoplay, SwiperEffectCreative, SwiperNavigation, SwiperPagination]"
                    :slides-per-view="1" :space-between="10" :loop="true"
                    :autoplay="{ delay: 8000, disableOnInteraction: true }" :breakpoints="breakpoints" class="py50px">
                    <SwiperSlide v-for="item in productList" :key="item.id"
                        class="swiper-item w100% bg-#fff b-1px b-#ddd text-center">
                        <NuxtLinkLocale :to="`/product/${item.id}`" class="banner-link">
                            <div class="text-26px line-clamp-1 pt15px pb8px">
                                {{ $lang(item?.title, item?.title_en) }}
                            </div>
                            <CiClassifyName
                                class="c-#555 px5px whitespace-nowrap text-ellipsis overflow-hidden block mb10px"
                                :item="item?.classify" />
                            <CoImage class="w100% pb100% <md:ma block! <md:w95% <md:pb95%" :src="item?.img"
                                :icon-size="36" />
                        </NuxtLinkLocale>
                    </SwiperSlide>
                </Swiper>
            </div>
            <!-- class="hot_more" -->
            <div class="text-center mb50px">
                <NuxtLinkLocale to="/product">
                    <el-button class="min-w150px" type="primary" round size="large">
                        {{ $lang('查看更多', 'Read More') }} >>
                    </el-button>

                </NuxtLinkLocale>
            </div>
        </div>

        <!-- 咨询 -->
        <!-- <div class="news_module" style="background-image: url(assets/image/backdrop_img.jpg)"> -->
        <div class="sec-news min-h-500px relative">
            <div class="absolute top-0 left-0 w100% h100% bg-#000c opacity-50"></div>
            <div class="container ma px10px relative z-10">
                <div class="py50px">
                    <h3 class="text-center text-36px c-#fff">
                        {{ $lang('热门产品', 'Hot Product') }}
                    </h3>
                    <div class="line-icon"> </div>
                </div>
                <div class="min-h100px">
                    <div v-if="newsList.length" class="flex">
                        <NuxtLinkLocale :to="`/news/${newsList?.[0]?.id}`" class="news-left">
                            <figure class="news_img">
                                <img :src="newsList?.[0]?.img || ''" alt="">
                            </figure>
                            <div class="news_txt flex justify-between">
                                <div class="news_title">
                                    <h2 class="font-bold">
                                        {{ $lang(newsList?.[0]?.title, newsList?.[0]?.title_en) }}
                                    </h2>
                                    <div v-html="$lang(newsList?.[0]?.describe, newsList?.[0]?.describe_en)"></div>
                                </div>
                                <div class="news_date">
                                    <strong>{{ formatTime(newsList[0]?.createdAt, 'dd') }}</strong>
                                    <span>{{ formatTime(newsList[0]?.createdAt, 'YYYY-mm') }}</span>
                                </div>
                            </div>
                        </NuxtLinkLocale>
                        <div class="news-right">
                            <NuxtLinkLocale v-for="item in newsList.slice(1)" :key="item.id" :to="`/news/${item.id}`"
                                class="news_list">
                                <div class="news_dates">
                                    <strong>{{ formatTime(item.createdAt, 'dd') }}</strong>
                                    <span>{{ formatTime(item.createdAt, 'YYYY-mm') }}</span>
                                </div>
                                <div class="news_headline">
                                    <h2 class="font-bold">
                                        {{ $lang(item.title, item.title_en) }}
                                    </h2>
                                    <div v-html="$lang(newsList?.[0]?.describe, newsList?.[0]?.describe_en)"></div>
                                </div>
                            </NuxtLinkLocale>
                        </div>
                    </div>
                </div>
                <div class="text-center py50px">
                    <NuxtLinkLocale to="/news">
                        <el-button class="min-w150px" type="primary" round size="large">
                            {{ $lang('查看更多', 'Read More') }} >>
                        </el-button>

                    </NuxtLinkLocale>
                </div>
            </div>
        </div>
    </section>
</template>

<script lang="ts" setup>
import type { Product, News } from '@prisma/client'
import { formatTime } from '@cooj/utils'
const { $lang } = useNuxtApp()

const breakpoints = ref({
    750: {
        slidesPerView: 2,
        spaceBetween: 10,
    },
    900: {
        slidesPerView: 3,
        spaceBetween: 10,
    },
    1024: {
        slidesPerView: 4,
        spaceBetween: 15,
    },
    1255: {
        slidesPerView: 5,
        spaceBetween: 15,
    },
})

const { data } = await useCustomFetch<{ productList: IGoodsGetListItem[], newsList: News[] }>('/api/v1/page/index')
console.log(data.value)
// const productList = computed(() => data.value?.productList || [])
// const newsList = computed(() => data.value?.newsList || [])

// // const menuState = useMenuState()
// // await menuState.getMenuList()
// // console.log(menuState.allList.value)

// // const newMenu = computed(() => {
// //     return menuState.allList.value.find(item => item.href === '/news')
// // })


const productList = computed(() => data.value?.data.productList || [])
const newsList = computed(() => data.value?.data.newsList || [])

// const menuState = useMenuState()
// await menuState.getMenuList()
// console.log(menuState.allList.value)

// const newMenu = computed(() => {
// return menuState.allList.value.find(item => item.href === '/news')
// })
</script>

<style lang="scss" scoped>
@import url(~/assets/css/home.css);

.swiper-item {

    &:hover {
        transform: scale(1.1);
        transition: transform .3s;
        z-index: 10;
    }
}

.news-left{
    width:60%;
}
.news-right{
    width:40%;
    padding-left: 5%;
}
</style>