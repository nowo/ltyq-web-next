<template>
    <section>
        <!-- 分类 -->
        <CiSubMenu />
        <div class="container ma px10px">
            <ul class="news-ul">
                <ClientOnly>
                    <li v-for="item in defData.listData" :key="item.id" class="news-li">
                        <NuxtLinkLocale :to="`/news/${item.id}`" class="news-link">
                            <figure class="news-img">
                                <CoImage class="w100% pb45% block!" :src="item.img" />
                            </figure>
                            <div class="news-box">
                                <div class="news-time">
                                    {{ formatTime(new Date(item.createdAt), 'YYYY-mm-dd') }}
                                </div>
                                <h1 class="news-title">
                                    {{ $lang(item.title, item.title_en) }}
                                </h1>
                                <div class="line-icon">
                                </div>
                                <div class="news-describe" v-html="$lang(item.describe, item.describe_en)">
                                </div>
                            </div>
                        </NuxtLinkLocale>
                    </li>
                </ClientOnly>
            </ul>
            <div class="pb50px">
                <CiPagination v-model:page="page" v-model:page-size="pageSize" v-model:total="defData.pagination.total"
                    @change="onHandleCurrentChange" />
            </div>
        </div>

    </section>
</template>

<script lang="ts" setup>
import { formatTime } from '@cooj/utils'
import type { News } from '@prisma/client'

const props = defineProps<{
    type: 1 | 2 // 类型 1:公司新闻 2:行业新闻
}>()

// const route = useRoute()
const { $lang } = useNuxtApp()

const pageSize = ref(8)
const page = useRouteQuery('page', 1) // 当前页

const defData = reactive({

    pagination: {
        total: 0,
        page: 1,
        page_size: props.type === 1 ? 10 : 12,
        page_sizes: [10],
    },
    listData: [] as News[],
})

// 初始化数据
const initTableData = async () => {
    const { data, error } = await useCustomFetch<{ list: News[], total: number }>('/api/v1/page/news', {
        method: 'post',
        body: {
            type: props.type,
            isPage: 1,
            page: defData.pagination.page,
            pageSize: defData.pagination.page_size,
        },
    })

    if (error.value) return ElMessage.error('网络错误')

    defData.listData = data.value?.data.list || []
    defData.pagination.total = data.value?.data.total || 0
    // await wait(500)
    if (data.value?.code === 200) {
        // defData.listData = data.value.data.list
        // defData.pagination.total = data.value.data.total
    } else {
        ElMessage.error(data.value?.msg)
    }
}

// 分页点击
const onHandleCurrentChange = (val: number) => {
    initTableData()
}

initTableData()
</script>

<style></style>

<style lang="scss" scoped>
.news-ul {
    padding: 50px 0;
    display: grid;
    gap: 25px;
    min-height: 200px;

    .news-link {
        display: flex;
        // flex-direction:column;
        overflow:hidden;

        .news-img {
            width: 50%;
            :deep(img){
                transition: all 0.3s;

            }
        }

        .news-box {
            width: 50%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .news-title {
            font-size: 24px;
            color: #555;
            transition: color 0.3s;
            padding:15px 0;
        }

        .news-time {
            font-size: 28px;
            color: var(--ci-main-color);
            transition: color 0.3s;
        }


        .news-describe {
            font-size: 14px;
            font-weight: 400;
            line-height: 22px;

            color: #666666;
        }

        
        &:hover {
            background-color: var(--ci-main-color);
            color: #fff;
            .news-img{
                :deep(img){
                    transform: scale(1.1);
                }
            }
            .news-title,.news-time,.news-describe {
                color: var(--ci-white);
            }
            .line-icon{
                background-color: var(--ci-white);
                &:before,
                &:after {
                    background-color: var(--ci-white);
                }
            }

        }
    }
}
</style>
