<template>
  <div class="file-manager animated fadeIn">
    <div class="container-fluid">
      <div class="d-flex flex-column" v-if="currentFolder">
        <path-links
          :ancestors="currentFolder.ancestors"></path-links>
        <hr class="file-manager-separator"/>
        <div>
          <document-item
            :document="document"
            :key="index"
            v-for="(document,index) in currentFolder.documents"></document-item>
        </div>
      </div>
      {{ currentFolder.documents[0] }}
    </div>
  </div>
</template>

<script>
  import PathLinks from '@/components/PathLinks'
  import DocumentItem from '@/components/DocumentItem'

  export default {
    components: {
      'path-links': PathLinks,
      'document-item': DocumentItem
    },
    computed: {
      user () {
        return this.$store.getters.user
      },
      currentFolder () {
        return this.$store.getters.currentFolder
//        let vm = this
        // let folderId = vm.id
        // let apiUrl = constants
      },
      files () {
        return this.$store.getters.currentFolder.documents
      }
    },
    mounted () {
      let vm = this
      vm.$store.dispatch('SET_CURRENT_FOLDER', vm.$route.params.folderId)
    },
    methods: {
      getIconSrc (mediaId) {

      }
    }
  }
</script>

<style>
.file-manager-separator {
  border-color: black;
  border-width: 2px;
  border: 3px solid lightgray;
  margin: 0;
  margin: 5px 0;
  border-radius: 5px;
}

</style>