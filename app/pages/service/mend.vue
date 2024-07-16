<template>
    <section>
        <!-- 分类 -->
        <CiSubMenu />
        <article class="container ma px10px">
            <div class="py50px">
                <div class="lh-32px">
                    <strong>{{ $lang(comData?.title, comData?.title_en) }}</strong>
                    <br>
                    <strong>{{ $lang(comData?.subtitle, comData?.subtitle_en) }}</strong>
                </div>
                <div v-html="$lang(comData?.content, comData?.content_en)" />
            </div>
        </article>
    </section>
</template>

<script lang="ts" setup>
import type { Other } from '@prisma/client'
const { $lang } = useNuxtApp()

definePageMeta({
    layout: 'home',
})

const { data } = await useCustomFetch<Other>('/api/v1/page/other', {
    params: {
        type: 'service-mend',
    },
})

const comData=data.value?.data
</script>

<style lang="scss" scoped>

</style>
