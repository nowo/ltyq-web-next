import type { H3Event } from 'h3'
// import { ResponseMessage } from '~/config/message'

// banner

/**
 * 列表查询
 * @param event
 * @returns
 */
export const getBannerList = defineEventHandler(async event => {
    // 接口校验(是否登录)
    // if (!event.context.user) return ResponseMessage.token

    // 获取参数
    const param = await getEventParams<{ type: number, title: string, goods_id: string } & IListPage>(event)

    if (!param?.type) return { msg: '请传递类型' }

    const types = param?.type.toString().split(',').filter(item => !!item).map(item => Number(item))
    const where: any = {
        type: { in: types },
        // isHide: false,
    }

    if (param.title) where.title = { contains: param.title }
    if (param.goods_id) where.productId = Number(param.goods_id)

    let includes: any = {

    }
    if (!types.includes(1)) {
        includes = {
            Product: {
                include: {
                    links: {
                        where: {
                            type: 1,
                        },
                    },
                },
            },
        }
    }

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
        prisma.link.findMany({
            skip: pageSkip,
            take: pageSize,
            where,
            orderBy: {
                sort: 'asc', // 按id正序排序
            },
            include: includes,
            // select: { // 只返回指定的字段
            //     username: true,
            //     account: true,
            // },
        }),
        prisma.link.count({
            where,
        }),
    ])
    const list = res1.map((item) => {
        if (!item?.img) item.img = item.Product?.links?.[0]?.img || ''
        return {
            ...item,
            password: '',
        }
    })
    if (res1) {
        return { code: 200, data: { list, total: res2 } }
    } else {
        return { code: 400, message: '查询失败' }
    }
})

/**
 * 新增
 * @param event
 * @returns
 */
export const setBannerCreate = defineEventHandler(async event => {
    // 接口校验(是否登录)
    // if (!event.context.user) return ResponseMessage.token

    // 获取参数
    const param = await getEventParams<BannerCreateParam>(event)

    if (!param?.title) return { msg: '标题不能为空' }

    const res = await prisma.link.create({
        data: param,
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
export const setBannerUpdate = defineEventHandler(async event => {
    // 接口校验(是否登录)
    // if (!event.context.user) return ResponseMessage.token

    // 获取参数
    const param = await getEventParams<BannerCreateParamEdit>(event)

    if (!param?.id) return { msg: '缺少参数id' }
    if (!param?.title) return { msg: '标题不能为空' }

    const res = await prisma.link.update({
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
export const setBannerDelete = defineEventHandler(async event => {
    // 接口校验(是否登录)
    // if (!event.context.user) return ResponseMessage.token

    // 获取参数
    const param = await getEventParams<{ id: number }>(event)

    if (!param?.id) return { msg: '缺少参数id' }

    const res = await prisma.link.delete({
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
