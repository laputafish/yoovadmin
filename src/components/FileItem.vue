<template>
  <div class="file-item d-flex flex-column align-items-center"
       :class="{selected:selected, 'have-selection':haveSelection}">
    <div class="file-item-status">
      <div class="file-item-checkbox"
           :class="{'last-selected text-info':isLastSelected}"
           @click.prevent.stop="toggleSelection">
        <i class="fa fa-fw"
           :class="{'fa-check-circle text-default':selected,'fa-circle text-black-20':!selected}"></i>
      </div>
      <div class="file-item-checkbox"
           @click.prevent.stop="extendSelection">
        <i class="fa fa-fw fa-asterisk text-lightgray"></i>
      </div>
      <!--<div class="file-item-summary"-->
      <!--@click.prevent.stop="onImageClicked">-->
      <!--<div class="file-folder-count">-->
      <!--{{ fileItem.children.length }}-->
      <!--</div>-->
      <!--<div class="file-document-count">-->
      <!--{{ fileItem.documents ? fileItem.documents.length : 0 }}-->
      <!--</div>-->
      <!--</div> -->
      <!--<div class="file-item-status-item">-->
      <!--<i class="fa fa-fw fa-folder"></i><br/>-->
      <!--<span class="badge badge-primary">-->
      <!--{{ fileItem.children.length }}-->
      <!--</span>-->
      <!--</div>-->
      <!--<div class="file-item-status-item">-->
      <!--<i class="fa fa-fw fa-file"></i><br/>-->
      <!--<span class="badge badge-primary">-->
      <!--{{ fileItem.documents.length }}-->
      <!--</span>-->
      <!--</div>-->
    </div>
    <a v-if="fileItem.type==='document' && !isSupportedFileType"
       :href="downloadLink"
       v-touch:tap="onTap"
       v-touch:longtap="onLongTap">
      <img class="file-item-icon"
           :draggable="true"
           @drop.stop="handleDrop"
           @dragover.stop="handleDragOver"
           @dragenter.stop="handleDragEnter"
           @dragleave.stop="handleDragLeave"
           :src="getIconSrc()"/><br/>
    </a>
    <div v-else-if="fileItem.type==='folder'"
         :draggable="true"
         @click.prevent.stop="enterFolder"
         @drop.stop="handleDrop"
         @dragstart.stop="handleDragStart"
         @dragend.stop="handleDragEnd"
         @dragover.stop="handleDragOver"
         @dragenter.stop="handleDragEnter"
         @dragleave.stop="handleDragLeave"
         class="folder-dropzone">
    </div>
    <img v-else
         class="file-item-icon"
         :draggable="true"
         @dragstart.stop="handleDragStart"
         v-touch:tap="onTap"
         v-touch:longtap="onLongTap"
         @click.prevent.stop="onImageClicked"
         :src="getIconSrc()"/><br/>
    <input v-if="editing"
           ref="fileItemName"
           @blur="onEdited"
           @keyup="onKeyUp"
           @focus="$event.target.select()"
           class="filename-editing" v-model="currentName"/>
    <div v-else @click="editName(fileItem)"
         class="file-item-label">{{ fileItemName }}
    </div>
    <div class="file-item-action" v-if="!editing">
      <a :href="downloadLink" class="btn btn-primary btn-xs xx">
        <i class="fa fa-fw fa-download"></i>
      </a><br/>
      <button class="btn btn-danger btn-xs" @click="deleteFile()">
        <i class="fa fa-fw fa-close"></i>
      </button>
      <br/>
      <!--<button-->
      <!--id="dropdownFileMenuButton"-->
      <!--class="btn btn-default btn-xs"-->
      <!--type="button"-->
      <!--data-toggle="dropdown"-->
      <!--aria-expanded="true">-->
      <!--<i class="fa fa-fw fa-ellipsis-h"></i>-->
      <!--</button>-->
      <!--<div class="dropdown-menu show" aria-labelledby="dropdownFileMenuButton">-->
      <a class="btn btn-xs btn-default" href="#" @click="menuItemSelected('MOVE_ITEM')">
        <i class="fa fa-fw fa-arrows"></i>
      </a><br/>
      <a class="btn btn-xs btn-default" href="#" @click="menuItemSelected('COPY_ITEM')">
        <i class="fa fa-fw fa-copy"></i>
      </a><br/>
      <a class="btn btn-xs btn-default" href="#" @click="menuItemSelected('RENAME_ITEM')">
        <i class="fa fa-fw fa-edit"></i>
      </a><br/>
      <a class="btn btn-xs btn-default" href="#" @click="menuItemSelected('LOCK_ITEM')">
        <i class="fa fa-fw fa-lock"></i>
      </a>
      <!--</div>-->
    </div>
    <yoov-image-dialog
      v-if="showingImageDialog"
      @close="showingImageDialog=false"
      :imageUrl="imageUrl"></yoov-image-dialog>
  </div>
