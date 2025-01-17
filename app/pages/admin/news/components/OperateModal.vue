<script lang="ts" setup>
import type { News, Prisma } from '@prisma/client'
import type { CheckboxValueType, FormInstance, FormRules } from 'element-plus'


const props = defineProps<{
    // type: number
    title: string
    list: {title:string,id:number}[]
}>()

const emits = defineEmits<{
    update: []
}>()

const { adminRoutes } = useAdminMenuState()
const { userInfo, setUserInfo } = useUserState()

const lang = ref<LanguageType>('cn')
const visible = ref(false)

const operate = ref<DialogOperate>()
const comData = computed(() => {
    if (operate.value === 'add') return { title: '新增新闻' }
    return { title: '修改新闻' }
})
const formRef = ref<FormInstance>()
const form = reactive({
    data: {
        id: 0,
        title: '',
        title_en: '',
        author: '',
        status: 1, // 1:启用 0:禁用
        type: 1,
        describe: '',
        describe_en: '',
        content: '',
        content_en: '',
        img: [] as string[],
        read:0,
        sort: 1,
        isIndex:false,
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
    // email: [
    //     { required: true, message: 'Please input Activity name' },
    //     { min: 3, max: 5, message: 'Length should be 3 to 5' },
    // ],
    password: [
        { required: true, message: '必填项不能为空', whitespace: true },
        { pattern: /^[^\u4E00-\u9FA5 ]{6,16}$/, message: '不含有中文和空格,至少6位,最多16位' },
    ],
    role: [
        { required: true, message: '必填项不能为空' },

    ],
})


const openModal = (type: DialogOperate, row?: News) => {
    operate.value = type
    if (type === 'edit') {
        // console.log(row)
        form.data.title = row?.title || ''
        form.data.title_en = row?.title_en || ''
        form.data.describe = row?.describe || ''
        form.data.describe_en = row?.describe_en || ''
        form.data.content = row?.content || ''
        form.data.content_en = row?.content_en || ''
        form.data.author = row?.author || ''
        form.data.img = [row?.img || '']
        form.data.status = row?.status ? 1 : 0
        form.data.read = row?.read || 0
        form.data.type=row?.type||1
        form.data.id = row?.id || 0
        form.data.isIndex = !!row?.isIndex

    } else {
        form.data.title = ''
        form.data.title_en = ''
        form.data.describe = ''
        form.data.describe_en = ''
        form.data.content = ''
        form.data.content_en = ''
        form.data.status = 1
        form.data.id = 0
        form.data.sort=0
        form.data.author = ''
        form.data.read=0
        form.data.type=1
        form.data.img = []
        form.data.isIndex = false
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


    const data: Prisma.NewsUncheckedCreateInput = {
        title: form.data.title?.trim() ?? '',
        title_en: form.data.title_en?.trim() ?? '',
        describe: form.data.describe?.trim() ?? '',
        describe_en: form.data.describe_en?.trim() ?? '',
        content: form.data.content?.trim() ?? '',
        content_en: form.data.content_en?.trim() ?? '',
        author: form.data.author?.trim() ?? '',
        sort: form.data.sort || 0,
        read: form.data.sort || 0,
        status: !!form.data.status,
        isIndex: !!form.data.isIndex,
        type: form.data.type || 1,
        img:form.data.img?.[0] ?? ''
    }

    // // console.log(data)
    if (operate.value === 'add') {
        const res = await ApiFunc(useServerFetch('/api/v1/news/add', {
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
        const res = await ApiFunc(useServerFetch('/api/v1/news/edit', {
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

            <el-form-item label="发布者" prop="author">
                <el-input v-model="form.data.author" maxlength="30" placeholder="请输入名称" clearable />
            </el-form-item>
            <el-form-item label="新闻类型" prop="type">
                <el-select v-model="form.data.type" clearable filterable>
                    <el-option v-for="item in props.list" :key="item.id" :label="item.title" :value="item.id" />
                </el-select>
            </el-form-item>
            <el-form-item :label="`${props.title}图片`" prop="img">
                <!-- <UploadFile v-model="form.data.img" /> -->
                <CoUploadPhoto v-model="form.data.img"  />
            </el-form-item>

            <template v-if="lang === 'cn'">
                <el-form-item label="简介" prop="describe">
                    <CoEditor v-model="form.data.describe" />
                </el-form-item>
                <el-form-item label="详细内容" prop="content">
                    <CoEditor v-model="form.data.content" />
                </el-form-item>
            </template>
            <template v-else-if="lang === 'en'">
                <el-form-item label="英文简介" prop="describe_en">
                    <CoEditor v-model="form.data.describe_en" />
                </el-form-item>
                <el-form-item label="英文详细内容" prop="content_en">
                    <CoEditor v-model="form.data.content_en" />
                </el-form-item>
            </template>
            <!-- <el-form-item label="首页推荐" prop="isIndex">
                <el-radio-group v-model="form.data.isIndex">
                    <el-radio :value="true">
                        是
                    </el-radio>
                    <el-radio :value="false">
                        否
                    </el-radio>
                </el-radio-group>
            </el-form-item> -->
            <el-form-item label="状态" prop="status">
                <el-radio-group v-model="form.data.status">
                    <el-radio :value="1">
                        显示
                    </el-radio>
                    <el-radio :value="0">
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

<style lang="scss" scoped>

</style>
