import type { H3Event } from 'h3'

// import { ResponseMessage } from '~/config/message'

/**
 * 获取首页信息
 */
export const getIndexData =defineEventHandler( async event => {
    // 获取参数
    // const param = await getEventParams<{ id: number }>(event)
    console.log('event.context.prisma',event.context.prisma)
    // if (!param?.id) return null
    // 推荐商品\商品分类、商品\新闻和风采
    const [res1, res2] = await Promise.all([
        event.context.prisma.product.findMany({
            skip: 0,
            take: 20,
            where: {
                status: true,
                isHot: true,
                // type: Number(param.type),
            },
            include: {
                links: true,
                classify: {
                    // select: {
                    //     title: true,
                    //     title_en: true,
                    // },
                    include: {
                        parent: true,
                    },
                },
            },
            orderBy: [
                {
                    sort: 'desc', // 降序排序
                },
                {
                    created_at: 'desc', // 降序排序
                }
            ],
        }),
        event.context.prisma.news.findMany({
            skip: 0,
            take: 6,
            where: {
                // type: {
                //     in: [1, 3],
                // },
                status: true,
                // isIndex: true,
                // type: Number(param.type),
            },
            orderBy: [
                {
                    sort: 'desc', // 降序排序
                },
                {
                    createdAt: 'desc', // 降序排序
                }
            ],
        }),
    ])


    const list = res1.map((item) => {
        const node = item.links.find(item => item.type === 2&&item.img)
        item.img = node?.img || ''
        return item
    })


    return {
        code:200,
        data:{
            productList: list,
            newsList: res2,
        }
    }
})
