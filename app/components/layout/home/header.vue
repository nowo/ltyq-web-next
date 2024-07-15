<script lang="ts" setup>
const { $lang } = useNuxtApp()

const route = useRoute()
const { systemInfo } = await useSystemState()

const { menuList, activeMenu } = await useMenuState()

// const menuList = await menuState.getMenuList()
// const menuList = []
// if (process.client) {
//     setTimeout(() => {
//         console.log(systemInfo.value)
//         console.log('🚀 ~ file: header.vue:21 ~ menuList:', menuList)
//     }, 1500)
// }

const {classifyList} = await useGoodsClassifyState()

const setActiveMenu = (item: string) => {
    const href = activeMenu.value?.href

    return href === item
    // // if (href === item) {
    // // }

    // const route = useRoute()
    // // const url = useRequestURL()

    // const path = route.path
    // // let path=url.pathname
    // // const path = '/public/upload/product/2021/04-17/S-042KD.jpg'

    // // 查找第一个斜杠的索引
    // const firstSlashIndex = path.indexOf('/')
    // let first = ''
    // if (firstSlashIndex !== -1) {
    //     // 截取第一个斜杠及其前面的内容
    //     first = path.substring(0, firstSlashIndex + 1) // 包括斜杠
    // }

    // if (path === item) {
    //     return true
    // } else if (item !== '/' && (path === `/${item}` || item === first)) {
    //     return true
    // } else {
    //     return false
    // }
}

const setProductUrl = (type: number, id: number) => {
    const url = type === 2 ? '/product2' : '/product'
    return `${url}?cid=${id}`
}
const keyword = ref('')
const searchOpen = ref('')
const onToggleSearch = (close?: boolean) => {
    console.log(menuList.value)
    if (close && keyword.value) keyword.value = ''
    searchOpen.value = close ? '' : 'open'
}

const onSearch = async () => {
    if (!keyword.value?.trim()) return false
    let url = '/product'
    if (route.path.startsWith('/en')) {
        url = '/en/product'
    }
    await navigateTo(`${url}?keyword=${keyword.value}&search=1`)
    onToggleSearch(true)
}

// 移动端
//

const isOpen = ref(false)
const onToggleMenu = (close?: boolean) => {
    isOpen.value = !!close
}


watch(() => route.path, () => {
    if (isOpen.value) isOpen.value = false
})
</script>

