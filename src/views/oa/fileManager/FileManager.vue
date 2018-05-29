<template>
  <div class="file-manager animated fadeIn">
    <div class="container-fluid">
      <div class="d-flex flex-column" v-if="currentFolder">
        <path-links
          :ancestors="currentFolder.ancestors"></path-links>
        <div class="file-manager-toolbar text-right d-flex flex-row">
          <button class="btn btn-sm btn-info" @click="selectAll()">
            <i class="fa fa-check-square"></i>&nbsp;Select All
          </button>
          <button class="btn btn-sm btn-info" @click="selectNone()">
            <i class="fa fa-square"></i>&nbsp;Clear
          </button>
          <button class="btn btn-sm btn-primary ml-auto"><i class="fa fa-download"></i>&nbsp;Download</button>
          <button class="btn btn-sm btn-danger"><i class="fa fa-close"></i>&nbsp;Delete</button>
        </div>
        <div v-if="currentFolder">
          <document-item
            @updateSelected="updateSelectedHandler"
            :document="document"
            :key="index"
            v-for="(document,index) in documents"></document-item>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import PathLinks from '@/components/PathLinks'
  import DocumentItem from '@/components/DocumentItem'
  import Pusher from 'pusher-js' // import Pusher

  export default {
    data () {
      return {
        pusher: null
      }
    },
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
      },
      documents () {
        let vm = this
        return vm.currentFolder ? vm.currentFolder.documents : []
      },
      selectedDocumentIds () {
        let vm = this
        return vm.$store.getters.selectedDocumentIds
      }
    },
    watch: {
      currentFolder: {
        handler: function (value) {
          console.log('FileManager :: watch(currentFolder) : value:', value)
        },
        deep: true
      }
    },
    mounted () {
      this.refreshFolder()
    },
    created () {
      this.subscribe()
    },
    beforeDestroy () {
      this.unSubscribe()
    },
    methods: {
      refreshFolder () {
        let vm = this
        vm.$store.dispatch('SET_CURRENT_FOLDER', vm.$route.params.folderId)
        alert('folder refreshed')
      },
      unSubscribe () {
        this.pusher.disconnect()
      },
      subscribe () {
        let vm = this
        vm.pusher = new Pusher('646e36da78e4db3ea81a', { cluster: 'ap1' })
        vm.pusher.subscribe('documents')
        vm.pusher.bind('document_added', data => {
          vm.refreshFolder()
          // this.mockReviews.unshift(data.review)
        })
      },
      selectAll () {
        this.$store.dispatch('SELECT_ALL_DOCUMENTS')
      },
      selectNone () {
        this.$store.dispatch('CLEAR_ALL_DOCUMENT_SELECTION')
      },
      updateSelectedHandler () {
        let vm = this
        for (var i = 0; i < vm.currentFolder.documents.length; i++) {
          vm.currentFolder.documents[i].selected = true
        }
        console.log('updateSelectedHandler :: currentFolder:', vm.currentFolder)
      },
      getIconSrc (mediaId) {

      }
    }
  }
</script>

<style>
.file-manager .file-manager-toolbar {
  padding: 5px 7px;
  margin-bottom: 10px;
  background-color: #e9ecef;
  border-radius: 0.5rem;
}
.file-manager .file-manager-toolbar button {
  margin-left: 5px;
}
.file-manager-separator {
  border-color: black;
  border-width: 2px;
  border: 3px solid lightgray;
  margin: 0;
  margin: 5px 0;
  border-radius: 5px;
}

</style>