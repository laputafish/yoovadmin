<template>
  <div class="yoov-radio-toggle form-control p-0 m-0 border-0">
    <button type="button"
            class="btn mr-1"
            :class="getClass(option)"
            @click="$emit('input', option.value)"
            v-for="option in options">
      {{ option.caption }}
    </button>
  </div>
</template>

<script>
  export default {
    model: {
      prop: 'selectedValue',
      event: 'input'
    },
    props: {
      selectedValue: {
        type: String,
        default: ''
      },
      options: {
        type: Array,
        default () {
          return []
        }
      },
      buttonClass: {
        type: String,
        default: ''
      }
    },
    methods: {
      getClass (option) {
        let vm = this
        let arClasses = []
        if (vm.buttonClass) {
          arClasses.push(vm.butonClass)
        }
        console.log('option.value: ' + option.value)
        console.log('vm.selectedValue: ' + vm.selectedValue)
        if (option.value === vm.selectedValue) {
          arClasses.push('btn-primary')
        } else {
          arClasses.push('btn-default')
        }
        return arClasses.join(' ')
      }
    }
  }
</script>

<style>
  .yoov-radio-toggle button:last-child {
    margin-right: 0;
  }
</style>