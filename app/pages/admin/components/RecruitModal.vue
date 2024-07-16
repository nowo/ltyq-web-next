<script lang="ts" setup>
import type { Recruit, Prisma, Link } from '@prisma/client'
import type { CheckboxValueType, FormInstance, FormRules } from 'element-plus'


const props = defineProps<{
    title: string
}>()

const emits = defineEmits<{
    update: []
}>()

const visible = ref(false)
const lang = ref<LanguageType>('cn')
const operate = ref<DialogOperate>()
const comData = computed(() => {
    if (operate.value === 'add') return { title: `新增${props.title}` }
    return { title: `修改${props.title}` }
})
const formRef = ref<FormInstance>()
const form = reactive({
    data: {
        id: 0,
        title: '', // 菜单名称
        title_en: '', // 菜单名称（英文）
        address: '',
        address_en: '',
        people: '',
        describe: '', // 简介
        describe_en: '', // 简介

        content: '',
        content_en: '',
        status: true, // 是否首页显示，默认否
        sort: 0, // 排序
    },
})

const rules = reactive<FormRules>({

    title: [
        { required: true, message: '必填项不能为空', whitespace: true },

    ],
    type: [
        { required: true, message: '必填项不能为空' },
    ],
    // email: [
    //     { required: true, message: 'Please input Activity name' },
    //     { min: 3, max: 5, message: 'Length should be 3 to 5' },
    // ],
})


const openModal = (type: DialogOperate, row?: Recruit) => {
    operate.value = type
    if (type === 'edit') { // 修改


        form.data.id = row?.id || 0
        form.data.title = row?.title || ''
        form.data.title_en = row?.title_en || ''

        form.data.address = row?.address || ''
        form.data.address_en = row?.address_en || ''

        form.data.people = row?.people || ''
        form.data.describe = row?.describe || ''
        form.data.describe_en = row?.describe_en || ''

        form.data.content = row?.content || ''
        form.data.content_en = row?.content_en || ''

        form.data.status = !!row?.status
        form.data.sort = row?.sort || 0
    } else {

        form.data.id = 0
        form.data.title = ''
        form.data.title_en = ''
        form.data.address = ''
        form.data.address_en = ''

        form.data.people = ''
        form.data.describe = ''
        form.data.describe_en = ''

        form.data.content = ''
        form.data.content_en = ''

        form.data.status = true
        form.data.sort = 0
    }
    visible.value = true
}

const closeModal = () => {
    visible.value = false
}

// 取消
const onCancel = () => {
    visible.value = false
}

const [ApiFunc, btnLoading] = useLoadingSubmit()
// 确定
const onConfirm = useThrottleFn(async () => {

    const isVerify = await useFormVerify(formRef.value)
    if (!isVerify) return


    const data: Prisma.RecruitUncheckedCreateInput = {
        sort: Number(form.data.sort),
        title: form.data.title?.trim() ?? '',
        title_en: form.data.title_en?.trim() ?? '',
        describe: form.data.describe?.trim() ?? '',
        describe_en: form.data.describe_en?.trim() ?? '',
        content: form.data.content?.trim() ?? '',
        content_en: form.data.content_en?.trim() ?? '',
        status: form.data.status,
        address: form.data.address || '',
        address_en: form.data.address_en || '',
        people: form.data.people || '',
    }

    if (operate.value === 'add') {
        const res = await ApiFunc(useServerFetch('/api/v1/recruit/add', {
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
        const res = await ApiFunc(useServerFetch('/api/v1/message/edit', {
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
    closeModal,
})
</script>

<template>
    <CoDrawer v-model="visible" :title="comData.title" :loading="btnLoading" :width="{ lg: 50, md: 75, sm: 80 }"
        @cancel="onCancel" @confirm="onConfirm">
        <el-form ref="formRef" :model="form.data" :rules="rules" label-width="110px">
            <el-tabs v-model="lang" class="-mt15px">
                <el-tab-pane label="中文" name="cn" />
                <el-tab-pane label="英文" name="en" />
            </el-tabs>

            <el-form-item v-if="lang === 'cn'" label="岗位名称" prop="title">
                <el-input v-model="form.data.title" maxlength="20" placeholder="请输入岗位名称" clearable />
            </el-form-item>
            <el-form-item v-else-if="lang === 'en'" label="英文岗位名称" prop="title_en">
                <el-input v-model="form.data.title_en" maxlength="50" placeholder="请输入英文岗位名称" clearable />
            </el-form-item>
            <el-form-item label="招聘人数" prop="people">
                <el-input v-model="form.data.people" maxlength="30" placeholder="请输入招聘人数" clearable />
            </el-form-item>



            <template v-if="lang === 'cn'">
                <el-form-item label="工作地区" prop="address">
                    <el-input v-model="form.data.address" maxlength="20" placeholder="请输入工作地区" clearable />
                </el-form-item>
                <el-form-item label="岗位描述" prop="describe">
                    <CoEditor v-model="form.data.describe" placeholder="" clearable />
                </el-form-item>
                <el-form-item label="职责要求" prop="content">
                    <CoEditor v-model="form.data.content" />
                </el-form-item>
            </template>
            <template v-else-if="lang === 'en'">
                <el-form-item label="英文工作地区" prop="address_en">
                    <el-input v-model="form.data.address_en" maxlength="50" placeholder="请输入英文工作地区" clearable />
                </el-form-item>
                <el-form-item label="岗位描述" prop="describe_en">
                    <CoEditor v-model="form.data.describe_en" placeholder="" clearable />
                </el-form-item>
                <el-form-item label="英文职责要求" prop="content_en">
                    <CoEditor v-model="form.data.content_en" />
                </el-form-item>
            </template>
            <el-form-item label="状态" prop="status">
                <el-radio-group v-model="form.data.status">
                    <el-radio :label="true">
                        开启
                    </el-radio>
                    <el-radio :label="false">
                        关闭
                    </el-radio>
                </el-radio-group>
            </el-form-item>
            <el-form-item label="排序" prop="sort">
                <el-input-number v-model="form.data.sort" :min="0" :max="10000" controls-position="right" placeholder=""
                    class="w100%" />
            </el-form-item>
        </el-form>
    </CoDrawer>
</template>

<style lang="scss" scoped></style>