</template>

<script>
  import * as constants from '@/store/constants'
  import YoovImageDialog from '@/dialogs/YoovImageDialog'

  export default {
    components: {
      'yoov-image-dialog': YoovImageDialog
    },
    data () {
      return {
        editing: false,
        currentName: '',
        imageUrl: '',
        showingImageDialog: false
      }
    },
    props: {
      // fileType: {
      //   type: String,
      //   default: 'folder'
      // },
      fileItem: {
        type: Object,
        default () {
          return {
            type: 'document',
            data: null
          }
        }
      }
    },
    watch: {
      fileItem: {
        handler: (value) => {

        },
        deep: true
      }
    },
    computed: {
      isLastSelected () {
        let vm = this
        let result = false
        if (vm.fileItem && vm.lastSelectedFileItem) {
          result = vm.fileItem.type === vm.lastSelectedFileItem.type &&
            vm.fileItem.data.id === vm.lastSelectedFileItem.data.id
        }
        return result
      },
      lastSelectedFileItem () {
        return this.$store.getters.lastSelectedFileItem
      },
      fileItemName () {
        return this.fileItem.type === 'folder'
          ? this.fileItem.data.name
          : this.fileItem.data.filename
      },
      isSupportedFileType () {
        let vm = this
        let result = false
        let supportedTypes = ['txt', 'jpg', 'gif', 'jpeg', 'png', 'png']
        if (vm.fileItem.type === 'document' &&
          supportedTypes.indexOf(vm.fileItem.data.file_type.toLowerCase()) >= 0) {
          result = true
        }
        return result
      },
      draggingItem () {
        console.log('computed (draggingItem) : ')
        return this.$store.getters.draggingItem
      },
      haveSelection () {
        return this.$store.getters.haveFileSelected
      },
      selected () {
        let vm = this
        if (vm.fileItem.type === 'folder') {
          return vm.$store.getters.selectedFolderIds.indexOf(vm.fileItem.data.id) >= 0
        } else {
          return vm.$store.getters.selectedDocumentIds.indexOf(vm.fileItem.data.id) >= 0
        }
      },
      downloadLink () {
        return constants.apiUrl + '/media/download/' + this.fileItem.data.media_id
        // ,
        // selectedDocumentIds () {
        //   return this.$store.getters.selectedDocumentIds
        // }
      }
    },
    // mounted () {
    //   console.log('fileItem: ', this.fileItem)
    // },
    methods: {
      isAllowedToDrop () {
        let vm = this

        // limitation 1: this cannot be the parent of the dragging node
        // if (vm === vm.draggingItem.$parent) {
        //   return false
        // }

        // limitation 2: this cannot be the adjacent empty node of the dragging node
        // if (vm.$parent === draggingVm.$parent && Math.abs(vm.vmIdx - draggingVm.vmIdx) === 1) {
        //   return false
        // }

        // limitation 3: this cannot be the dragging node itself or its descendant
        // while (vm) {
        //   if (vm === vm.draggingItem.vm) return false
        //   vm = vm.$parent.$options.name === 'TreeNode' ? vm.$parent : null
        // }
        // console.log('isAllowedToDrop :: fileType = ' + this.fileType)
        //    console.log('isAllowedToDrop: draggingItem: ', (typeof vm.draggingItem === 'undefined'))
        if (vm.draggingItem) {
          console.log('isAllowedToDrop :: vm.draggingItem.fileItem === vm.fileItem: ' +
            (vm.draggingItem.fileItem === vm.fileItem ? 'yes' : 'no'))
        }
        let notSelf = (typeof vm.draggingItem === 'undefined') ||
          (vm.draggingItem.fileItem !== vm.fileItem)
        if (typeof vm.draggingItem !== 'undefined') {

        }
        console.log('isAllowedToDrop :: notSelf: ' + (notSelf ? 'yes' : 'no'))
        return notSelf && (vm.fileItem.type === 'folder')
      },

      handleDragEnd () {
        let vm = this
        this.$store.dispatch('SET_DRAGGABLE_ITEM', {
          name: '',
          fileType: 'none',
          fileItem: null
        }).then(function () {
          vm.$el.classList.remove('dragging-node')
        })
      },

      handleDragStart () {
        //      console.log('handleDragStart')
        let vm = this
        this.$store.dispatch('SET_DRAGGABLE_ITEM', {
          name: vm.fileType === 'folder' ? vm.fileItem.name : vm.fileItem.filename,
          fileType: vm.fileType,
          fileItem: vm.fileItem
        }).then(function () {
          vm.$el.classList.add('dragging-node')
        })
      },
      handleDragOver (e) {
        e.preventDefault()
        let dropEffect = this.isAllowedToDrop() ? 'move' : 'none'
        console.log('handleDragOver :: dropEffect = ' + dropEffect)
        e.dataTransfer.dropEffect = dropEffect
//        console.log('handleDragOver :: e.dataTransfer.dropEffect = ' + e.dataTransfer.dropEffect)
      },
      handleDragEnter (e) {
        // if (this.isAllowedToDrop()) {
        //   e.dataTransfer.dropEffect = 'move'
        //   this.$el.classList.add('dragging-over')
        // } else {
        //   e.dataTransfer.dropEffect = 'none'
        //   return false
        // }
        this.$el.classList.add('dragging-over')
      },
      handleDragLeave (e) {
        // console.log('handleDragLeave :: e.currentTarget: ', e.currentTarget)
        this.$el.classList.remove('dragging-over')
      },
      handleDrop () {
        let vm = this
        vm.$el.classList.remove('dragging-over')
        vm.$store.dispatch('DROP_FILEITEM', {
          target: vm.fileItem
        }).then(function () {
          vm.$store.dispatch('REFRESH_FOLDER')
        })
      },
      menuItemSelected (command) {
        let vm = this
        vm.$emit('onAction', {
          command: command,
          fileItem: vm.fileItem
        })
      },
      // enterfileItem () {
      //   console.log('fileItemItem :: enterfileItem this.fileItem: ', this.fileItem)
      //   this.$store.dispatch('SET_CURRENT_fileItem', this.fileItem.id)
      //   this.$router.replace('/fileItems/' + this.fileItem.id)
      // },
      onKeyUp (event) {
        if (event.key === 'Enter') {
          this.onEdited()
        }
      },
      onEdited () {
        let vm = this
        if (vm.currentName !== vm.fileItem.name) {
          if (vm.fileType === 'folder') {
            vm.$store.dispatch('UPDATE_FOLDER_NAME', {
              fileItem: vm.fileItem,
              name: vm.currentName
            })
          } else {
            vm.$store.dispatch('UPDATE_DOCUMENT_NAME', {
              fileItem: vm.fileItem,
              name: vm.currentName
            })
          }
        }
        vm.editing = false
      },
      editName (fileItem) {
        let vm = this
        vm.currentName = fileItem.type === 'folder' ? fileItem.data.name : fileItem.data.filename
        vm.editing = true
        vm.$nextTick(function () {
          console.log('editName :: refs:', vm.$refs)
          console.log('editName :: refs.fileItemName:', vm.$refs['fileItemName'])
          vm.$refs.fileItemName.focus()
        })
      },
      showDocument () {
        let vm = this
        if (vm.isImage()) {
          vm.imageUrl = '/media/image/' + vm.fileItem.data.media_id
          vm.showingImageDialog = true
        } else {
          let url = constants.apiUrl + '/media/document/' + vm.fileItem.data.media_id
          window.open(url, '_blank')
        }
      },
      isImage () {
        let vm = this
        let imageTypes = ['png', 'gif', 'jpg', 'jpeg']
        return imageTypes.indexOf(vm.fileItem.file_type.toLowerCase()) >= 0
      },
      onLongTap () {
        // console.log('onLongTap')
      },
      onTap () {
        // console.log('onTap')
      },
      enterFolder () {
        let vm = this
        vm.$store.dispatch('FETCH_FOLDER', {
          folderId: vm.fileItem.id
        }).then(function () {
          history.pushState({}, null, '/folders/' + vm.fileItem.id)
        })
      },
      onImageClicked (event) {
        // console.log('onImageClicked :: event: ', event)
        // console.log('onImageClicked')
        // this.showDocument()
        // console.log('fileItemItem :: enterfileItem this.fileItem: ', this.fileItem)
        // this.$store.dispatch('SET_CURRENT_FOLDER', this.fileItem.id)
        let vm = this
        if (vm.fileType === 'folder') {
          vm.enterFolder()
        } else {
          vm.showDocument()
        }
      },

      deleteFile () {
        let vm = this
        this.$dialog.confirm('Delete the fileItem "' + vm.fileItem.name + '"?', {
          okText: 'Yes',
          cancelText: 'No'
        }).then(function (dialog) {
          let action = 'DELETE_DOCUMENT'
          if (vm.fileType === 'folder') {
            action = 'DELETE_FOLDER'
          }
          vm.$store.dispatch(action, vm.fileItem.id)
        })
      },
      downloadDocument () {
        let vm = this
        let url = constants.apiUrl + '/media/download/' + vm.fileItem.media_id
        window.open(url, '_blank')
      },
      getIconSrc () {
        let vm = this
        if (vm.fileType === 'folder') {
          return (
            (this.fileItem.documents ? this.fileItem.documents.length : 0) +
            (this.fileItem.children ? this.fileItem.children.length : 0)) > 0
            ? '/static/img/folder_48/Empty-folder-icon.png'
            : '/static/img/folder_48/Open-folder-icon.png'
        } else {
          return constants.apiUrl + '/media/icons/' + vm.fileItem.media_id
        }
        // constants.apiUrl + '/media/icons/defaults/fileItem'
      },
      toggleSelection () {
        let vm = this
        this.$store.dispatch('TOGGLE_FILE_ITEM_SELECTION',
          {fileItem: vm.fileItem}
        ).then(function (response) {
          // vm.$nextTick(function () {
          //   vm.$emit('updateSelected')
          // })
          // console.log('toggleDocument :: after dispatch :: vm.fileItem: ', vm.fileItem)
        })
      },
      extendSelection () {
        let vm = this
        if (vm.isLastSelected) {
          this.$store.dispatch('CLEAR_LAST_SELECTION')
        } else {
          this.$store.dispatch('EXTEND_FILE_ITEM_SELECTION', {
            fileItem: vm.fileItem
          }).then(function (response) {
            // vm.$nextTick(function () {
            //   vm.$emit('updateSelected')
            // })
            // console.log('toggleDocument :: after dispatch :: vm.fileItem: ', vm.fileItem)
          })
        }
      }
    }
  }
