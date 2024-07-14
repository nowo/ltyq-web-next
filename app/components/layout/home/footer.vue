<template>
    <footer class="footer">
        <div class="container ma c-[--ci-white]">
            <div class="footer-top">
                <div class="footer-contact">
                    <h3 class="footer-tle">
                        {{ $lang('联系我们', 'Contact us') }}
                    </h3>
                    <div class="text-item">
                        {{ systemInfo?.phone }}
                    </div>
                    <div class="text-item">
                        {{ systemInfo?.phone2 }}
                    </div>
                    <div class="text-item">
                        {{ $lang(systemInfo?.address, systemInfo?.address_en) }}
                    </div>
                    <div class="text-item">
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
                            <NuxtLinkLocale :to="item.href">
                                {{ $lang(item.title, item.title_en) }}
                            </NuxtLinkLocale>
                        </div>

                    </div>
                </div>
                <div class="footer-img flex gap-30px">
                    <div class="footer-code">
                        <CoImage class="w100% pb100% block" :src="systemInfo?.customCode" :icon-size="28" />
                        <span>{{ $lang('微信客服', 'WeChat customer service') }}</span>
                    </div>
                    <div class="footer-code">
                        <CoImage class="w100% pb100%" :src="systemInfo?.qrCode" :icon-size="28" />
                        <span> {{ $lang('微信公众号', 'WeChat official account') }}</span>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <div class="c-#fff" v-html="$lang(systemInfo?.filing, systemInfo?.filing_en)" />

                <div class="footer-icon">
                    <NuxtLink v-for="item in links" :key="item.id" :to="item.href" target="_blank" class="footer_icon"
                        :title="$lang(item.title, item.title_en) || ''">
                        <img :src="item.img" class="max-h40px" :alt="$lang(item.title, item.title_en) || ''">
                    </NuxtLink>
                    <!-- <a target="" class="footer_icon"
                            href="https://www.facebook.com/profile.php?id=100069614070466?lang=zh-Hans"><img
                                src="assets/image/facebook.png" alt="Facebook"></a>
                        <a target="" class="footer_icon" href=""><img src="assets/image/ins.png" alt="ins"></a>
                        <a target="" class="footer_icon" href=""><img src="assets/image/linkdin.png" alt="linkdin"></a> -->

                    <!--                    <a target="" class="footer_icon" href=""><img src="/template/home/static/img/public/icon_share0.png" alt=""></a> -->
                    <!--                    <a target="" class="footer_icon" href=""><img src="/template/home/static/img/public/icon_share1.png" alt=""></a> -->
                    <!--                    <a target="" class="footer_icon" href=""><img src="/template/home/static/img/public/icon_share2.png" alt=""></a> -->
                    <!--                    <a target="" class="footer_icon" href=""><img src="/template/home/static/img/public/icon_share3.png" alt=""></a> -->
                    <!--                    <a target="" class="footer_icon" href=""><img src="/template/home/static/img/public/icon_share4.png" alt=""></a> -->
                </div>
            </div>

        </div>
    </footer>
</template>

<script lang="ts" setup>
const { $lang } = useNuxtApp()
const { systemInfo } = await useSystemState()

// const classifyList = await useGoodsClassifyState().getClassify()

const { menuList } = await useMenuState()

const qqLink = computed(() => {
    if (systemInfo.value?.qq) {
        return `http://wpa.qq.com/msgrd?v=3&uin=${systemInfo.value.qq}&site=qq&menu=yes`
    } else {
        return 'javascript:;'
    }
})

const { data: links } = await useCustomFetch<ISlideListResponse[]>('/api/page/get_links', {
    params: {
        type: 8,
        isPage: 1,
    },
})
</script>

<style lang="scss" scoped></style>
