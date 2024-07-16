<template>
    <footer class="footer">
        <div class="container ma c-[--ci-white]">
            <div class="footer-top">
                <div class="footer-contact">
                    <h3 class="footer-tle">
                        {{ $lang('联系我们', 'Contact us') }}
                    </h3>
                    <div v-if="systemInfo?.phone" class="text-item">
                        <i class="i-ep-phone "></i>
                        {{ systemInfo?.phone }}
                    </div>
                    <div v-if="systemInfo?.tel" class="text-item">
                        <i class="i-ep-phone "></i>
                        {{ systemInfo?.tel }}
                    </div>
                    <div class="text-item">
                        <i class="i-ep-location-information "></i>
                        {{ $lang(systemInfo?.address, systemInfo?.address_en) }}
                    </div>
                    <div v-if="systemInfo?.email" class="text-item">
                        <i class="i-ep-message "></i>
                        {{ systemInfo?.email }}
                    </div>
                    <!-- <p style="padding-left: 1.5rem;">
                            info@eaglotest.com.cn
                        </p>
                        <p style="padding-left: 1.5rem;">
                            7天-24小时为您服务！
                        </p> -->
                </div>
                <!-- <div class="footer_list">
                        <p class="footer_title">
                            {{ $lang('产品中心', 'Product Center') }}
                        </p>
                        <div class="footer_link">
                            <NuxtLinkLocale v-for="item in classifyList.filter(opt => opt.type === 1)" :key="item.id"
                                :to="`/product?cid=${item.id}`" class="footer_classify">
                                {{ $lang(item.title, item.title_en) }}
                            </NuxtLinkLocale>
                        </div>
                    </div> -->
                <!-- <div class="footer_list footer_nav"> -->
                <div class="footer-nav">
                    <h3 class="footer-tle">
                        {{ $lang('快速链接', 'Quick links') }}
                    </h3>
                    <div class="footer_link">
                        <div v-for="item in menuList" :key="item.id" class="text-item">
                            <NuxtLinkLocale :to="item.href" class="hover:c-[#000]">
                                {{ $lang(item.title, item.title_en) }}
                            </NuxtLinkLocale>
                        </div>

                    </div>
                </div>
                <div class="footer-img flex gap-30px">
                    <div class="footer-code">
                        <CoImage class="w100% pb100% block" :src="systemInfo?.wx_code" :icon-size="28" />
                        <span>{{ $lang('微信客服', 'WeChat customer service') }}</span>
                    </div>
                    <div class="footer-code">
                        <CoImage class="w100% pb100%" :src="systemInfo?.public_code" :icon-size="28" />
                        <span> {{ $lang('微信公众号', 'WeChat official account') }}</span>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <div class="c-#fff" v-html="$lang(systemInfo?.filing, systemInfo?.filing_en)" />

                <div class="footer-icon">
                    <NuxtLink v-for="item in linkList" :key="item.id" :to="item.href||''" target="_blank" class="footer_icon"
                        :title="$lang(item.title, item.title_en) || ''">
                        <img :src="item.img||''" class="max-h35px" :alt="$lang(item.title, item.title_en) || ''">
                    </NuxtLink>
                </div>
            </div>

        </div>
    </footer>
</template>

<script lang="ts" setup>
import type{Link} from '@prisma/client'
const { $lang } = useNuxtApp()
const { systemInfo } = await useSystemState()

// const {classifyList} = await useGoodsClassifyState()

const { menuList } = await useMenuState()

// const qqLink = computed(() => {
//     if (systemInfo.value?.qq) {
//         return `http://wpa.qq.com/msgrd?v=3&uin=${systemInfo.value.qq}&site=qq&menu=yes`
//     } else {
//         return 'javascript:;'
//     }
// })

const { data: links } = await useCustomFetch<{list:Link[]}>('/api/v1/page/link', {
    params: {
        type: 7,
        isPage: 1,
    },
})

const linkList=links.value?.data.list||[]
</script>

<style lang="scss" scoped></style>
