<template>
  <div class="animated fadeIn">
    <div class="container-fluid">
      <div class="d-flex flex-column">
        File Manager
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    computed: {
      user () {
        return this.$store.getters.user
      },
      folderInfo () {
//        let vm = this
        // let folderId = vm.id
        // let apiUrl = constants
      },
      files () {
        return this.$store.getters.currentFolderFiles
      }
    },
    mounted () {
      let vm = this
      vm.$store.dispatch('SET_CURRENT_FOLDER', vm.$route.params.folderId)
    }
  }
</script>

<style>

</style>