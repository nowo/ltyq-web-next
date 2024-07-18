<script setup lang="ts">
import zhCn from 'element-plus/dist/locale/zh-cn.mjs'

useHead({
    title: appName,
})

const {systemInfo} = await useSystemState()

// const runtimeConfig = useRuntimeConfig()
// const HOST = runtimeConfig.public.upload.host
const url = useRequestURL()
console.log(url)
useHead({
    title: systemInfo.value?.title,
    meta: [
        { name: 'description', content: systemInfo.value?.description },
        { name: 'keywords', content: systemInfo.value?.keyword },
    ],
    link: [
        { rel: 'icon', href: systemInfo.value?.icon },
    ],
    script: [
        {
            type: 'application/ld+json',
            innerHTML: JSON.stringify({
                '@context': 'http://schema.org',
                '@type': 'Organization',
                'name': systemInfo.value?.company,
                'url': url.host,
                'logo': systemInfo.value?.logo,
            }),
        },
        { innerHTML: 'var _hmt = _hmt || [];' },
        // {
        //     type: 'text/javascript',
        //     src: baiduUrl,
        //     // async: true,
        //     // defer: true,
        //     // crossorigin: 'anonymous',
        //     // referrerpolicy: 'no-referrer-when-downgrade',
        // },
    ],
    // bodyAttrs: {
    //     class: 'test',
    // },
    // script: [{ innerHTML: 'console.log(\'Hello world\')' }],
})
</script>

<template>
    <el-config-provider :locale="zhCn">
        <VitePwaManifest />
        <NuxtLayout>
            <NuxtPage />
        </NuxtLayout>
    </el-config-provider>
</template>

<style lang="scss">
@import url("~/assets/scss/element-plus.scss");
@import url("~/assets/scss/transition.scss");

html,
body,
#__nuxt {
    // height: 100vh;
    margin: 0;
    padding: 0;
    font-size: 14px;
    color:#333;
}

html.dark {
    background: #222;
    color: white;
}
</style>
