<template>
  <div class="scanner-folder">
    <button type="button"
            :class="iconClass"
            class="btn btn-link btn-folder d-flex flex-column justify align-items-center"
            @click="onButtonClicked">
      <i class="fa fa-folder"></i>
      <small class="scanner-folder-label">{{ label }}</small>
    </button>
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
            result.push('folder-highlight')
          } else {
            result.push('folder-normal')
          }
        } else {
          if (vm.scanner.occupied_by === vm.user.id) {
            result.push('folder-highlight')
          } else {
            result.push('folder-normal')
          }
        }
        return result
      }
    },
    methods: {
      onButtonClicked () {
        let vm = this
        // public scan folder
        if (vm.mode === 'scanner') {
          let publicScanFolderId = vm.$store.getters.publicScanFolder.id
          vm.$router.push('/folders/' + publicScanFolderId)
        } else {
          // let userScanFolderId = vm.$store.getters.userScanFolder.id
          vm.$router.push('/folders')
        }
      }
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

  .scanner-folder button,
  .scanner-folder button:hover {
    text-decoration: none;
  }

  .scanner-folder button.folder-highlight {
    color: green;
    opacity: 1;
  }

  .scanner-folder button.folder-highlight:hover {
    color: green;
    opacity: 0.8;
  }

  .scanner-folder button.folder-normal {
    color: rgba(0, 0, 0, .5);
  }

  .scanner-folder button.folder-normal:hover {
    color: rgba(0, 0, 0, .4);
  }
</style>
