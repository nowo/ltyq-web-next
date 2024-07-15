import type { Prisma } from '@prisma/client'
import { findClassifyIds } from './classify'

/**
 * 获取产品列表
 */
export const getProductList = defineEventHandler(async (event) => {
    // // 接口校验(是否登录)
    // if (!event.context.user) return ResponseMessage.token
    console.log(event)
    // 获取参数
    const param = await getEventParams<Prisma.ProductCreateInput & IListPage & { pid?: number }>(event)

    const where: Prisma.ProductWhereInput = {}

    if (param?.title) {
        where.title = {
            contains: param.title, // 包含
        }
    }
    // if (param?.href) {
    //     where.href = {
    //         contains: param.href, // 包含
    //     }
    // }

    if (param?.pid) {
        const cid = Number(param?.pid)
        const ids = await findClassifyIds(cid)
        where.classifyId = {
            in: [cid, ...ids],
        }
    }



    // 分页数量查询，1页显示20条
    let page: number | undefined
    let pageSize: number | undefined
    let pageSkip: number | undefined

    if (param?.isPage) {
        page = Number(param?.page) || 1
        pageSize = Number(param.pageSize) || 20
        pageSkip = pageSize * (page - 1) || 0
    }
    console.log('where :>> ', where);
    const [res1, res2] = await Promise.all([
        prisma.product.findMany({
            skip: pageSkip,
            take: pageSize,
            where,
            orderBy: {
                sort: 'desc',
                // created_at: 'desc', // 按创建时间倒序排序
                // updated_at: 'desc', // 按更新时间倒序排序
                // id: 'asc', // 按id正序排序
            },
            include: {
                links: true,
                classify: {
                    include: {
                        parent: true,
                    },
                },
            },
            // select: { // 只返回指定的字段
            //     username: true,
            //     account: true,
            // },
        }),
        prisma.product.count({
            where,
        }),
    ])
    console.log('res1 :>> ', res1);
    if (res1) {
        return { code: 200, data: { list: res1, total: res2 } }
    } else {
        return { code: 400, message: '查询失败' }
    }
})


/**
 * 获取产品信息
 */
export const getProductInfo = defineEventHandler(async (event) => {
    // 获取参数
    const param = await getEventParams<{ id: number }>(event)

    if (!param?.id) return null

    const res = await prisma.product.findUnique({
        where: {
            id: Number(param.id),
            // type: Number(param.type),
        },
        include: {
            links: true,
            classify: {
                include: {
                    parent: true,
                },
            },
        },
    })

    if (!res) return null
    // 取得上一条、下一条记录、更新阅读量
    // const [res1, res2] = await Promise.all([
    //     prisma.product.findMany({ // lte 小于等于，使用倒序
    //         where: {
    //             createdAt: {
    //                 lte: res.createdAt,
    //             },
    //             id: { // 排除
    //                 not: res.id,
    //             },
    //             type: res.type, // 类型相同
    //         },
    //         orderBy: {
    //             createdAt: 'desc', // 倒序排序
    //         },
    //     }),
    //     prisma.product.findMany({ // gte 大于等于，使用正序
    //         where: {
    //             createdAt: {
    //                 gt: res.createdAt,
    //             },
    //             id: {
    //                 not: res.id,
    //             },
    //             type: res.type,
    //         },
    //         orderBy: {
    //             createdAt: 'asc', // 升序排序
    //         },
    //     }),
    //     prisma.product.update({
    //         where: {
    //             id: res.id,
    //         },
    //         data: {
    //             read: (res.read || 0) + 1,
    //         },
    //     }),
    // ])

    return {
        code:200,
        data: {
            data: res
            // prevNews: res1[0],
            // nextNews: res2[0],
        },
    }

})

/**
 * 创建产品
 */
export const setProductCreate = defineEventHandler(async (event) => {
    // // 接口校验(是否登录)
    // if (!event.context.user) return ResponseMessage.token

    // 获取参数
    const param = await getEventParams<Prisma.ProductCreateInput>(event)

    if (!param?.title) return { msg: '标题名称不能为空' }
    // if (!param.href) return { msg: '链接地址不能为空' }
    let links = param.links as Prisma.LinkCreateManyProductInput[] || []
    const res = await prisma.product.create({
        data: {
            ...param,
            links: {
                createMany: {
                    data: links,
                },
            },
        },
    })

    if (res) {
        return { code: 200, msg: '添加成功' }
    } else {
        return { msg: '网络错误' }
    }
})

/**
 * 修改产品
 */
export const setProductUpdate = defineEventHandler(async (event) => {
    // 接口校验(是否登录)
    // if (!event.context.user) return ResponseMessage.token

    // 获取参数
    const param = await getEventParams<Prisma.ProductUncheckedCreateInput>(event)

    // if (!param?.id) return { msg: '缺少参数id' }
    // if (!param.title) return { msg: '标题名称不能为空' }
    // // if (!param.href) return { msg: '链接地址不能为空' }

    // const res = await prisma.product.update({
    //     data: param,
    //     where: {
    //         id: param.id,
    //     },
    // })



    if (!param?.id) return { msg: '缺少参数id' }
    if (!param?.title) return { msg: '标题不能为空' }

    const links = await prisma.link.findMany({
        where: {
            productId: param.id,
        },
    })
    // const dat: Prisma.LinkUpdateManyWithWhereWithoutProductInput = {}
    const addLinks: Prisma.LinkCreateManyInput[] = []
    const paramLinks = param.links?.createMany?.data as Prisma.LinkCreateManyProductInput[] || []
    const updateIds: number[] = []
    for (const item of paramLinks) {
        const node = links.find((i) => {
            if (item.type === 2) return i.img === item.img
            else return i.href === item.href
        })
        if (node) {
            updateIds.push(node.id)
            await prisma.link.update({
                where: {
                    id: node.id,
                },
                data: {
                    title: item.title || '',
                    content: item.content || '',
                    img: item.img || '',
                    href: item.href || '',
                    type: item.type,
                },
            })
        } else {
            const dat: Prisma.LinkCreateManyInput = {
                title: item.title || '',
                content: item.content || '',
                img: item.img || '',
                href: item.href || '',
                type: item.type,
                // productId: param.id,
            }
            addLinks.push(dat)
        }
    }

    // 过滤已更新的数据（剩余的为删除）
    const delIds: Prisma.LinkScalarWhereInput[] = links.filter(item => !updateIds.includes(item.id)).map(item => ({ id: item.id }))
    // console.log('param :>> ', param)
    // return { code: 200, msg: '修改成功', param }

    const res = await prisma.product.update({
        data: {
            ...param,
            links: {
                createMany: {
                    data: addLinks,
                },
                deleteMany: delIds,
                // updateMany: [{ id: 1 }],
            },
        },
        where: {
            id: param.id,
        },
    })

    if (res) {
        return { code: 200, msg: '修改成功' }
    } else {
        return { msg: '网络错误' }
    }

})

/**
 * 删除产品
 */
export const setProductDelete = defineEventHandler(async (event) => {
    // 接口校验(是否登录)
    // if (!event.context.user) return ResponseMessage.token

    // 获取参数
    const param = await getEventParams<{ id: number }>(event)

    if (!param?.id) return { msg: '缺少参数id' }

    const res = await prisma.product.delete({
        where: {
            id: param.id,
        },
    })

    if (res) {
        return { code: 200, msg: '删除成功' }
    } else {
        return { msg: '网络错误' }
    }
})
