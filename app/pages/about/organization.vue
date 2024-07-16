<template>
    <section>
        <CiSubMenu />
        <div class="container ma px10px text-center ">
            <div class="min-h-300px py50px">
                <img :src="comData?.img || ''" alt="">
            </div>
        </div>
    </section>
</template>

<script lang="ts" setup>
import type { Prisma } from '@prisma/client'

definePageMeta({
    layout: 'home',
})

const { data } = await useCustomFetch<Prisma.OtherMaxAggregateOutputType>('/api/v1/page/other', {
    params: {
        type: 'organization',
    },
})
const comData=data.value?.data
</script>

<style lang="scss" scoped></style>
