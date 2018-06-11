<template>
    <div class="file-item d-flex flex-column align-items-center"
         :class="{selected:selected, 'have-selection':haveSelection}">
        <div class="file-item-status">
            <div class="file-item-checkbox"
                 @click.prevent.stop="toggleSelection">
                <i class="fa fa-fw"
                   :class="{'fa-check-square text-info':selected,'fa-square text-black-20':!selected}"></i>
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
        <a v-if="fileType==='document' && !isSupportedFileType"
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
        <img v-else
             class="file-item-icon"
             :draggable="true"
             @drop.stop="handleDrop"
             @dragstart.stop="handleDragStart"
             @dragover.stop="handleDragOver"
             @dragenter.stop="handleDragEnter"
             @dragleave.stop="handleDragLeave"
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
        <div v-else @click="editName(fileItem.name)"
             class="file-item-label">{{ fileType === 'folder' ? fileItem.name : fileItem.filename }}
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
      fileType: {
        type: String,
        default: 'folder'
      },
      fileItem: {
        type: Object,
        default () {
          return null
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
      isSupportedFileType () {
        let vm = this
        let result = false
        let supportedTypes = ['txt', 'jpg', 'gif', 'jpeg', 'png', 'png']
        if (vm.fileType === 'document' &&
          supportedTypes.indexOf(vm.fileItem.file_type.toLowerCase()) >= 0) {
          result = true
        }
        return result
      },
      draggingItem () {
        return this.$store.getters.draggingItem
      },
      haveSelection () {
        return this.$store.getters.haveFileSelected
      },
      selected () {
        let vm = this
        if (vm.fileType === 'folder') {
          if (vm.fileType === 'folder') {
            return vm.$store.getters.selectedFolderIds.indexOf(vm.fileItem.id) >= 0
          } else {
            return vm.$store.getters.selectedDocumentIds.indexOf(vm.fileItem.id) >= 0
          }
        }
      },
      downloadLink () {
        return constants.apiUrl + '/media/download/' + this.fileItem.media_id
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
        // let vm = this

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
        return this.fileType === 'folder'
      },

      handleDragStart () {
        let vm = this
        this.$store.dispatch('SET_DRAGGABLE_ITEM', {
          vm: vm,
          name: vm.fileItem.name,
          fileType: vm.fileType,
          fileItem: vm.fileItem
        })
        this.$el.classList.add('dragging-node')
      },
      handleDragOver (e) {
        console.log('handleDragOver')
        e.preventDefault() // must!!!
        e.dataTransfer.dropEffect = this.isAllowedToDrop() ? 'move' : 'none'
      },
      handleDragEnter () {

      },
      handleDragLeave () {
        console.log('handleDragLeave')
      },
      handleDrop () {
        let vm = this
        this.$store.dispatch('DROP_FILEITEM', {
          target: vm.fileItem
        }).then(function () {
          this.$store.dispatch('REFRESH_FOLDER')
        })
      },
      menuItemSelected (command) {
        let vm = this
        vm.$emit('onAction', {
          command: command,
          fileType: vm.fileType,
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
      editName (name) {
        let vm = this
        vm.currentName = name
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
          vm.imageUrl = '/media/image/' + vm.fileItem.media_id
          vm.showingImageDialog = true
        } else {
          let url = constants.apiUrl + '/media/document/' + vm.fileItem.media_id
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
      onImageClicked (event) {
        // console.log('onImageClicked :: event: ', event)
        // console.log('onImageClicked')
        // this.showDocument()
        // console.log('fileItemItem :: enterfileItem this.fileItem: ', this.fileItem)
        // this.$store.dispatch('SET_CURRENT_FOLDER', this.fileItem.id)
        let vm = this
        if (vm.fileType === 'folder') {
          vm.$store.dispatch('FETCH_FOLDER', {
            folderId: vm.fileItem.id
          }).then(function () {
            history.pushState({}, null, '/folders/' + vm.fileItem.id)
          })
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
          vm.$store.dispatch(action, vm.fileItem.id).then(function () {
            vm.$emit('refresh')
          })
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
        this.$store.dispatch('TOGGLE_FILE_ITEM_SELECTION', {
          fileType: vm.fileType,
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
        margin-top: 5px;
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
        margin-top: -2px;
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
        background-color: rgba(0,0,0,.5);
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
</style>