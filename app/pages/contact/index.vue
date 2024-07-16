<template>
    <section>
        <CiSubMenu />
        <!-- 详情 -->
        <div class="container ma px10px flex flex-wrap py50px">
            <div class="flex-1">
                <h3 class="font-bold text-20px mb10px">
                    {{ $lang(systemInfo?.company, systemInfo?.company_en) }}
                </h3>
                <ul class="contact_ul text-18px lh-36px">
                    <li class="flex items-center">
                        <i class="i-ep-phone c-[--ci-main-color] mr5px" />
                        <p class="contact_text">
                            {{ $lang('服务热线', 'Service hotline') }} ：{{ systemInfo?.phone }}
                        </p>
                    </li>
                    <li class="flex items-center">
                        <i class="i-ep-phone c-[--ci-main-color] mr5px" />
                        <p class="contact_text">
                            {{ $lang('客服热线', 'Customer hotline') }}：{{ systemInfo?.tel }}
                        </p>
                    </li>
                    <li class="flex items-center">
                        <i class="i-ep-message c-[--ci-main-color] mr5px" />
                        <p class="contact_text">
                            {{ $lang('电子邮箱', 'Email') }}：{{ systemInfo?.email }}
                        </p>
                    </li>
                    <li class="flex items-center">
                        <i class="i-ep-location-information c-[--ci-main-color] mr5px" />
                        <p class="contact_text">
                            {{ $lang('联系地址', 'Address') }}： {{ $lang(systemInfo?.address, systemInfo?.address_en) }}
                        </p>
                    </li>
                    <!-- <li class="contact_list">
                        <figure class="contact_icon">
                            <img src="assets/image/icon_url.png" alt="">
                        </figure>
                        <p class="contact_text">
                            官方网址：<a target="" href="index.html">test.com.cn</a>
                        </p>
                    </li> -->
                </ul>
            </div>
            <div class="flex gap-50px">
                <div class="w200px">
                    <CoImage :src="systemInfo?.wx_code" class="w100% pb100%" :icon-size="36" />
                    <div class="text-center mt10px c-#888 text-18px">
                        {{ $lang('扫一扫联系我们', 'Scan and contact us') }}
                    </div>
                </div>
                <div class="w200px">
                    <CoImage :src="systemInfo?.public_code" class="w100% pb100%" :icon-size="36" />
                    <div class="text-center mt10px c-#888 text-18px">
                        {{ $lang('扫一扫关注公众号', 'Scan to follow the official account') }}
                    </div>
                </div>
            </div>
        </div>

        <!-- 地图 -->
        <div class="pt30px pb60px">
            <div class="container ma px10px">
                <div id="map_box" class="h500px" />
            </div>
        </div>

    </section>
</template>

<script lang="ts" setup>

const { $lang } = useNuxtApp()
definePageMeta({
    layout: 'home',
})
const { systemInfo } = await useSystemState()


/* eslint-disable */
function initMap(id: any, title: any, address: any) {
    if (!address) return

    window.BMap_loadScriptTime = (new Date()).getTime()

    // 创建 <script> 元素并设置其属性
    const script = document.createElement('script')
    script.src = 'http://api.map.baidu.com/getscript?v=2.0&ak=AVmS2wD2ZgzGaU6euB2fwlr9ym3GyWnT&services=&t=20240108120844' // 指定外部 JS 文件路径
    document.head.appendChild(script) // 将 <script> 元素添加到 HTML 头部
    setTimeout(() => {
        const map = new BMap.Map(id)
        // 创建地址解析器实例
        const myGeo = new BMap.Geocoder()
        // 将地址解析结果显示在地图上,并调整地图视野
        myGeo.getPoint(address, (point) => {
            if (point) {
                // console.log(point)
                // map.centerAndZoom(point, 16)
                // map.addOverlay(new BMap.Marker(point))

                // const point = new BMap.Point('113.344897', '23.307565')
                const points = new BMap.Point(point.lng, point.lat)
                map.centerAndZoom(points, 18)

                const content = `<h2 style=\'font-size: 1rem;margin-bottom:.3125rem;\'>${title}</h2><p>${address}</p>` // 设置信息框内容
                const infoWindow = new BMap.InfoWindow(content)
                map.openInfoWindow(infoWindow, map.getCenter())
                const zoom = { type: BMAP_NAVIGATION_CONTROL_LARGE }
                map.addControl(new BMap.NavigationControl(zoom))
                map.enableScrollWheelZoom(true)
            } else {
                alert('您选择地址没有解析到结果!')
            }
        }, '北京市')
    }, 1500)
}
/* eslint-disable */
onMounted(() => {
    initMap('map_box', systemInfo.value?.company, systemInfo.value?.address)
})
</script>

<style lang="scss" scoped></style>
