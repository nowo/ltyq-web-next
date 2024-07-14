<script setup lang="ts">
import type { FormInstance, FormRules } from 'element-plus'

const props = defineProps<{
    data?: ISystemInfoData
}>()

const { setSystemUpdate } = await useSystemState()

const lang = ref<LanguageType>('cn')

const formRef = ref<FormInstance>()
const form = reactive({

    data: {
        company: '', // 公司名称
        address: '', // 公司地址

        company_en: '',
        address_en: '', // 公司地址
        welcome: '',
        welcome_en: '',

        phone: '', // 公司电话
        email: '', // 公司邮箱

        logo: [] as string[], // 网站logo
        logo2: [] as string[], // 网站logo
        qr_code: [] as string[], // 二维码
        seo_title: '', // seo标题
        seo_keyword: '', // 关键词
        seo_description: '', // 描述

        filing: '', // 备案号
        copyright: '', // 版权信息
        filing_en: '', // 备案号
        copyright_en: '', // 版权信息

        icon: [] as string[], // 网站图标
        is_en: true, // 是否开启英文版
    },

})

const rules = reactive<FormRules>({

    company: [{ required: true, whitespace: true, message: '请输入公司名称', trigger: 'blur' }],
})

// 初始化数据
const initDefaultData = async () => {
    if (!props.data) return
    const propsData = props.data

    form.data.company = propsData.company
    form.data.company_en = propsData.company_en
    form.data.address = propsData.address
    form.data.address_en = propsData.address_en
    form.data.welcome = propsData.welcome
    form.data.welcome_en = propsData.welcome_en
    form.data.logo = [propsData.logo || '']
    form.data.logo2 = [propsData.logo2 || '']
    form.data.qr_code = [propsData.wx_code || '']
    form.data.phone = propsData.phone || ''
    form.data.email = propsData.email || ''
    form.data.seo_title = propsData.title || ''
    form.data.seo_keyword = propsData.keyword || ''
    form.data.seo_description = propsData.description || ''
    form.data.filing = propsData.filing || ''
    form.data.icon = [propsData.icon || '']
    form.data.is_en = propsData.is_en
}

const [ApiFunc, btnLoading] = useLoadingSubmit()
// 确定
const onSubmit = async () => {
    const param: ISystemEditParams = {
        company: form.data.company?.trim() ?? '',
        company_en: form.data.company_en?.trim() ?? '',
        address: form.data.address?.trim() ?? '',
        address_en: form.data.address_en?.trim() ?? '',
        welcome: form.data.welcome?.trim() ?? '',
        welcome_en: form.data.welcome_en?.trim() ?? '',
        phone: form.data.phone?.trim() ?? '',
        email: form.data.email?.trim() ?? '',
        logo: form.data.logo?.[0] ?? '',
        logo2: form.data.logo2?.[0] ?? '',
        wx_code: form.data.qr_code?.[0] ?? '',
        title: form.data.seo_title?.trim() ?? '',
        // title_en: '',
        keyword: form.data.seo_keyword?.trim() ?? '',
        description: form.data.seo_description?.trim() ?? '',
        filing: form.data.filing?.trim() ?? '',
        // copyright: form.data.copyright?.trim() ?? '',
        filing_en: form.data.filing_en?.trim() ?? '',
        // copyright_en: form.data.copyright_en?.trim() ?? '',
        icon: form.data.icon?.[0] ?? '',
        is_en: form.data.is_en,
    }

    const res = await ApiFunc(setSystemUpdate(param))

    if (res) ElMessage.success('设置成功')

    // initData?.() // 更新数据
}
// 重置
const onReset = async () => {
    formRef.value?.resetFields()
    initDefaultData()
}

// 监听，
watch(() => props.data, (newVal) => {
    initDefaultData()
})

onBeforeMount(() => {
    initDefaultData()
})
</script>

