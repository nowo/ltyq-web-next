<script lang="ts" setup>
import type { Classify, Prisma } from '@prisma/client'
import type { CheckboxValueType, FormInstance, FormRules } from 'element-plus'
import { deepClone } from '@cooj/utils'

const props = defineProps<{
    data: Classify[]
}>()

const emits = defineEmits<{
    update: []
}>()

const operate = ref<DialogOperate>()
const stateData = reactive({
    visible: false, // 弹窗显示
    menuData: [] as Prisma.ClassifyUncheckedCreateInput[], // 上级菜单数据
    ready: false,

})

const comData = computed(() => {
    if (operate.value === 'add') return { title: '新增菜单' }
    return { title: '修改菜单' }
})
const formRef = ref<FormInstance>()
const form = reactive({
    data: {
        id: 0,
        p_id: 0 as number | '', // 父级id
        title: '',
        title_en: '',
        // href: '',
        // icon: '',
        sort: 0,

        status: 1, // 1:启用 0:禁用
        // imgList: [] as string[], // 图片列表
    },
})

const rules = reactive<FormRules>({
    title: [ // 菜单名称
        { required: true, whitespace: true, message: '必填项不能为空', trigger: 'blur' },
    ],
    // title_en: [ // 菜单名称
    //     { required: true, whitespace: true, message: '必填项不能为空', trigger: 'blur' },
    // ],
    href: [
        // { required: true, pattern: /^(\/([A-Za-z0-9_-]*))+$/, message: '以/开头,后面为字母或数字,不能有空格' },
        { required: true, whitespace: true, message: '必填项不能为空', trigger: 'blur' },
    ],
    img: [ // 图片
        { required: true, whitespace: true, message: '必填项不能为空', trigger: 'blur' },
    ],
})


const openModal = (type: DialogOperate, row?: Classify) => {
    operate.value = type
    const arr = deepClone(props.data)

    if (type === 'edit' && row) { // 修改

        form.data.id = row.id
        form.data.title = row.title || ''
        form.data.title_en = row.title_en || ''
        form.data.sort = row.sort || 0
        form.data.p_id = row.p_id || ''
        form.data.status = row.status ? 1 : 0
    } else { // 新增
        form.data.id = 0
        form.data.title = ''
        form.data.title_en = ''
        form.data.sort = 0
        form.data.status = 1

        if (row) form.data.p_id = typeof row.id === 'number' ? row.id : ''
    }
    stateData.menuData = arr
    stateData.visible = true
}

// 取消
const onCancel = () => {
    stateData.visible = false
}

const [ApiFunc, btnLoading] = useLoadingSubmit()
// 确定
const onConfirm = useThrottleFn(async () => {
    const isVerify = await useFormVerify(formRef.value)
    // console.log(isVerify)
    if (!isVerify) return

    const data: Prisma.ClassifyUncheckedCreateInput = {
        p_id: Number(form.data.p_id),
        title: form.data.title?.trim() ?? '',
        title_en: form.data.title_en?.trim() ?? '',
        sort: Number(form.data.sort),
        status: form.data.status ? 1 : 0,
    }

    // // console.log(data)
    if (operate.value === 'add') {
        const res = await ApiFunc(useServerFetch('/api/v1/classify/add', {
            method: 'POST',
            body: data,
        }))
        if (res.code !== 200) return ElMessage.error(res.msg)
        ElMessage.success('添加成功')
    } else if (operate.value === 'edit') {
        const param = {
            ...data,
            id: form.data.id,
        }
        const res = await ApiFunc(useServerFetch('/api/v1/classify/edit', {
            method: 'POST',
            body: param,
        }))
        if (res.code !== 200) return ElMessage.error(res.msg)
        ElMessage.success('修改成功')
    }

    emits('update') // 更新列表
    onCancel()
}, 800)

defineExpose({
    openModal,
})
</script>

<template>
    <CoDrawer v-model="stateData.visible" :title="comData.title" :loading="btnLoading"
        :width="{ lg: 40, md: 50, sm: 60 }" @cancel="onCancel" @confirm="onConfirm">
        <el-form ref="formRef" :model="form.data" :rules="rules" label-width="120px">
            <el-form-item label="上级分类:" prop="p_id">
                <el-select v-model="form.data.p_id" filterable clearable>
                    <el-option v-for="item in stateData.menuData" :key="item.id" :label="item.title as string"
                        :value="item.id as number" />

                </el-select>
            </el-form-item>
            <el-form-item label="分类名称:" prop="title">
                <el-input v-model="form.data.title" maxlength="20" placeholder="请输入分类名称" clearable />
            </el-form-item>

            <el-form-item label="英文分类名称:" prop="title_en">
                <el-input v-model="form.data.title_en" maxlength="30" placeholder="请输入英文分类名称" clearable />
            </el-form-item>

            <el-form-item label="排序:">
                <el-input-number v-model="form.data.sort" :min="0" :max="10000" controls-position="right" placeholder=""
                    class="w100%" />
            </el-form-item>
            <el-form-item label="状态:">
                <el-switch v-model="form.data.status" inline-prompt active-text="显示" inactive-text="隐藏"
                    :active-value="1" :inactive-value="0" />
            </el-form-item>
        </el-form>
    </CoDrawer>
</template>

<style lang="scss" scoped></style>
