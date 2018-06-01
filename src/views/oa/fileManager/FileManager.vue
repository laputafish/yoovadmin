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
          <button class="btn btn-sm btn-default"
                  @click="newFolder()">
            <i class="fa fa-folder"></i>
          </button>
          <button class="btn btn-sm btn-default"
                  @click="move()">
            <i class="fa fa-arrows"></i>
          </button>
          <button class="btn btn-sm btn-default"
                  @click="copy()">
            <i class="fa fa-copy"></i>
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
          <folder-item
            @updateSelected="updateSelectedHandler"
            @refresh="refreshFolder"
            :folder="folder"
            :key="index"
            v-for="(folder,index) in folders"></folder-item>
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
  import FolderItem from '@/components/'
  import Pusher from 'pusher-js' // import Pusher
  import * as constants from '@/store/constants'

  export default {
    data () {
      return {
        pusher: null,
        currentFolderId: null
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
      folders () {
        let vm = this
        return vm.currentFolder ? vm.currentFolder.children : []
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
      },
      user: {
        handler: function (value) {
          this.initFolder()
        },
        deep: true
      }
    },
    mounted () {
      let vm = this
      if (vm.user) {
        vm.initFolder()
      }
    },
    created () {
      this.subscribe()
    },
    beforeDestroy () {
      this.unSubscribe()
    },
    methods: {
      newFolder () {
        this.$store.dispatch('NEW_FOLDER')
      },
      move () {

      },
      copy () {

      },
      initFolder () {
        let vm = this
        if (vm.$route.params.folderId) {
          if (vm.$route.params.folderId === 0) {
            let folderName = vm.$route.params.folderName
            console.log('mounted :: route.params: ', vm.$route.params)
            vm.currentFolderId = vm.getUserFolderId(folderName)
          } else {
            vm.currentFolderId = vm.$route.params.folderId
          }
        } else {
          vm.currentFolderId = vm.user.folder.id
        }
        vm.refreshFolder()
      },
      getUserFolderId (folderName, folders) {
        let vm = this
        let result = null
        if (typeof folders === 'undefined') {
          folders = vm.user.folder.children
        }
        for (var i = 0; i < folders.length; i++) {
          if (folders[i].name === folderName) {
            result = folders[i]
            break
          }
        }
        return result ? result.id : 0
      },
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
        vm.$store.dispatch('SET_CURRENT_FOLDER', vm.currentFolderId)
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