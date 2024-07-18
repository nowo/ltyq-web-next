import type { H3Event } from 'h3'
// import { ResponseMessage } from '~/config/message'

// news
type FindListQueryParam = {
    type: number
    title: string
    status?: number
} & IListPage

/**
 * 列表查询
 * @param event
 * @returns
 */
export const getClassifyList = defineEventHandler(async event => {
    const url = getRequestURL(event)
    // /api/page**的接口，跳过登录校验
    // if (!url.pathname.includes('/api/page')) {
    //     // 接口校验(是否登录)
    //     if (!event.context.user) return ResponseMessage.token
    // }

    // 获取参数
    const param = await getEventParams<FindListQueryParam>(event)

    // if (!param?.type) return { msg: '请传递类型' }
    const where: any = {
        // type: param?.type,
        p_id: 0, // 一级菜单
        title: {
            contains: param?.title, // 包含
        },
    }

    if (param?.type) where.type = param?.type
    if (param && 'status' in param && typeof param.status === 'number') where.status = param?.status


    // 查询菜单姓"张"，1页显示20条
    let page: number | undefined
    let pageSize: number | undefined
    let pageSkip: number | undefined

    if (param?.isPage) {
        page = param.page || 1
        pageSize = param.pageSize || 20
        pageSkip = pageSize * (page - 1) || 0
    }

    const [res1, res2] = await Promise.all([
        event.context.prisma.classify.findMany({
            skip: pageSkip,
            take: pageSize,
            where,
            orderBy: {
                sort: 'asc', // 按id正序排序
            },
            include: {
                children: true,
                // parent: true,
            },
            // select: { // 只返回指定的字段
            //     username: true,
            //     account: true,
            // },
        }),
        event.context.prisma.classify.count({
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
 * 新增
 * @param event
 * @returns T
 */
export const setClassifyCreate = defineEventHandler(async event => {
    // 接口校验(是否登录)
    // if (!event.context.user) return ResponseMessage.token

    // 获取参数
    const param = await getEventParams<BannerCreateParam>(event)

    if (!param?.title) return { msg: '标题不能为空' }

    const res = await event.context.prisma.classify.create({
        data: { ...param },
    })

    if (res) {
        return { code: 200, msg: '添加成功' }
    } else {
        return { msg: '网络错误' }
    }
})

/**
 * 修改
 * @param event
 * @returns
 */
export const setClassifyUpdate = defineEventHandler(async event => {
    // 接口校验(是否登录)
    // if (!event.context.user) return ResponseMessage.token

    // 获取参数
    const param = await getEventParams<BannerCreateParamEdit>(event)

    if (!param?.id) return { msg: '缺少参数id' }
    if (!param?.title) return { msg: '标题不能为空' }

    // return param

    const res = await event.context.prisma.classify.update({
        data: param,
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
 * 删除
 * @param event
 * @returns
 */
export const setClassifyDelete = defineEventHandler(async event => {
    // 接口校验(是否登录)
    // if (!event.context.user) return ResponseMessage.token

    // 获取参数
    const param = await getEventParams<{ id: number }>(event)

    if (!param?.id) return { msg: '缺少参数id' }

    const res = await event.context.prisma.classify.delete({
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
 * 根据分类id查找下面所有的子类id
 * @param categoryId 分类id
 * @returns number[]
 */
export async function findClassifyIds(categoryId: number): Promise<number[]> {
    const categories = await event.context.prisma.classify.findMany({
        where: {
            p_id: categoryId,
        },
    })

    let descendantIds: number[] = categories.map(category => category.id)

    for (const category of categories) {
        const childIds = await findClassifyIds(category.id)
        descendantIds = descendantIds.concat(childIds)
    }

    return descendantIds
}