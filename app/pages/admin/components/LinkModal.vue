<script lang="ts" setup>
import type { Product, Prisma, Link } from '@prisma/client'
import type { CheckboxValueType, FormInstance, FormRules } from 'element-plus'


const props = defineProps<{
    // type: number
    // title: string
    list: Record<string, string>
}>()

const emits = defineEmits<{
    update: []
}>()

const injectData = inject<{ title: string, type: number | string, key?: 'download' }>('propsData')

const lang = ref<LanguageType>('cn')
const visible = ref(false)

const operate = ref<DialogOperate>()
const comData = computed(() => {
    if (operate.value === 'add') return { title: `新增${injectData?.title}` }
    return { title: `修改${injectData?.title}` }
})
const formRef = ref<FormInstance>()
const form = reactive({
    data: {
        id: 0,
        title: '',
        title_en: '',
        author: '',
        describe: '',
        describe_en: '',
        content: '',
        content_en: '',

        status: true, // 1:启用 0:禁用
        isHot: false,
        type: '',
        img: '',
        imgList: [] as string[],
        href: '',
        hrefList: [] as string[],
        sort: 1,
    },
})

const rules = reactive<FormRules>({
    account: [
        { required: true, message: '必填项不能为空' },
        { pattern: /^[0-9a-z]+$/i, message: '只能输入数字和英文' },
        { min: 2, max: 16, message: '最少2个,最多16个字符' },
    ],
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


const openModal = (type: DialogOperate, row?: Link) => {
    operate.value = type
    if (type === 'edit') {

        form.data.title = row?.title || ''
        form.data.title_en = row?.title_en || ''
        form.data.content = row?.content || ''
        form.data.content_en = row?.content_en || ''
        // form.data.describe = row?.describe || ''
        // form.data.describe_en = row?.describe_en || ''

        form.data.sort = row?.sort || 0
        form.data.status = row?.status ? true : false
        form.data.id = row?.id || 0
        form.data.type = row?.type?.toString() || ''

        form.data.imgList = row?.img ? [row?.img] : []
        form.data.hrefList = row?.href ? [row?.href] : []
        form.data.href = row?.href || ''

    } else {
        form.data.title = ''
        form.data.title_en = ''
        form.data.describe = ''
        form.data.describe_en = ''
        form.data.content = ''
        form.data.content_en = ''
        form.data.sort = 0

        form.data.status = true
        form.data.isHot = false
        form.data.id = 0

        form.data.type = injectData?.key === 'download' ? '4' : `${injectData!.type}`
        form.data.imgList = []
        form.data.hrefList = []
        form.data.href = ''
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
    // console.log(form.data.type)

    let type = form.data.type
    if (!type) {
        type = injectData?.key === 'download' ? '4' : `${injectData!.type}`
    }
    let href = form.data.hrefList[0] ?? ''
    if (injectData?.key !== 'download') {
        href = form.data.href
    }
    const isVerify = await useFormVerify(formRef.value)
    if (!isVerify) return


    const data: Prisma.LinkUncheckedCreateInput = {
        title: form.data.title?.trim() ?? '',
        title_en: form.data.title_en?.trim() ?? '',
        // author: form.data.author?.trim() ?? '',
        // describe: form.data.describe?.trim() ?? '',
        // describe_en: form.data.describe_en?.trim() ?? '',
        content: form.data.content?.trim() ?? '',
        content_en: form.data.content_en?.trim() ?? '',
        sort: form.data.sort || 0,
        status: !!form.data.status,
        type: Number(type),
        img: form.data.imgList[0] ?? '',
        href,
    }

    if (operate.value === 'add') {
        const res = await ApiFunc(useServerFetch('/api/v1/link/add', {
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
        const res = await ApiFunc(useServerFetch('/api/v1/link/edit', {
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
            <el-tabs v-model="lang" class="-mt10px">
                <el-tab-pane label="中文" name="cn" />
                <el-tab-pane label="英文" name="en" />
            </el-tabs>

            <el-form-item v-if="lang === 'cn'" label="标题" prop="title">
                <el-input v-model="form.data.title" maxlength="20" placeholder="请输入标题" clearable />
            </el-form-item>
            <el-form-item v-else-if="lang === 'en'" label="英文标题" prop="title_en">
                <el-input v-model="form.data.title_en" maxlength="50" placeholder="请输入英文标题" clearable />
            </el-form-item>

            <!-- <el-form-item v-if="lang === 'cn'" label="副标题" prop="sub_title">
                <el-input v-model="form.data.sub_title" maxlength="20" placeholder="请输入副标题" clearable />
            </el-form-item>
            <el-form-item v-else-if="lang === 'en'" label="英文副标题" prop="sub_title_en">
                <el-input v-model="form.data.sub_title_en" maxlength="50" placeholder="请输入英文副标题" clearable />
            </el-form-item> -->

            <!-- <el-form-item label="发布者" prop="author">
                <el-input v-model="form.data.author" maxlength="30" placeholder="请输入名称" clearable />
            </el-form-item> -->
            <el-form-item label="图片上传" prop="imgList">
                <CoUploadPhoto v-model="form.data.imgList" />
            </el-form-item>
            <template v-if="injectData?.key === 'download'">
                <el-form-item label="文件类型" prop="type">
                    <el-select v-model="form.data.type" filterable clearable>
                        <el-option v-for="(item, index) in props.list" :key="index" :label="item" :value="index" />
                    </el-select>
                </el-form-item>
                <el-form-item label="文件上传" prop="hrefList">
                    <CoUploadPhoto v-model="form.data.hrefList" drag list-type="text" accept="*" />
                </el-form-item>
            </template>
            <el-form-item v-else label="链接地址" prop="href">
                <el-input v-model="form.data.href" maxlength="255" placeholder="请输入链接地址" clearable />
            </el-form-item>

            <template v-if="lang === 'cn'">
                <el-form-item label="详细内容" prop="content">
                    <CoEditor v-model="form.data.content" />
                </el-form-item>
            </template>
            <template v-else-if="lang === 'en'">
                <el-form-item label="英文详细内容" prop="content_en">
                    <CoEditor v-model="form.data.content_en" />
                </el-form-item>
            </template>

            <el-form-item label="状态" prop="status">
                <el-radio-group v-model="form.data.status">
                    <el-radio :value="true">
                        显示
                    </el-radio>
                    <el-radio :value="false">
                        隐藏
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
