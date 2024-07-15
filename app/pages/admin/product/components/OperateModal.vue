<script lang="ts" setup>
import type { Product, Prisma, Link } from '@prisma/client'
import type { CheckboxValueType, FormInstance, FormRules } from 'element-plus'


const props = defineProps<{
    // type: number
    title: string
    list: any[]
}>()

const emits = defineEmits<{
    update: []
}>()

const lang = ref<LanguageType>('cn')
const visible = ref(false)

const operate = ref<DialogOperate>()
const comData = computed(() => {
    if (operate.value === 'add') return { title: '新增产品' }
    return { title: '修改产品' }
})
const formRef = ref<FormInstance>()
const form = reactive({
    data: {
        id: 0,
        title: '',
        title_en: '',
        author: '',
        contrast: '',
        contrast_en: '',
        annex: '',
        annex_en: '',

        status: true, // 1:启用 0:禁用
        isHot: false,
        type: '',
        describe: '',
        describe_en: '',
        content: '',
        content_en: '',
        img: [] as string[],
        sort: 1,
        links: [] as Link[]
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

    role: [
        { required: true, message: '必填项不能为空' },

    ],
})


const tableDataGoods = reactive<CoTableProps<Link>>({
    data: [],
    tableHeader: [
        { property: 'title', label: '标题', minWidth: 85 },
        // { property: 'title_en', label: '英文标题', minWidth: 160 },
        { property: 'content', label: '简介', minWidth: 100 },
        // { property: 'content_en', label: '英文简介', minWidth: 150 },
        { property: 'href', label: '文件', width: 100, align: 'center' },
        { property: 'operate', label: '操作', width: 85, fixed: 'right', align: 'center' },

    ],
    pagination: paginationConfig,
    isTool: false
})

// 增加
const onAddItem = () => {
    const dat: Link = {
        title: '',
        title_en: '',
        content: '',
        img: '',
        href: '',
        sort: 0,
        type: 3,
        status: true,
    }

    form.data.links.push(dat)
}
// 移除
const onRemoveItem = (row: Link) => {
    const index = form.data.links.indexOf(row)
    if (index >= 0) form.data.links.splice(index, 1)
}

const openModal = (type: DialogOperate, row?: Product & { links: Link[] }) => {
    operate.value = type
    if (type === 'edit') {

        form.data.title = row?.title || ''
        form.data.title_en = row?.title_en || ''
        form.data.content = row?.content || ''
        form.data.content_en = row?.content_en || ''
        form.data.describe = row?.describe || ''
        form.data.describe_en = row?.describe_en || ''
        form.data.contrast = row?.contrast || ''
        form.data.contrast_en = row?.contrast_en || ''
        form.data.annex = row?.annex || ''
        form.data.annex_en = row?.annex_en || ''
        form.data.sort = row?.sort || 0
        form.data.status = row?.status ? true : false
        form.data.isHot = row?.isHot ? true : false
        form.data.id = row?.id || 0
        form.data.type = row?.classifyId ||''
        const imgs = row?.links?.filter(item => item.type === 2).map(item => item.img)
        form.data.img = imgs || []
        const links = row?.links?.filter(item => item.type === 3).map((item) => {
            let link: Link = {
                id: item.id || 0,
                title: item.title,
                content: item.content || '',
                href: item.href || '',
            }
            return link
        })
        form.data.links = links || []
    } else {
        form.data.title = ''
        form.data.title_en = ''
        form.data.describe = ''
        form.data.describe_en = ''
        form.data.contrast = ''
        form.data.contrast_en = ''
        form.data.annex = ''
        form.data.annex_en = ''
        form.data.sort = 0

        form.data.status = true
        form.data.isHot = false
        form.data.id = 0
        form.data.img = []
        form.data.type = ''
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
    console.log(form.data.type)
    const isVerify = await useFormVerify(formRef.value)
    if (!isVerify) return

    const links = form.data.links.filter(item => !!item.href).map((item) => {
        return {
            img: '',
            href: item.href || '',
            title: item.title || '',
            content: item.content || '',
            type: 3,
        }
    })
    form.data.img.forEach((item) => {
        if (item) {
            links.push({
                img: item,
                href: '',
                title: '',
                content: '',
                type: 2,
            })
        }
    })


    const data: Prisma.ProductUncheckedCreateInput = {
        title: form.data.title?.trim() ?? '',
        title_en: form.data.title_en?.trim() ?? '',
        author: form.data.author?.trim() ?? '',
        describe: form.data.describe?.trim() ?? '',
        describe_en: form.data.describe_en?.trim() ?? '',
        content: form.data.content?.trim() ?? '',
        content_en: form.data.content_en?.trim() ?? '',
        contrast: form.data.contrast?.trim() ?? '',
        contrast_en: form.data.contrast_en?.trim() ?? '',
        annex: form.data.annex?.trim() ?? '',
        annex_en: form.data.annex_en?.trim() ?? '',
        img: '',
        sort: form.data.sort || 0,
        // permission: JSON.stringify(list),
        isHot: !!form.data.isHot,
        status: !!form.data.status,
        classifyId: Number(form.data.type),
        links: {
            createMany: {
                data: links
            }
        }
    }

    if (operate.value === 'add') {
        const res = await ApiFunc(useServerFetch('/api/v1/product/add', {
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
        const res = await ApiFunc(useServerFetch('/api/v1/product/edit', {
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
            <el-form-item label="商品分类" prop="type">
                <!-- <el-select v-model="form.data.type" clearable filterable>
                    <el-option v-for="item in props.list" :key="item.id" :label="item.title" :value="item.id" />
                </el-select> -->
                <CoCascader v-model="form.data.type" :options="props.list"
                    :props="{ label: 'title', value: 'id', checkStrictly: true, emitPath: false }" filterable clearable
                    class="w100%" />
            </el-form-item>
            <el-form-item :label="`${props.title}图片`" prop="img">
                <!-- <UploadFile v-model="form.data.img" /> -->
                <CoUploadPhoto v-model="form.data.img" :limit="9" />
            </el-form-item>

            <template v-if="lang === 'cn'">
                <el-form-item label="简介" prop="describe">
                    <CoEditor v-model="form.data.describe" />
                </el-form-item>
                <el-form-item label="详细内容" prop="content">
                    <CoEditor v-model="form.data.content" />
                </el-form-item>
                <el-form-item label="规格对比" prop="contrast">
                    <CoEditor v-model="form.data.contrast" />
                </el-form-item>
                <el-form-item label="包装附件" prop="annex">
                    <CoEditor v-model="form.data.annex" />
                </el-form-item>
            </template>
            <template v-else-if="lang === 'en'">
                <el-form-item label="英文简介" prop="describe_en">
                    <CoEditor v-model="form.data.describe_en" />
                </el-form-item>
                <el-form-item label="英文详细内容" prop="content_en">
                    <CoEditor v-model="form.data.content_en" />
                </el-form-item>
                <el-form-item label="英文规格对比" prop="contrast">
                    <CoEditor v-model="form.data.contrast_en" />
                </el-form-item>
                <el-form-item label="英文包装附件" prop="annex">
                    <CoEditor v-model="form.data.annex_en" />
                </el-form-item>
            </template>
            <el-form-item label="首页显示" prop="isHot">
                <el-radio-group v-model="form.data.isHot">
                    <el-radio :value="true">
                        是
                    </el-radio>
                    <el-radio :value="false">
                        否
                    </el-radio>
                </el-radio-group>
            </el-form-item>
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
            <!-- <el-form-item label="文件关联" label-width="50%" class="mb0!">
                <template #label>
                    <div class="w100%">
                        <b>文件关联</b>
                        <span class="text-12px"> (详细更改请通过服务与维修-资料下载进行操作)</span>
                    </div>
                </template>
            </el-form-item>
            <CoTable v-model:option="tableDataGoods" :data="form.data.links" auto-height border>
                <template #title="{ row, $index }">
                    <el-form-item label="" label-width="auto" :prop="`tableData.${$index}.title`">
                        <el-input v-model="row.title" class="w100%" />
                    </el-form-item>
                </template>
                <template #content="{ row, $index }">
                    <el-form-item label="" label-width="auto" :prop="`tableData.${$index}.content`">
                        <el-input v-model="row.content" class="w100%" />
                    </el-form-item>
                </template>

                <template #href="{ row }">
                    <CoUploadFile v-model="row.href" type="text" accept="*" />
                </template>
                <template #operateHeader>
                    <el-button @click="onAddItem">
                        <i class="i-ep-plus"></i>
                    </el-button>
                </template>
                <template #operate="{ row }">
                    <el-button @click="onRemoveItem(row)">
                        <i class="i-ep-delete">
                        </i>
                    </el-button>
                </template>
            </CoTable> -->
        </el-form>
    </CoDrawer>
</template>

<style lang="scss" scoped></style>
