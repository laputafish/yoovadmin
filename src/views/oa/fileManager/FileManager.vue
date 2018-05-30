<template>
  <div class="file-manager animated fadeIn">
    <div class="container-fluid">
      <div class="d-flex flex-column" v-if="currentFolder">
        <path-links
          :ancestors="currentFolder.ancestors"></path-links>
        <div class="file-manager-toolbar text-right d-flex flex-row">
          <!-- Select All -->
          <button class="btn-selection btn btn-sm btn-info" @click="selectClear()">
            <!--<i class="fa"-->
              <!--:class="{'fa-check-square':!allSelected, 'fa-square':allSelected}"></i>-->
            &nbsp;{{ allSelected ? 'Clear All' : 'Select All' }}
          </button>
          <!-- Select None -->
          <!--<button class="btn btn-sm btn-info" @click="selectNone()">-->
            <!--<i class="fa fa-square"></i>&nbsp;Clear-->
          <!--</button>-->
          <!-- Download -->
          <a :href="downloadLink" class="btn btn-sm btn-primary ml-auto">
            <i class="fa fa-download"></i>
            &nbsp;Download
          </a>
          <!-- Delete -->
          <button class="btn btn-sm btn-danger"
            @click="deleteSelected()">
            <i class="fa fa-close"></i>
            &nbsp;Delete
          </button>
        </div>
        <div v-if="currentFolder">
          <document-item
            @updateSelected="updateSelectedHandler"
            @refresh="refreshFolder"
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
  import * as constants from '@/store/constants'

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
      downloadLink () {
        let vm = this
        let idString = vm.selectedDocumentIds.join(',')
        return constants.apiUrl + '/media/download_documents/' + idString
      },
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
      },
      allSelected () {
        return this.documents.length === this.selectedDocumentIds.length
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
      downloadSelected () {
        // let vm = this
      },
      deleteSelected () {
        let vm = this
        vm.$dialog.confirm('Are you sure?', {
          okText: 'Yes',
          cancelText: 'No'
        }).then(function (response) {
          vm.$store.dispatch('DELETE_SELECTED').then(function () {
            vm.refreshFolder()
          })
        })
      },
      refreshFolder () {
        let vm = this
        vm.$store.dispatch('SET_CURRENT_FOLDER', vm.$route.params.folderId)
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
      selectClear () {
        let vm = this
        if (vm.allSelected) {
          vm.$store.dispatch('CLEAR_ALL_DOCUMENT_SELECTION')
        } else {
          vm.$store.dispatch('SELECT_ALL_DOCUMENTS')
        }
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
.file-manager-toolbar .btn-selection {
  min-width: 80px;
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