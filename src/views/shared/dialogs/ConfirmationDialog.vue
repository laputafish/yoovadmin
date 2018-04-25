<template>
  <b-modal :value="show" @input="onInput" title="Confirmation" @ok="$emit('ok')"
    :ok-variant="okVariant">
    <div class="d-block text-center">
      {{ message }}
    </div>
  </b-modal>
</template>

<script>
  export default {
    data () {
      return {

      }
    },
    model: {
      prop: 'show',
      event: 'input'
    },
    methods: {
      onInput (value) {
        this.$emit('input', value)
      }
    },
    props: {
      message: {
        type: String,
        default: 'Are you sure?'
      },
      okVariant: {
        type: String,
        default: 'success'
      },
      show: {
        type: Boolean,
        default: false
      }
    }
    // ,
    // watch: {
    //   showing: function (newVal, oldVal) {
    //     console.log('showing')
    //     this.show = newVal
    //   }
    // }
  }
</script>

<style>

</style>