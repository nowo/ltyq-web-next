import type { Prisma } from '@prisma/client'

/**
 * 获取产品列表
 */
export const getNewsList = defineEventHandler(async (event) => {
    // // 接口校验(是否登录)
    // if (!event.context.user) return ResponseMessage.token

    // 获取参数
    const param = await getEventParams<Prisma.NewsCreateInput & IListPage>(event)

    const where: Prisma.NewsWhereInput = {}

    if (param?.title) {
        where.title = {
            contains: param.title, // 包含
        }
    }
    if (param?.type) {
        where.type = param.type
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

    const [res1, res2] = await Promise.all([
        event.context.prisma.news.findMany({
            skip: pageSkip,
            take: pageSize,
            where,
            orderBy: {
                createdAt: 'desc', // 按创建时间倒序排序
                // updated_at: 'desc', // 按更新时间倒序排序
                // id: 'asc', // 按id正序排序
            },
            // include: {
            //     children: true,
            // },
            // select: { // 只返回指定的字段
            //     username: true,
            //     account: true,
            // },
        }),
        event.context.prisma.news.count({
            where,
        }),
    ])

    if (res1) {
        return { code: 200, data: { list: res1, total: res2 } }
    } else {
        return { code: 400, message: '查询失败' }
    }
})

/**
 * 创建产品
 */
export const setNewsCreate = defineEventHandler(async (event) => {
    // // 接口校验(是否登录)
    // if (!event.context.user) return ResponseMessage.token

    // 获取参数
    const param = await getEventParams<Prisma.NewsCreateInput>(event)

    if (!param?.title) return { msg: '标题名称不能为空' }
    // if (!param.href) return { msg: '链接地址不能为空' }

    const res = await event.context.prisma.news.create({
        data: {
            ...param,
            status:!!param.status
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
export const setNewsUpdate = defineEventHandler(async (event) => {
    // 接口校验(是否登录)
    // if (!event.context.user) return ResponseMessage.token

    // 获取参数
    const param = await getEventParams<Prisma.NewsUncheckedCreateInput>(event)

    if (!param?.id) return { msg: '缺少参数id' }
    if (!param.title) return { msg: '标题名称不能为空' }
    // if (!param.href) return { msg: '链接地址不能为空' }

    const res = await event.context.prisma.news.update({
        data: {
            ...param,
            status:!!param.status
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
export const setNewsDelete = defineEventHandler(async (event) => {
    // 接口校验(是否登录)
    // if (!event.context.user) return ResponseMessage.token

    // 获取参数
    const param = await getEventParams<{ id: number }>(event)

    if (!param?.id) return { msg: '缺少参数id' }

    const res = await event.context.prisma.news.delete({
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



/**
 * 获取新闻详情
 */
export const getNewsInfo =defineEventHandler( async event=> {
    // 获取参数
    const param = await getEventParams<{ id: number, type: number }>(event)

    if (!param?.id) return null
    // if (!param?.type) return null

    const res = await event.context.prisma.news.findUnique({
        where: {
            id: Number(param.id),
            // type: Number(param.type),
        },
    })

    if (!res) return null
    // 取得上一条、下一条记录、更新阅读量
    const [res1, res2] = await Promise.all([
        event.context.prisma.news.findMany({ // lte 小于等于，使用倒序
            where: {
                createdAt: {
                    lte: res.createdAt,
                },
                id: { // 排除
                    not: res.id,
                },
                type: res.type, // 类型相同
            },
            orderBy: {
                createdAt: 'desc', // 倒序排序
            },
        }),
        event.context.prisma.news.findMany({ // gte 大于等于，使用正序
            where: {
                createdAt: {
                    gt: res.createdAt,
                },
                id: {
                    not: res.id,
                },
                type: res.type,
            },
            orderBy: {
                createdAt: 'asc', // 升序排序
            },
        }),
        event.context.prisma.news.update({
            where: {
                id: res.id,
            },
            data: {
                read: (res.read || 0) + 1,
            },
        }),
    ])

    return {
        code:200,
        data:{
            data: res,
            prevNews: res1[0],
            nextNews: res2[0],
        }
    }
})

