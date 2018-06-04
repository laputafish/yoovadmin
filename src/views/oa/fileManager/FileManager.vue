<template>
  <div class="file-manager animated fadeIn">
    <div class="d-flex flex-column" v-if="currentFolder">
      <path-links
        :ancestors="currentFolder.ancestors"></path-links>
      <div class="file-manager-toolbar text-right d-flex flex-row">
        <!-- Select All -->
        <!--<a href="#"-->
           <!--class="btn btn-sm btn-default dropdown-toggle"-->
           <!--data-toggle="dropdown"-->
           <!--role="button"-->
           <!--aria-haspopup="true"-->
           <!--aria-expanded="false">Save & Load <span class="caret"></span></a>-->
        <!--<ul class="dropdown-menu">-->
          <!--<li><a href="#">Action</a></li>-->
          <!--<li><a href="#">Another action</a></li>-->
        <!--</ul>-->
        <button v-tooltip="allSelected ? 'Clear All' : 'Select All'" class="btn-default btn btn-sm" @click="selectClear()">
          <!--<i class="fa"-->
            <!--:class="{'fa-check-square':!allSelected, 'fa-square':allSelected}"></i>-->
          <i class="fa" :class="{'fa-square':allSelected, 'fa-check-square':!allSelected}"></i>
        </button>
        <button v-tooltip="'New Folder'" class="btn btn-sm btn-default"
                style="position:relative;"
                @click="newFolder()">
          <i class="fa fa-folder"></i>
        </button>

        <button v-tooltip="'Move'" class="btn btn-sm btn-default"
                :disabled="selectionCount===0"
                @click="move()">
          <i class="fa fa-arrows"></i>
        </button>
        <button v-tooltip="'Copy'" class="btn btn-sm btn-default"
                :disabled="selectionCount===0"
                @click="copy()">
          <i class="fa fa-copy"></i>
        </button>
        <button v-tooltip="'Delete'" class="btn btn-sm btn-default"
                :disabled="selectionCount===0"
                @click="deleteSelected()">
          <i class="fa fa-close"></i>
        </button>
        <!-- Select None -->
        <!--<button class="btn btn-sm btn-info" @click="selectNone()">-->
          <!--<i class="fa fa-square"></i>&nbsp;Clear-->
        <!--</button>-->
        <!-- Download -->
        <a v-tooltip="'Download'" :href="downloadLink" class="btn-toolbar btn btn-sm btn-default ml-auto no-anchor-style"
           :class="{'disabled':selectionCount===0}">
          <i class="fa fa-download"></i>
        </a>
        <!-- Delete -->
      </div>
      <div v-if="currentFolder">
        <file-item
          @updateSelected="updateSelectedFolderHandler"
          @refresh="refreshFolder"
          fileType="folder"
          :fileItem="folder"
          :key="'folder_'+index"
          v-for="(folder,index) in folders"></file-item>
        <file-item
          @updateSelected="updateSelectedDocumentHandler"
          @refresh="refreshFolder"
          fileType="document"
          :fileItem="document"
          :key="'document_'+index"
          v-for="(document,index) in documents"></file-item>
        <!--<folder-item-->
          <!--@updateSelected="updateSelectedFolderHandler"-->
          <!--@refresh="refreshFolder"-->
          <!--:folder="folder"-->
          <!--:key="'folder_'+index"-->
          <!--v-for="(folder,index) in folders"></folder-item>-->
        <!--<document-item-->
          <!--@updateSelected="updateSelectedDocumentHandler"-->
          <!--@refresh="refreshFolder"-->
          <!--:document="document"-->
          <!--:key="'document_'+index"-->
          <!--v-for="(document,index) in documents"></document-item>-->
      </div>
    </div>
    <folder-tree-dialog v-if="showingFolderTreeDialog"
                        :disabledFolderId="currentFolder.id"
                        :command="currentCommand"
                        @ok="onTargetFolderSelected"
      @close="showingFolderTreeDialog=false">

    </folder-tree-dialog>
  </div>
</template>

<script>
  import PathLinks from '@/components/PathLinks'
  import FileItem from '@/components/FileItem'
  // import DocumentItem from '@/components/DocumentItem'
  // import FolderItem from '@/components/FolderItem'
  import Pusher from 'pusher-js' // import Pusher
  import * as constants from '@/store/constants'
  import FolderTreeDialog from '@/dialogs/FolderTreeDialog'

  export default {
    data () {
      return {
        pusher: null,
        currentCommand: 'move',
        currentFolderId: null,
        showingFolderTreeDialog: false
      }
    },
    components: {
      'path-links': PathLinks,
      'file-item': FileItem,
      // 'document-item': DocumentItem,
      // 'folder-item': FolderItem,
      'folder-tree-dialog': FolderTreeDialog
    },
    computed: {
      personalFolders () {
        return this.$store.getters.personalFolders
      },
      selectionCount () {
        return this.$store.getters.selectionCount
      },
      downloadLink () {
        let vm = this
        let idString = vm.selectedDocumentIds.join(',')
        return vm.selectionCount === 0 ? '#' : constants.apiUrl + '/media/download_documents/' + idString
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
      selectedFolderIds () {
        let vm = this
        return vm.$store.getters.selectedFolderIds
      },
      allSelected () {
        return this.documents && this.folders && (this.documents.length === this.selectedDocumentIds.length) &&
          (this.folders.length === this.selectedFolderIds.length && this.folders.length > 0)
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
      onTargetFolderSelected (payload) {
        let selectedFolderId = payload.folderId
        let command = payload.command
        alert('command=' + command + ', selectedFolderId = ' + selectedFolderId)
        this.showingFolderTreeDialog = false
      },
      newFolder () {
        this.$store.dispatch('NEW_FOLDER')
      },
      move () {
        this.currentCommand = 'move'
        this.showingFolderTreeDialog = true
      },
      copy () {
        this.currentCommand = 'copy'
        this.showingFolderTreeDialog = true
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
          vm.$store.dispatch('CLEAR_ALL_FILES')
        } else {
          vm.$store.dispatch('SELECT_ALL_FILES')
        }
      },
      // selectAll () {
      //   this.$store.dispatch('SELECT_ALL_FILES')
      // },
      selectNone () {
        this.$store.dispatch('CLEAR_ALL_FILES')
      },
      updateSelectedDocumentHandler () {
        let vm = this
        for (var i = 0; i < vm.currentFolder.documents.length; i++) {
          vm.currentFolder.documents[i].selected = true
        }
      },
      updateSelectedFolderHandler () {
        let vm = this
        for (var i = 0; i < vm.currentFolder.children.length; i++) {
          vm.currentFolder.children[i].selected = true
        }
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

.file-manager a.btn-toolbar {
  padding: 7px;
}

.file-manager a.btn-toolbar:disabled:hover {
  pointer: default;
  color: darkgray;
}
</style>