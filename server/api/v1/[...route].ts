import { createRouter, defineEventHandler, useBase } from 'h3'
import { setDeleteFile, setSaveFile } from '~~/server/controller/common'
import { getAdminInfo, getAdminList, setAdminCreate, setAdminDelete, setAdminUpdate, setLoginSign, setPasswordUpdate, setRegister } from '~~/server/controller/admin'
import { getSystemInfo, setSystemInfo } from '~~/server/controller/system'
import { getMenuList, setMenuCreate, setMenuDelete, setMenuUpdate } from '~~/server/controller/menu'
import { getProductList, setProductCreate, setProductDelete, setProductUpdate,getProductInfo } from '~~/server/controller/product'
import { getClassifyList, setClassifyCreate, setClassifyDelete, setClassifyUpdate } from '~~/server/controller/classify'
import { getNewsList, setNewsCreate, setNewsDelete, setNewsUpdate,getNewsInfo } from '~~/server/controller/news'
import { getLinkList, setLinkCreate, setLinkDelete, setLinkUpdate } from '~~/server/controller/link'
import { getOtherInfo, setOtherUpdate } from '~~/server/controller/other'
import { getMessageList, setMessageCreate, setMessageDelete, setMessageUpdate } from '~~/server/controller/message'
import { getRecruitList, setRecruitCreate, setRecruitDelete, setRecruitUpdate } from '~~/server/controller/recruit'
import { getIndexData } from '~~/server/controller/page'

const router = createRouter()

router.use('/file/upload', setSaveFile) // 文件上传保存
router.use('/file/delete', setDeleteFile) // 文件删除

router.use('/login', setLoginSign) // 用户登录
router.use('/signup', setRegister) // 用户注册
router.use('/password', setPasswordUpdate) // 修改密码
router.use('/user/info', getAdminInfo) // 用户登录账户信息

router.use('/system/info', getSystemInfo) // 获取系统信息
router.use('/system/edit', setSystemInfo) // 修改系统信息

router.use('/admin/list', getAdminList) // 用户列表
router.use('/admin/add', setAdminCreate) // 添加用户
router.use('/admin/edit', setAdminUpdate) // 修改用户
router.use('/admin/delete', setAdminDelete) // 删除用户

router.use('/menu/list', getMenuList) // 菜单列表
router.use('/menu/add', setMenuCreate) // 添加菜单
router.use('/menu/edit', setMenuUpdate) // 修改菜单
router.use('/menu/delete', setMenuDelete) // 删除菜单


router.use('/product/list', getProductList) // 产品列表
router.use('/product/add', setProductCreate) // 添加产品
router.use('/product/edit', setProductUpdate) // 修改产品
router.use('/product/delete', setProductDelete) // 删除产品

router.use('/classify/list', getClassifyList) // 产品分类列表
router.use('/classify/add', setClassifyCreate) // 添加产品分类
router.use('/classify/edit', setClassifyUpdate) // 修改产品分类
router.use('/classify/delete', setClassifyDelete) // 删除产品分类

router.use('/news/list', getNewsList) // 新闻列表
router.use('/news/add', setNewsCreate) // 添加新闻
router.use('/news/edit', setNewsUpdate) // 修改新闻
router.use('/news/delete', setNewsDelete) // 删除新闻

router.use('/link/list', getLinkList) // 新闻列表
router.use('/link/add', setLinkCreate) // 添加新闻
router.use('/link/edit', setLinkUpdate) // 修改新闻
router.use('/link/delete', setLinkDelete) // 删除新闻

router.use('/message/list', getMessageList) // 留言列表
router.use('/message/add', setMessageCreate) // 添加留言
router.use('/message/edit', setMessageUpdate) // 修改留言
router.use('/message/delete', setMessageDelete) // 删除留言

router.use('/recruit/list', getRecruitList) // 招聘岗位列表
router.use('/recruit/add', setRecruitCreate) // 添加招聘岗位
router.use('/recruit/edit', setRecruitUpdate) // 修改招聘岗位
router.use('/recruit/delete', setRecruitDelete) // 删除招聘岗位

router.use('/other/info', getOtherInfo) // 获取其他信息
router.use('/other/update', setOtherUpdate) // 修改其他信息


router.use('/page/menu', getMenuList) // 菜单列表 
router.use('/page/classify', getClassifyList) // 菜单列表 
router.use('/page/news', getNewsList) // 新闻列表 
router.use('/page/news/detail', getNewsInfo) // 新闻详情 
router.use('/page/banner', getLinkList) //TODO 轮播图 

router.use('/page/product', getProductList) // 产品列表 
router.use('/page/product/detail', getProductInfo) // 产品列表 
router.use('/page/link', getLinkList) // 产品列表 
router.use('/page/honor', getLinkList) // 产品列表 

router.use('/page/other', getOtherInfo) // 获取其他信息
router.use('/page/recruit', getRecruitList) // 招聘岗位

router.use('/page/message', setMessageCreate) // 添加留言
router.use('/page/index', getIndexData) // 添加留言

/**
 * 获取所有菜单信息
 */
router.use('/list', defineEventHandler(async (event) => {
    const list = [
        {
            // id: 1,
            name: 'home',
            path: '/home',
            // icon: 'home',
            children: [
                {
                    id: 11,
                    name: '首页',
                    path: '/home',
                    icon: 'home',
                },
            ],
        },
        {
            path: '/system',
            name: 'system',
            meta: {
                layout: 'classic',
                title: '系统设置',
            },
            props: {
                default: false,
            },
            children: [
                {
                    path: '/system/info',
                    name: 'info',
                    meta: {
                        title: '系统信息',
                    },
                    props: {
                        default: false,
                    },
                },
            ],
            instances: {},
            leaveGuards: {},
            updateGuards: {},
            enterCallbacks: {},
            components: {},
        },
    ]

    return list
}))

/**
 * 获取用户权限菜单
 */
router.use('/auth', defineEventHandler(async (event) => {
    const list = [
        {
            // id: 1,
            name: 'index',
            path: '/',
            // icon: 'home',
            redirect: '/home',
            meta: {
                title: '首页',
                icon: 'i-ep-home-filled',
            },
            children: [
                {
                    name: '首页',
                    path: '/home',
                    meta: {
                        title: '首页',
                        icon: 'i-ep-home-filled',
                    },
                },
            ],
        },
        {
            path: '/system',
            name: 'system',
            meta: {
                layout: 'classic',
                title: '系统设置',
            },
            props: {
                default: false,
            },
            children: [
                {
                    path: '/system/info',
                    name: 'info',
                    meta: {
                        title: '系统信息',
                    },
                    props: {
                        default: false,
                    },
                },
            ],
            instances: {},
            leaveGuards: {},
            updateGuards: {},
            enterCallbacks: {},
            components: {},
        },
    ]

    return list
}))

const startAt = Date.now()
let count = 0

router.use('/pageview', defineEventHandler(async (event) => {
    return {
        pageview: count++,
        startAt,
    }
}))

export default useBase('/api/v1', router.handler)
