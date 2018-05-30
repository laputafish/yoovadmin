<template>
  <yoov-modal @close="$emit('close')">
    <h3>Hello World</h3>
  </yoov-modal>
</template>

<script>
  import YoovModal from '@/components/Modal'

  export default {
    components: {
      'yoov-modal': YoovModal
    },
    data () {
      return {

      }
    }
  }
</script>