<template>
    <div :class="iconClass"
            class="scanner-folder d-flex flex-column justify align-items-center">
        <i
                class="fa fa-folder"></i>
        <small
               class="scanner-folder-label">{{ label }}</small>
    </div>
</template>

<script>
    export default {
      props: {
        user: null,
        scanner: null,
        mode: null,
        label: ''
      },
      computed: {
        iconClass () {
          let vm = this
          let result = []
          if (vm.mode === 'scanner') {
            if (vm.scanner.occupied_by === 0) {
              result.push('text-success')
            } else {
              result.push('text-black-50')
            }
          } else {
            if (vm.scanner.occupied_by === vm.user.id) {
              result.push('text-success')
            } else {
              result.push('text-black-50')
            }
          }
          return result
        }
      },
      mounted () {

      }
    }
</script>

<style>
    .scanner-folder i.fa-folder {
        font-size: 48px;
    }
    .scanner-folder .scanner-folder-label {
        margin-top: -3px;
        line-height: 0.8;
    }
</style>
