<script setup lang="ts">
import type { Classify } from '@prisma/client'
import type { FormRules } from 'element-plus'
import ClassifyModal from './components/ClassifyModal.vue'

definePageMeta({
    layout: 'admin',
    title: '产品中心',
    icon: 'i-ep-user',
    sort: 10,
    // keepalive: true
    permissionList: {
        add: '新增',
        edit: '编辑',
        del: '删除',
        // view: '删除',
        // read: '删除',
    },
})

const modalRef = ref<InstanceType<typeof ClassifyModal>>()
// const modalRef = ref<any>()
const stateData = reactive({
    menuList: [] as Classify[], // 用于传递给子组件使用
})

// form表单数据类型
interface FormSearchData {
    account: '' // 账号
    title: '' // 标题

    time: DateRangeType // 时间范围
    state: '' // 状态：1：启用，2：禁用
}

const searchData = reactive<CoFormToolProps<FormSearchData>>({
    data: {
        account: '', // 账号
        title: '', // 标题
        time: ['', ''] as DateRangeType, // 时间范围
        state: '', // 状态：1：未审核，2：已审核
    },
    config: [
        { column: { label: '分类名称', prop: 'title' }, placeholder: '', width: '160' },
        // { column: { label: '账号', prop: 'account' }, placeholder: '', width: '160' },
        { column: { label: '状态', prop: 'state' }, placeholder: '', width: '100' },
        { column: { label: '日期范围', prop: 'time' } },
    ],
    hideBtn: false,
    // showAll: true,
})

const rules = reactive<FormRules>({
    money: [],
})

const tableData = reactive<CoTableProps<Classify>>({
    data: [],
    tableHeader: [
        { property: 'id', label: 'id', width: '50' },

        { property: 'title', label: '分类名称', minWidth: '180' },
        { property: 'title_en', label: '英文分类名称', width: '180' },
        // { property: 'role', label: '角色名称', width: '130', align: 'center' },
        { property: 'sort', label: '排序', width: '100', align: 'center', },
        { property: 'status', label: '状态', align: 'center', width: '100' },
        { property: 'createdAt', label: '创建时间', width: '220' },
        // { property: 'update_at', label: '更新时间', width: '180' },
        // { property: 'remark', label: '备注', width: '180' },
        { property: 'operate', label: '操作', width: '120', align: 'center', fixed: 'right' },

    ],
    pagination: paginationConfig,
    isTool: true,
})

const initTableData = async (isUpdate?: boolean) => {
    const params = {
        title: searchData.data.title?.trim() ?? '',
        status: searchData.data.state || '',
        isPage: true,
        page: tableData.pagination.page,
        pageSize: tableData.pagination.pageSize,
    }
    tableData.loading = true
    const res = await useServerFetch<{ list: Classify[], total: number }>('/api/v1/classify/list', {
        method: 'post',
        body: params,
    })
    tableData.loading = false

    if (res.code !== 200) return ElMessage.error(res.msg)
    console.log(res)
    tableData.data = res.data.list
    tableData.pagination.total = res.data.total || 0

    if (isUpdate) stateData.menuList = res.data.list
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
const onOpenDialog = (type: DialogOperate, row?: Classify) => {
    modalRef.value?.openModal(type, row)
}

// 删除用户
const onDel = (row: Classify) => {
    ElMessageBox.confirm(`此操作将永久删除该条内容，是否继续?`, '提示', {
        confirmButtonText: '确认',
        cancelButtonText: '取消',
        type: 'warning',
        buttonSize: 'default',
    }).then(async () => {
        const res = await useServerFetch('/api/v1/classify/delete', {
            method: 'post',
            body: { id: row.id },
        })
        if (res.code !== 200) return ElMessage.error(res.msg)

        ElMessage.success('删除成功')

        initTableData(true) // 重新加载列表
    }).catch(() => { })
}

initTableData(true)
</script>

<template>
    <LayoutBox>
        <CoFormTool v-model:option="searchData" :rules="rules" inline @search="onSearch" @reset="onReset">
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
                新增分类
            </el-button>
        </CoFormTool>
        <CoTable v-model:option="tableData" auto-height border @refresh="initTableData">
            <template #status="{ row }">
                <el-tag v-if="row.status" type="primary">
                    启用
                </el-tag>
                <el-tag v-else type="info">
                    禁用
                </el-tag>
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
            <ClassifyModal ref="modalRef" :data="stateData.menuList" @update="initTableData(true)" />
        </client-only>
    </LayoutBox>
</template>
