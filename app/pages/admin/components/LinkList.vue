<script setup lang="ts">
import type { Link } from '@prisma/client'
import type { FormRules } from 'element-plus'
import OperateModal from './LinkModal.vue'


const props = defineProps<{
    type: number | string
    title: string
    key?: 'download' | 'about'
}>()

provide('propsData',props)

const modalRef = ref<InstanceType<typeof OperateModal>>()
const stateData = reactive({
    typeList: {
        1: '轮播图',
        2: '产品图片',
        // 3:'',
        4: '文档',
        5: '视频',
        6: '其他',
        7: '外链',
        8: '合作伙伴',
        9: '公司介绍图',
    }
})

const typeData = computed(() => {
    let dat: Record<string | number, string> = {}
    if (props.key === 'download') {
        dat = {
            4: '文档',
            5: '视频',
            6: '其他',
        }
    }
    return dat
})

// form表单数据类型
interface FormSearchData {
    type: '' // 账号
    title: '' // 标题

    time: DateRangeType // 时间范围
    state: '' // 状态：1：启用，2：禁用
}

const searchData = reactive<CoFormToolProps<FormSearchData>>({
    data: {
        type: '', // 账号
        title: '', // 标题
        time: ['', ''] as DateRangeType, // 时间范围
        state: '', // 状态：1：未审核，2：已审核
    },
    config: [
        { column: { label: '标题名称', prop: 'title' }, placeholder: '', width: '160' },
        { column: { label: '类型', prop: 'type' }, placeholder: '', width: '130',isHide: props.key !== 'download' },
        { column: { label: '状态', prop: 'state' }, placeholder: '', width: '100' },
        { column: { label: '日期范围', prop: 'time' } },
    ],
    hideBtn: false,
    // showAll: true,
})

const rules = reactive<FormRules>({
    money: [],
})

const tableData = reactive<CoTableProps<Link>>({
    data: [],
    tableHeader: [
        { property: 'id', label: 'id', width: '80' },

        { property: 'title', label: '标题名称', minWidth: '180' },
        { property: 'title_en', label: '英文标题名称', width: '180' },
        { property: 'img', label: '图片', width: '150', align: 'center' },
        { property: 'href', label: '链接地址', minWidth: '150' },
        { property: 'type', label: '类型', width: '160', align: 'center', other: { isHide: props.key !== 'download' } },
        // { property: 'status姓名', width: '180' },
        { property: 'status', label: '状态', align: 'center', width: '90' },
        { property: 'created_at', label: '创建时间', width: '220' },
        // { property: 'update_at', label: '更新时间', width: '180' },
        // { property: 'remark', label: '备注', width: '180' },
        { property: 'operate', label: '操作', width: '120', align: 'center', fixed: 'right' },

    ],
    pagination: paginationConfig,
    isTool: true,
})


const initTableData = async () => {
    const params = {
        // account: searchData.data.account?.trim() ?? '',
        title: searchData.data.title?.trim() ?? '',
        status: searchData.data.state,
        type: searchData.data.type || '',
        isPage: true,
        page: tableData.pagination.page,
        pageSize: tableData.pagination.pageSize,
    }
    if (!searchData.data.type) params.type = props.type.toString()
    tableData.loading = true
    const res = await useServerFetch<{ list: Link[], total: number }>('/api/v1/link/list', {
        method: 'post',
        body: params,
    })
    tableData.loading = false

    if (res.code !== 200) return ElMessage.error(res.msg)

    tableData.data = res.data.list
    tableData.pagination.total = res.data.total || 0
}

// 搜索
const onSearch = () => {
    initTableData()
}

// 重置
const onReset = () => {
    initTableData()
}

// 打开新增、修改
const onOpenDialog = (type: DialogOperate, row?: Link) => {
    modalRef.value?.openModal(type, row)
}

// 删除用户
const onDel = (row: Link) => {
    ElMessageBox.confirm(`此操作将永久删除该条内容，是否继续?`, '提示', {
        confirmButtonText: '确认',
        cancelButtonText: '取消',
        type: 'warning',
        buttonSize: 'default',
    }).then(async () => {
        const res = await useServerFetch('/api/v1/link/delete', {
            method: 'post',
            body: { id: row.id },
        })
        if (res.code !== 200) return ElMessage.error(res.msg)

        ElMessage.success('删除成功')

        initTableData() // 重新加载列表
    }).catch(() => { })
}

initTableData()
</script>

<template>
    <LayoutBox>
        <CoFormTool v-model:option="searchData" :rules="rules" inline @search="onSearch" @reset="onReset">
            <template #type="{ row }">
                <el-select v-model="row.type" filterable clearable>
                    <el-option v-for="(item, index) in typeData" :key="index" :label="item" :value="index" />
                </el-select>
            </template>
            <template #state="{ row }">
                <el-select v-model="row.state" filterable clearable>
                    <el-option label="启用" :value="1" />
                    <el-option label="禁用" :value="0" />
                </el-select>
            </template>
            <template #time="{ row }">
                <CoDatePicker v-model="row.time" />
            </template>
            <el-button v-if="checkPermission('add')" type="success" @click="onOpenDialog('add')">
                <el-icon class="i-ep-folder-add mr2px">
                    <!-- <ele-FolderAdd /> -->
                </el-icon>
                新增{{ props.title }}
            </el-button>
        </CoFormTool>
        <CoTable v-model:option="tableData" auto-height border @refresh="initTableData">
            <template #img="{ row }">
                <CoImage :src="row.img" :icon-size="28" :preview-src-list="[row.img]" preview-teleported
                        fit="contain" class="ma h50px w100px block!"  />
            </template>
            <template #status="{ row }">
                <el-tag v-if="row.status" type="primary">
                    启用
                </el-tag>
                <el-tag v-else type="info">
                    禁用
                </el-tag>
            </template>
            <template #type="{ row }">
                {{ typeData[row.type as 4] }}
            </template>
            <template #operate="{ row }">
                <el-button v-if="checkPermission('edit')" type="primary" link @click="onOpenDialog('edit', row)">
                    修改
                </el-button>
                <el-button v-if="checkPermission('del')" type="danger" link
                    @click="onDel(row)">
                    删除
                </el-button>
            </template>
        </CoTable>
        <client-only>
            <OperateModal ref="modalRef" :list="typeData" @update="initTableData" />
        </client-only>
    </LayoutBox>
</template>