<template>
    <!-- 头部开始 -->
    <header class="header">
        <div class="pc-header">
            <!-- 顶部 -->
            <div class="header-top main-bg-color">
                <div class="container ax ma flex items-center justify-between px10px c-#fff">
                    <div>{{ $lang(systemInfo?.welcome, systemInfo?.welcome_en) }}</div>
                    <div class="header-top-right flex gap-20px">
                        <div class="Top_list flex">
                            <div class="Top_icon Top_phone">
                                <img src="assets/image/icon_phone.png" alt="">
                            </div>
                            <span>{{ systemInfo?.phone }}</span>
                        </div>
                        <template v-if="systemInfo?.is_en">
                            <NuxtLink to="/" class="flex items-center">
                                <div class="i-flag:cn-4x3 mr5px text-16px" />
                                <span>中文版</span>
                            </NuxtLink>
                            <NuxtLink to="/en" class="flex items-center">
                                <div class="i-flag:gb-4x3 mr5px text-16px" />

                                <span>English</span>
                            </NuxtLink>
                        </template>
                    </div>
                </div>
            </div>
            <!-- 导航 -->
            <div class="header-menu">
                <div class="container ma flex items-center justify-between px10px">
                    <NuxtLinkLocale to="/" class="logo" :title="systemInfo?.company">
                        <img :src="systemInfo?.logo" :alt="systemInfo?.company">
                    </NuxtLinkLocale>
                    <div class="flex items-center gap-5px">
                        <nav>
                            <ul class="menu-ul">
                                <li v-for="item in menuList" :key="item.id" :class="{'relative':!item.is_goods}">
                                    <NuxtLinkLocale :to="item.href" class="menu-btn"
                                        :class="{ nav_active: setActiveMenu(item.href || '') }">
                                        {{ $lang(item.title, item.title_en) }}
                                    </NuxtLinkLocale>

                                    <!-- 子菜单列表 -->
                                    <div v-if="item.is_goods || item.children?.length" class="sub-box" :class="{'product-menu':item.is_goods}">
                                        <ul v-if="item.is_goods" class="sub-list grid-cols-6"
                                            :class="{ nav_product: item.is_goods }">
                                            <li v-for="opt in classifyList.filter(i => i.status)"
                                                :key="opt.id" class="sub-li">
                                                <NuxtLinkLocale :to="`/product?cid=${opt.id}`" class="nav_title">
                                                    {{ $lang(opt.title, opt.title_en) }}
                                                </NuxtLinkLocale>
                                                <div v-if="opt.children?.length">
                                                    <NuxtLinkLocale v-for="sub in opt.children" :key="sub.id"
                                                        :to="`/product?cid=${sub.id}`" class="sub-a">
                                                        {{ $lang(sub.title, sub.title_en) }}
                                                    </NuxtLinkLocale>
                                                </div>
                                            </li>
                                        </ul>
                                        <ul v-else class="sub-list">
                                            <li v-for="sub in item.children" :key="sub.id" class="sub-li">
                                                <NuxtLinkLocale :to="sub.href" class="nav_title">
                                                    {{ $lang(sub.title, sub.title_en) }}
                                                </NuxtLinkLocale>
                                            </li>
                                        </ul>
                                        <!-- 产品列表 -->
                                    </div>
                                </li>
                            </ul>
                        </nav>
                        <div class="i-ep-search  text-24px c-[--ci-main-color] cursor-pointer"
                            @click="onToggleSearch()">

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 搜索 -->
        <div class="search-box" :class="searchOpen">
            <form class="search-form flex items-center" onsubmit="return false">
                <i class="i-ep-search  text-24px c-[--ci-main-color]" />
                <input v-model="keyword" class="flex-1 px10px" type="text" name="keyword"
                    :placeholder="$lang('搜索关键字', 'keyword') || ''" @keyup.enter="onSearch">
                <i class="i-ep-close text-24px cursor-pointer hover:c-[--ci-main-color]" @click="onToggleSearch(true)">
                </i>
            </form>
        </div>

        <!-- 移动端顶部 -->
        <div class="mo-header">
            <div class="h60px w40px flex items-center justify-center" @click="onToggleMenu(true)">
                <i class="i-ep-list" />
            </div>
            <div class="mo-logo">
                <NuxtLinkLocale to="/" :title="systemInfo?.company">
                    <img :src="systemInfo?.logo2 || ''" :alt="systemInfo?.company" class="max-h60px">
                </NuxtLinkLocale>
            </div>

            <div class="h60px w40px flex items-center justify-center" @click="onToggleSearch()">
                <img class="co-filter-color" src="assets/image/icon_search.png" alt="">
            </div>

            <div class="mo-menu" :class="{ open: isOpen }" @click="onToggleMenu(false)">
                <div ref="target" class="h100% w65% overflow-auto bg-[--ci-white]" @click.stop>
                    <div class="mo-menu-top">
                        <div class="text-12px">
                            {{ $lang(systemInfo?.welcome, systemInfo?.welcome_en) }}
                        </div>
                        <div class="mb15px mt10px text-12px">
                            {{ systemInfo?.phone }}
                        </div>
                        <div v-if="systemInfo?.is_en" class="flex items-center justify-between">
                            <NuxtLink to="/" class="flex items-center">
                                <div class="i-flag:cn-4x3 mr5px text-16px" />

                                <span>中文版</span>
                            </NuxtLink>
                            <NuxtLink to="/en" class="flex items-center">
                                <div class="i-flag:gb-4x3 mr5px text-16px" />
                                <span>English</span>
                            </NuxtLink>
                        </div>
                    </div>
                    <nav>
                        <ul class="mo-menu-list">
                            <li v-for="item in menuList.filter(i => i.status)" :key="item.id" class="mo_li">
                                <NuxtLinkLocale :to="item.href" class="mo_btn">
                                    {{ $lang(item.title, item.title_en) }}
                                </NuxtLinkLocale>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </header>
</template>

<style lang="scss" scoped></style>
