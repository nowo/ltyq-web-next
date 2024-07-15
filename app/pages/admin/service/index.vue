<script setup lang="ts">
import DownloadList from './components/DownloadList.vue'
import SetRepair from './components/SetRepair.vue'

definePageMeta({
    layout: 'admin',
    title: '服务与支持',
    icon: 'i-ep-shop',
    sort: 20,
})

</script>

<template>
    <LayoutBox class="hei p0px!">
        <el-tabs tab-position="left" class="tab-box">
            <el-tab-pane label="资料下载">
                <el-scrollbar>
                    <client-only>
                        <DownloadList class="pl15px" />
                    </client-only>
                </el-scrollbar>
            </el-tab-pane>
            <el-tab-pane label="服务维修" lazy>
                <el-scrollbar>
                    <SetRepair class="pl15px" />
                </el-scrollbar>
            </el-tab-pane>
        </el-tabs>
    </LayoutBox>
</template>

<style scoped lang="scss">
.tab-box {
    height: 100%;

    :deep(.el-tabs__nav-wrap.is-left) {
        --el-border-color-light: var(--el-border-color-extra-light);
        --el-tabs-header-height: 48px;

        .el-tabs__item {
            min-width: 120px;

            &.is-active {

                background-color: var(--el-color-primary-light-9);
            }
        }

    }

    :deep(.el-tabs__content) {
        height: 100%;

        .el-tab-pane {
            height:100%;
        }
    }
}
</style>
