<template>
  <div class="example-full file-manager animated fadeIn">
    <div v-show="$refs.upload && $refs.upload.dropActive" class="drop-active">
      <h3>Drop files to upload</h3>
    </div>
    <div class="d-flex flex-column" v-if="currentFolder && !preparing" >
      <div class="d-flex flex-row" style="position:relative;">
        <path-links
          :ancestors="currentFolder.ancestors"></path-links>
        <span v-if="loading" class="ml-auto" style="position:absolute;right:5px;top:-14px;">
          <h3>
            <i class="fa fa-spinner fa-spin"></i>
          </h3>
        </span>
      </div>
      <file-manager-toolbar
        :allSelected="allSelected"
        :noneSelected="selectionCount===0"
        :downloadLink="downloadLink"
        @onCommand="onToolbarCommandHandler">
      </file-manager-toolbar>
      <full-drag-drop></full-drag-drop>
      <div v-if="currentFolder">
        <file-item
          @updateSelected="updateSelectedFolderHandler"
          @onAction="onActionHandler"
          @refresh="refreshFolder"
          fileType="folder"
          :fileItem="folder"
          :key="'folder_'+index"
          v-for="(folder,index) in folders"></file-item>
        <file-item
          @updateSelected="updateSelectedDocumentHandler"
          @onAction="onActionHandler"
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
                        :disabledFolderIds="disabledFolderIds"
                        :command="currentCommand"
                        :fileItem="activeFileItem"
                        :fileType="activeFileType"
                        @ok="onTargetFolderSelected"
      @close="showingFolderTreeDialog=false">
    </folder-tree-dialog>
    <file-rename-dialog v-if="showingFileRenameDialog"
                        :oldName="activeFilename"
                        @ok="onNewNameConfirmed"
                        @close="showingFileRenameDialog=false">
    </file-rename-dialog>
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
  import FileRenameDialog from '@/dialogs/FileRenameDialog'
  import FullDragDrop from '@/components/FullDragDrop'
  import FileManagerToolbar from '@/components/FileManagerToolbar'

  export default {
    data () {
      return {
        loading: true,
        preparing: true,
        pusher: null,
        currentCommand: 'move',
        currentFolderId: null,
        disabledFolderIds: [],
        showingFolderTreeDialog: false,
        showingFileRenameDialog: false,
        activeFileItem: null,
        activeFileType: 'folder',
        dropzoneOptions: {
          url: 'https://httpbin.org/post',
          thumbnailWidth: 150,
          maxFilesize: 0.5,
          headers: { 'My-Awesome-Header': 'header value' }
        }
      }
    },
    components: {
      'path-links': PathLinks,
      'file-item': FileItem,
      // 'document-item': DocumentItem,
      // 'folder-item': FolderItem,
      'folder-tree-dialog': FolderTreeDialog,
      'file-rename-dialog': FileRenameDialog,
      'full-drag-drop': FullDragDrop,
      'file-manager-toolbar': FileManagerToolbar
    },
    computed: {
      activeFilename () {
        let vm = this
        return vm.activeFileType === 'folder'
          ? vm.activeFileItem.name
          : vm.activeFileItem.filename
      },
      publicFolder () {
        return this.$store.getters.publicFolder
      },
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
        this.preparing = false
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
    mounted () {
      this.loading = true
      console.log('FileManager.vue :: mounted')
      this.$store.dispatch('FETCH_FOLDER', {
        folderName: this.$route.params.folderId,
        subFolderName: this.$route.params.folderName
      })
    },

    watch: {
      '$route.params.folderId': function (folderId) {
        this.$store.dispatch('FETCH_FOLDER', {
          folderName: this.$route.params.folderId,
          subFolderName: this.$route.params.folderName
        })
      },
      // publicFolder: {
      //   handler: function (value) {
      //     console.log('FileManger :: watch(publicFolder) : vaue: ', value)
      //     let vm = this
      //     if (vm.$route.params.folderId === 'public' && value) {
      //       vm.currentFolderId = value.id
      //       vm.refreshFolder()
      //     }
      //   },
      //   deep: true
      // },
      currentFolder: {
        handler: function (value) {
          this.loading = false
          console.log('FileManager :: watch(currentFolder) : value:', value)
        },
        deep: true
      },
      user: {
        handler: function (value) {
          // console.log('FileManager.vue :: watch(user) : handler: value: ', value)
          // if (value) {
          //   this.initFolder()
          // }
        },
        deep: true
      }
    },
    created () {
      this.subscribe()
    },
    beforeDestroy () {
      this.unSubscribe()
    },
    methods: {
      onNewNameConfirmed (payload) {
        let vm = this
        vm.loading = true
        vm.$store.dispatch('PROCESS_FILE_ITEM', {
          command: 'RENAME',
          fileType: vm.activeFileType,
          fileItem: vm.activeFileItem,
          newName: payload.newName
        })
        vm.showingFileRenameDialog = false
      },

      onTargetFolderSelected (payload) {
        this.showingFolderTreeDialog = false
        switch (payload.command) {
          case 'MOVE_SELECTION':
          case 'COPY_SELECTION':
            this.loading = true
            this.$store.dispatch('PROCESS_SELECTION', {
              command: payload.command,
              targetFolderId: payload.folderId
            })
            break
          case 'MOVE_ITEM':
          case 'COPY_ITEM':
            this.loading = true
            this.$store.dispatch('PROCESS_FILE_ITEM', {
              command: payload.command,
              targetFolderId: payload.folderId,
              fileType: payload.fileType,
              fileItem: payload.fileItem
            })
        }
      },
      // Process on single item
      onActionHandler (payload) {
        let vm = this
        this.currentCommand = payload.command
        switch (this.currentCommand) {
          case 'MOVE_ITEM':
          case 'COPY_ITEM':
            let fileType = payload.fileType
            let fileItem = payload.fileItem
            if (fileType === 'folder') {
              vm.disabledFolderIds = [fileItem.id]
            } else {
              vm.disabledFolderIds = []
            }
            vm.activeFileItem = payload.fileItem
            vm.activeFileType = payload.fileType
            vm.showingFolderTreeDialog = true
            break
          case 'LOCK_ITEM':
            break
          case 'RENAME_ITEM':
            vm.activeFileItem = payload.fileItem
            vm.activeFileType = payload.fileType
            vm.showingFileRenameDialog = true
            break
        }
      },
      onToolbarCommandHandler (payload) {
        let vm = this
        switch (payload.command) {
          case 'SELECT_OR_CLEAR_ALL':
            if (vm.allSelected) {
              vm.$store.dispatch('CLEAR_ALL_FILES')
            } else {
              vm.$store.dispatch('SELECT_ALL_FILES')
            }
            break
          case 'DELETE_SELECTION':
            vm.$dialog.confirm('Are you sure?', {
              okText: 'Yes',
              cancelText: 'No'
            }).then(function (response) {
              vm.$store.dispatch('DELETE_SELECTED')
            })
            break
          case 'MOVE_SELECTION':
            vm.currentCommand = 'MOVE_SELECTION'
            vm.showingFolderTreeDialog = true
            break
          case 'COPY_SELECTION':
            vm.currentCommand = 'COPY_SELECTION'
            vm.showingFolderTreeDialog = true
            break
          case 'NEW_FOLDER':
            vm.$store.dispatch('NEW_FOLDER')
            break
        }
      },
      initFolder () {
        let vm = this
        console.log('FileManager :: initFolder')
        if (vm.$route.params.folderId) {
          switch (vm.$route.params.folderId) {
            case 'public':
              console.log('initFolder(public) :: vm.$store.getters.publicFolder: ', vm.$store.getters.publicFolder.name)
              vm.currentFolderId = vm.$store.getters.publicFolder.id
              break
            case 'personal':
              vm.currentFolderId = vm.user.folder.id
              break
            case 'shared':
              vm.currentFolderId = 0
              break
            default:
              if (vm.$route.params.folderId === 0) {
                let folderName = vm.$route.params.folderName
                console.log('mounted :: route.params: ', vm.$route.params)
                vm.currentFolderId = vm.getUserFolderId(folderName)
              } else {
                vm.currentFolderId = vm.$route.params.folderId
              }
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
      refreshFolder () {
        console.log('FileManager :: refreshFolder')
        let vm = this
        vm.$store.dispatch('FETCH_FOLDER', {
          folderId: vm.currentFolderId
        })
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

.example-full .drop-active {
  top: 0;
  bottom: 0;
  right: 0;
  left: 0;
  position: fixed;
  z-index: 9999;
  opacity: .6;
  text-align: center;
  background: #000;
}
.example-full .drop-active h3 {
  margin: -.5em 0 0;
  position: absolute;
  top: 50%;
  left: 0;
  right: 0;
  -webkit-transform: translateY(-50%);
  -ms-transform: translateY(-50%);
  transform: translateY(-50%);
  font-size: 40px;
  color: #fff;
  padding: 0;
}

</style>