</script>

<style>
  .file-item.selected .file-item-status .file-item-checkbox,
  .file-item.have-selection .file-item-status .file-item-checkbox {
    display: block;
  }

  .file-item .file-item-status .file-item-checkbox {
    display: none;
  }

  .file-item {
    position: Relative;
    cursor: pointer;
    display: inline-block !important;
    width: 120px;
    text-align: center;
    float: left;
    margin-bottom: 10px;
  }

  .file-item .file-item-label {
    font-size: 8px;
    line-height: 1;
    max-width: 120px;
    padding: 0 3px;
    margin-top: -5px;
    height: 26px;
    overflow: hidden;
    white-space: normal;
    text-overflow: ellipsis;
  }

  .file-item:hover .file-item-status .file-item-checkbox,
  .file-item:hover .file-item-status .file-item-summary,
  .file-item:hover .file-item-status .file-item-status-item {
    display: block;
  }

  .file-item .file-item-status .file-item-checkbox i {
    font-size: 1.5rem;
  }

  .file-item .file-item-status .file-item-checkbox,
  .file-item .file-item-status .file-item-summary,
  .file-item .file-item-status .file-item-status-item {
    display: none;
  }

  .file-item .file-item-status {
    position: absolute;
    left: 8px;
    top: 0;
  }

  .file-item:hover .file-item-action {
    visibility: visible;
    z-index: 8000;
  }

  .file-item .file-item-action {
    position: absolute;
    right: 11px;
    top: 0;
    visibility: hidden;
    text-align: left;
  }

  .file-item .file-item-icon {
    width: 48px;
    height: 48px;
    object-fit: contain;
  }

  .file-item .folder-dropzone {
    width: 48px;
    height: 48px;
    background-image: url("/static/img/folder_48/Close-Folder-icon.png");
    display: inline-block;
  }

  .file-item input.filename-editing {
    padding: 0;
    font-size: 9px;
    width: 100%;
    border: 1px solid darkgray;
  }

  .file-item .dropdown-menu {
    padding: 0;
    border: none;
    text-align: right;
    right: 0;
    left: inherit;
    white-space: nowrap;
    min-width: 0;
  }

  .file-item .dropdown-menu .dropdown-item {
    padding: 5px 10px;
    display: inline-block;
  }

  .file-item .dropdown-menu .dropdown-item i {
    margin-left: 0;
    color: darkgray;
  }

  .file-item .dropdown-menu .btn {
    margin-right: 1px;
  }

  .file-item .dropdown-menu .dropdown-item:hover {
    background-color: lightgray;
    color: black;
  }

  .file-item .file-item-summary {
    position: absolute;
    top: 0;
    left: 20px;
  }

  .file-item .file-folder-count {
    background-color: rgba(0, 0, 0, .5);
    top: 16px;
    color: lightgray;
    line-height: 0.9;
    position: absolute;
    left: 20px;
    font-size: 8px;
    width: 20px;
    padding: 1px 0;
  }

  .file-item .file-document-count {
    font-size: 9px;
    color: white;
    top: 28px;
    left: 20px;
    position: absolute;
    line-height: 0.8;
    width: 20px;
  }

  .file-item img {
    vertical-align: baseline;
  }

  .file-item.dragging-over.dragging-node .folder-dropzone {
    background-color: transparent;
  }

  .file-item.dragging-over .folder-dropzone {
    background-image: url("/static/img/folder_48/Open-Folder-icon.png");
    cursor: pointer;
  }
  .file-item-checkbox.last-selected {

  }
  .text-lightgray {
    color: lightgray;
  }
  .text-darkgray {
    color: darkgray;
  }
</style>