<template>
    <section>
        <CiClassify :type="props.type" />
        <div class="container ma px10px">
            <!-- 产品列表 -->
            <ul class="goods-grid pt50px <md:pt35px min-h200px">
                <ClientOnly>
                    <li v-for="item in productData.list" :key="item.id" class="item">
                        <NuxtLinkLocale :to="`/product/${item.id}`">
                            <CoImage class=" w100% pb100% block!" :src="item.img" />
                            <div class="tle line-clamp-1 text-center">
                                {{ $lang(item.title, item.title_en) }}
                            </div>
                        </NuxtLinkLocale>
                    </li>
                </ClientOnly>
            </ul>
            <div class="py50px md:pt30px">
                <CiPagination v-model:page="page" v-model:page-size="pageSize" v-model:total="productData.total"
                    @change="onHandleCurrentChange" />
            </div>
        </div>
    </section>
</template>

<script lang="ts" setup>

const { $lang } = useNuxtApp()

const props = defineProps<{
    type: number
}>()

// const route = useRoute()
// const query:GoodsListParamsQuery = route.query

const pageSize = ref(8)
const pg = useRouteQuery('page', 1)
const cid = useRouteQuery('cid', '')
const page = ref(Number(pg.value) || 1)

// const cid = computed({
//     get: () => query.cid || '',
//     set: () => { },
// })

const productData = reactive({
    list: [] as IGoodsGetListItem[],
    total: 0,
})

const initData = async () => {
    const route = useRoute()
    const query = route.query as GoodsListParamsQuery
    // const cid=query.cid
    const { data, error, refresh, execute } = await useCustomFetch<{ list: IGoodsGetListItem[], total: number }>(`/api/v1/page/product`, {
        method: 'GET',
        params: {
            isPage: 1,
            page: Number(query.page) || 1,
            pageSize: pageSize.value,
            type: Number(props.type) || null,
            pid: Number(query.cid) || null,
            title: query.search || '',
            status: true
        },
    })
    console.log(data, error.value)
    if (error.value) return ElMessage.error('网络错误')

    const list = data.value?.data.list || []
    list.forEach((item) => {
        const node = item.links?.find(opt => opt.type === 2)
        item.img = node?.img || ''
    })
    productData.list = list
    productData.total = data.value?.data.total || 0
}

initData()

const onHandleCurrentChange = () => {
    linkGoodsList({ query: { page: page.value }, relate: true }, '/product')
}

// onBeforeRouteUpdate(() => {
//     initData()
// })

watch(() => [pg.value, cid.value], () => {
    page.value = Number(pg.value) || 1
    // if (!pg.value && !cid.value && !bid.value) return
    initData()
})
</script>

<style lang="scss" scoped></style>
