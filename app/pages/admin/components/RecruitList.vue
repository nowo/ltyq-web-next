<script setup lang="ts">
import type { Message, Recruit } from '@prisma/client'
import type { FormRules } from 'element-plus'
import OperateModal from './RecruitModal.vue'



const modalRef = ref<InstanceType<typeof OperateModal>>()
const stateData = reactive({
    statusList: [
        { title: '开启', id: 1 },
        { title: '关闭', id: 0 },
    ],
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
        { column: { label: '岗位名称', prop: 'title' }, placeholder: '', width: '160' },
        // { column: { label: '文件类型', prop: 'type' }, placeholder: '', width: '130' },
        { column: { label: '状态', prop: 'state' }, placeholder: '', width: '100' },
        { column: { label: '日期范围', prop: 'time' } },
    ],
    hideBtn: false,
    // showAll: true,
})

const rules = reactive<FormRules>({
    money: [],
})

const tableData = reactive<CoTableProps<Recruit>>({
    data: [],
    tableHeader: [
        { property: 'id', label: 'id', width: '80' },
        { property: 'title', label: '招聘岗位', minWidth: 130 },
        // { property: 'title_en', label: '英文标题', minWidth: 150 },
        { property: 'people', label: '招聘人数', width: 120, align: 'center' },
        { property: 'address', label: '工作地区', minWidth: 120 },
        { property: 'sort', label: '排序', width: 100, align: 'center' },
        { property: 'createdAt', label: '操作时间', width: 210 },
        { property: 'status', label: '状态', width: 100, align: 'center' },
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
        // type:searchData.data.type || '',
        isPage: true,
        page: tableData.pagination.page,
        pageSize: tableData.pagination.pageSize,
    }

    tableData.loading = true
    const res = await useServerFetch<{ list: Recruit[], total: number }>('/api/v1/recruit/list', {
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
const onOpenDialog = (type: DialogOperate, row?: Recruit) => {
    modalRef.value?.openModal(type, row)
}

// 删除用户
const onDel = (row: Recruit) => {
    ElMessageBox.confirm(`此操作将永久删除该条内容，是否继续?`, '提示', {
        confirmButtonText: '确认',
        cancelButtonText: '取消',
        type: 'warning',
        buttonSize: 'default',
    }).then(async () => {
        const res = await useServerFetch('/api/v1/recruit/delete', {
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
            <template #state="{ row }">
                <el-select v-model="row.state" filterable clearable>
                    <el-option v-for="(item, key) in stateData.statusList" :key="key" :label="item.title"
                        :value="item.id" />
                </el-select>
            </template>
            <template #time="{ row }">
                <CoDatePicker v-model="row.time" />
            </template>
            <el-button v-if="checkPermission('add')" type="success" @click="onOpenDialog('add')">
                <el-icon class="i-ep-folder-add mr2px">
                    <!-- <ele-FolderAdd /> -->
                </el-icon>
                新增招聘
            </el-button>
        </CoFormTool>
        <CoTable v-model:option="tableData" auto-height border @refresh="initTableData">
            <template #status="{ row }">
                <el-tag v-if="row.status" type="warning">
                    开启
                </el-tag>
                <el-tag v-else type="danger">
                    关闭
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
            <OperateModal ref="modalRef" title="招聘" @update="initTableData" />
        </client-only>
    </LayoutBox>
</template>