<template>
    <el-form ref="formRef" :model="form.data" :rules="rules" label-position="top">
        <el-tabs v-model="lang">
            <el-tab-pane label="中文" name="cn" />
            <el-tab-pane label="英文" name="en" />
        </el-tabs>
        <el-row>
            <template v-if="lang === 'cn'">
                <el-col :xs="24" :sm="24" :md="20" :lg="18" :xl="16">
                    <el-form-item prop="company" label="公司名称：">
                        <el-input v-model="form.data.company" maxlength="100" clearable />
                    </el-form-item>
                </el-col>
                <el-col :xs="24" :sm="24" :md="20" :lg="18" :xl="16">
                    <el-form-item prop="address" label="公司地址：">
                        <el-input v-model="form.data.address" type="textarea" maxlength="200" clearable
                            show-word-limit />
                    </el-form-item>
                </el-col>
                <el-col :xs="24" :sm="24" :md="20" :lg="18" :xl="16">
                    <el-form-item prop="welcome" label="欢迎信息：">
                        <el-input v-model="form.data.welcome" maxlength="30" clearable />
                    </el-form-item>
                </el-col>
            </template>
            <template v-else-if="lang === 'en'">
                <el-col :xs="24" :sm="24" :md="20" :lg="18" :xl="16">
                    <el-form-item prop="company_en" label="英文公司名称：">
                        <el-input v-model="form.data.company_en" maxlength="100" clearable />
                    </el-form-item>
                </el-col>
                <el-col :xs="24" :sm="24" :md="20" :lg="18" :xl="16">
                    <el-form-item prop="address_en" label="英文公司地址：">
                        <el-input v-model="form.data.address_en" type="textarea" maxlength="200" clearable
                            show-word-limit />
                    </el-form-item>
                </el-col>
                <el-col :xs="24" :sm="24" :md="20" :lg="18" :xl="16">
                    <el-form-item prop="welcome_en" label="英文欢迎信息：">
                        <el-input v-model="form.data.welcome_en" maxlength="50" clearable />
                    </el-form-item>
                </el-col>
            </template>

            <el-col :xs="24" :sm="24" :md="18" :lg="12" :xl="10">
                <el-form-item prop="phone" label="联系方式：">
                    <el-input v-model="form.data.phone" maxlength="50" clearable />
                </el-form-item>
            </el-col>
            <el-col v-if="lang === 'cn'" :xs="24" :sm="24" :md="20" :lg="18" :xl="16">
                <el-form-item prop="filing" label="备案信息：">
                    <CoEditor v-model="form.data.filing" />
                </el-form-item>
            </el-col>
            <el-col v-if="lang === 'en'" :xs="24" :sm="24" :md="20" :lg="18" :xl="16">
                <el-form-item prop="filing_en" label="英文备案信息：">
                    <CoEditor v-model="form.data.filing_en" />
                </el-form-item>
            </el-col>
            <el-col :xs="24" :sm="24" :md="20" :lg="18" :xl="16">
                <el-form-item prop="seo_keyword" label="SEO关键字：">
                    <el-input v-model="form.data.seo_keyword" maxlength="80" clearable />
                </el-form-item>
            </el-col>
            <el-col :xs="24" :sm="24" :md="20" :lg="18" :xl="16">
                <el-form-item prop="seo_description" label="SEO描述：">
                    <el-input v-model="form.data.seo_description" type="textarea" show-word-limit maxlength="150"
                        clearable />
                </el-form-item>
            </el-col>
            <el-col v-if="lang === 'cn'" :xs="24" :sm="24" :md="20" :lg="18" :xl="16">
                <el-form-item prop="filing" label="备案信息：">
                    <!-- <BaseWangEditor v-model="form.data.filing" :height="310" /> -->
                </el-form-item>
            </el-col>
            <el-col v-else-if="lang === 'en'" :xs="24" :sm="24" :md="20" :lg="18" :xl="16">
                <el-form-item prop="filing_en" label="英文备案信息：">
                    <!-- <BaseWangEditor v-model="form.data.filing_en" :height="310" /> -->
                </el-form-item>
            </el-col>
            <el-col :xs="24" :sm="24" :md="20" :lg="18" :xl="16">
                <div class="flex flex-wrap">
                    <el-form-item prop="logo" label="网站logo：" class="min-w200px">
                        <CoUploadPhoto v-model="form.data.logo" class="upload" />
                    </el-form-item>
                    <el-form-item prop="logo2" label="网站logo2：" class="min-w200px">
                        <CoUploadPhoto v-model="form.data.logo2" class="upload" />
                    </el-form-item>
                    <el-form-item prop="icon" label="网站图标：" class="min-w200px">
                        <CoUploadPhoto v-model="form.data.icon" class="upload" />
                    </el-form-item>
                </div>
            </el-col>
            <el-col :xs="24" :sm="24" :md="20" :lg="18" :xl="16">
                <div class="flex flex-wrap">
                    <el-form-item prop="qr_code" label="二维码：" class="min-w200px">
                        <CoUploadPhoto v-model="form.data.qr_code" class="upload" />
                    </el-form-item>
                </div>
            </el-col>
            <el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24">
                <el-form-item label="启用英文版:" prop="is_en">
                    <el-radio-group v-model="form.data.is_en">
                        <el-radio label="启用" :value="true" />
                        <el-radio label="禁用" :value="false" />
                    </el-radio-group>
                </el-form-item>
            </el-col>
            <el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24">
                <el-form-item>
                    <el-button type="primary" :loading="btnLoading" @click="onSubmit">
                        确定
                    </el-button>
                    <el-button @click="onReset">
                        重置
                    </el-button>
                </el-form-item>
            </el-col>
        </el-row>
    </el-form>
</template>

<style lang="scss" scoped>
.upload {
    --co-upload-picture-card-size: 120px;
}
</style>
