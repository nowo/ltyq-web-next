<template>
    <section>
        <!-- 分类 -->
        <CiSubMenu />

        <!-- 下载列表 -->
        <div class="container ma px10px">
            <!-- 分类 -->
            <div class="flex justify-center gap-30px py30px">
                <a v-for="(item, key) in typeList" :key="key" class="cursor-pointer text-16px c-#666"
                    :class="{ '!c-[--ci-main-color]': type === Number(key) }" @click="setFileType(key)">{{ item }}</a>
            </div>

            <!-- 列表 -->
            <ul class="download-ul min-h-300px">
                <ClientOnly>
                    <li v-for="opt in productData.list" :key="opt.id" class="item">
                        <h1 class="tle">
                            {{ $lang(opt.title, opt.title_en) }}
                        </h1>
                        <CoImage class="download_img w100% pb100%" :src="opt.img" :icon-size="36" />
                        <!-- <p class="download_info">
                            {{ $lang(opt.content, opt.content_en) }}
                        </p> -->
                        <div class="flex justify-between items-center">
                            <p class="text-16px c-#777">
                                {{ formatTime(new Date(opt!.created_at)) }}
                            </p>
                            <a target="" :href="opt.href||''" download="">
                                <i class="i-ep-download text-48px c-[--ci-main-color] block" />
                            </a>
                        </div>
                    </li>
                </ClientOnly>
            </ul>

            <!-- 分页 -->
            <div class="py50px">
                <CiPagination v-model:page="page" v-model:page-size="pageSize" v-model:total="productData.total"
                    @change="onHandleCurrentChange" />
            </div>
        </div>
    </section>
</template>

<script lang="ts" setup>
import type { Link } from '@prisma/client'
// import { formatTime } from '@cooj/utils'
const { $lang } = useNuxtApp()

definePageMeta({
    layout: 'home',
})

const typeList = ref({
    4: $lang('文档', 'Docs'),
    5: $lang('视频', 'Video'),
    6: $lang('软件', 'Software'),
})
const type = ref(4)

// const { activeMenu, menuList } = useMenuState()
const pageSize = ref(8)
const page = useRouteQuery('page', 1) // 当前页
const pg = ref(Number(page.value))

const productData = reactive({
    list: [] as Link[],
    total: 0,
})

const initData = async () => {
    const { data, error, refresh, execute } = await useCustomFetch<{ list: Link[], total: number }>(`/api/v1/page/link`, {
        method: 'GET',
        params: {
            isPage: 1,
            page: pg.value,
            pageSize: pageSize.value,
            type:Number(type.value) || null,
        },
    })

    if (error.value) return ElMessage.error('网络错误')
    // console.log(data.value)
    const list = data.value?.data.list || []
    // list.forEach((item) => {
    //     const node = item.links.find(opt => opt.type === 1)
    //     item.img = node?.img || ''
    // })
    productData.list = list
    productData.total = data.value?.data.total || 0
}

initData()

const setFileType = (key: string | number) => {
    type.value = Number(key)
    initData()
}

const onHandleCurrentChange = () => {
    // linkGoodsList({ query: { page: pg.value }, relate: true })
    // refresh()
    initData()
}
</script>

<style lang="scss" scoped>
.goods-page {
    --el-pagination-border-radius: 50%;
    --el-pagination-button-width: 38px;
    --el-pagination-button-height: 38px;
}
</style>
