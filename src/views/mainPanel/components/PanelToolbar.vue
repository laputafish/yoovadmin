<template>
    <div class="d-flex flex-row flex-grow-0 align-items-center mb-2">
        <button v-for="button in buttons"
            class="pb-0 btn mr-2"
            @click="$emit('input', button.pane)"
            :class="{'btn-primary': button.pane==activePane, 'btn-default': button.pane!=activePane}">
        <i class="d-block" :class="button.iconClass"></i>
            {{ button.label }}
        </button>
    </div>
</template>

<script>
    export default {
      props: {
        buttons: {
          type: Array,
          default: null
        },
        activePane: {
          type: String,
          default: ''
        }
      },
      model: {
        prop: 'activePane',
        event: 'input'
      },
      methods: {
      }
    }
</script>

<style>

</style>