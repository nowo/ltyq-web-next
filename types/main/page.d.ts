
/**
 *  创建banner  - 请求
 */
declare interface BannerCreateParam {

    title: string // 菜单名称
    title_en: string // 菜单名称（英文）
    href: string // 链接地址
    sort: number // 排序
    img: string // 图片地址

}


/**
 *  修改banner   - 请求
 */
declare interface BannerCreateParamEdit extends BannerCreateParam {
    id: number
}




/**
 * 商品页面参数
 */
declare interface GoodsListParams<T = Record<string, any>> {
    query: T // 参数
    relate?: boolean // 是否携带浏览器地址上的参数
    url?: boolean // 返回地址的形式
}

declare interface GoodsListParamsQuery {
    page?: string | number // 关键字
    cid?: string | number // 商品分类id   类别
    // bid?: string | number // 商品品牌id
    search?: string
}



