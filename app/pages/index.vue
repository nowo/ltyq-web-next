<template>
    <div class="min-h300px">
        <Suspense>
            <ClientOnly>
                <HomeMain />
            </ClientOnly>
            <template #fallback>
                <div class="min-h500px">
                    <span animate-pulse>Loading...</span>
                </div>
            </template>
        </Suspense>
        <div class="a">
            <button class="btn" @click="open()">
                Open file dialog
            </button>
            <span>-123456</span>
        </div>
    </div>
</template>

<script setup lang="ts">
definePageMeta({
    layout: 'home',
})

const { files, open, reset, onChange } = useFileDialog({
    accept: 'image/*', // Set to accept only image files
    //   directory: true, // Select directories instead of files if set true
})

onChange(async () => {
    if (files?.value?.length) {
        const formData = new FormData()

        Array.from(files.value).forEach((file) => {
            formData.append('file[]', file)
        })
        // formData.append('file', files.value[0])
        const { data } = await useCustomFetch('/api/common/test', {
            method: 'POST',
            body: formData,
        })

    }
})
</script>

<style lang="scss" scoped></style>
