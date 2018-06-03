<template>
    <div class="folder-item d-flex flex-column align-items-center"
         :class="{selected:selected, 'have-selection':haveSelection}">
        <div class="folder-checkbox"
             @click="toggleSelection">
            <i class="fa fa-fw"
               :class="{'fa-check-square text-info':selected,'fa-square text-black-20':!selected}"></i>
        </div>
        <img class="folder-icon"
             @click="enterFolder"
             :src="getIconSrc()"/><br/>
        <input v-if="editing"
               ref="folderName"
               @blur="onEdited"
               @keyup="onKeyUp"
               @focus="$event.target.select()"
               class="filename-editing" v-model="currentName"/>
        <div v-else @click="editName(folder.name)"
             class="folder-label">{{ folder.name }}
        </div>
        <div class="folder-action" v-if="!editing">
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
            <a class="btn btn-xs btn-default" href="#" @click="menuItemSelected">
                <i class="fa fa-fw fa-arrows"></i>
            </a><br/>
            <a class="btn btn-xs btn-default" href="#" @click="menuItemSelected">
                <i class="fa fa-fw fa-copy"></i>
            </a><br/>
            <a class="btn btn-xs btn-default" href="#" @click="menuItemSelected">
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
      folder: {
        type: Object,
        default () {
          return null
        }
      }
    },
    watch: {
      folder: {
        handler: (value) => {
          console.log('DocumentItem :: watch(folder) :: value = ', value)
        },
        deep: true
      }
    },
    computed: {
      haveSelection () {
        return this.$store.getters.haveFileSelected
      },
      selected () {
        return this.$store.getters.selectedFolderIds.indexOf(this.folder.id) >= 0
      },
      downloadLink () {
        return constants.apiUrl + '/media/download/' + this.folder.media_id
      }
      // ,
      // selectedDocumentIds () {
      //   return this.$store.getters.selectedDocumentIds
      // }
    },
    methods: {
      menuItemSelected () {
        alert('menuItemSelected')
      },
      enterFolder () {
        console.log('FolderItem :: enterFolder this.folder: ', this.folder)
        this.$store.dispatch('SET_CURRENT_FOLDER', this.folder.id)
        this.$router.replace('/folders/' + this.folder.id)
      },
      onKeyUp (event) {
        if (event.key === 'Enter') {
          this.onEdited()
        }
      },
      onEdited () {
        let vm = this
        if (vm.currentName !== vm.folder.name) {
          vm.$store.dispatch('UPDATE_FOLDER_NAME', {
            folder: vm.folder,
            name: vm.currentName
          })
        }
        vm.editing = false
      },
      editName (name) {
        let vm = this
        vm.currentName = name
        vm.editing = true
        vm.$nextTick(function () {
          console.log('editName :: refs:', vm.$refs)
          console.log('editName :: refs.folderName:', vm.$refs['folderName'])
          vm.$refs.folderName.focus()
        })
      },
      showDocument () {
        let vm = this
        if (vm.isImage()) {
          vm.imageUrl = '/media/image/' + vm.folder.media_id
          vm.showingImageDialog = true
        } else {
          let url = constants.apiUrl + '/media/folder/' + vm.folder.media_id
          window.open(url, '_blank')
        }
      },
      isImage () {
        let vm = this
        let imageTypes = ['png', 'gif', 'jpg', 'jpeg']
        return imageTypes.indexOf(vm.folder.file_type.toLowerCase()) >= 0
      },
      onImageClicked () {
        this.showDocument()
      },
      deleteFile () {
        let vm = this
        this.$dialog.confirm('Delete the folder "' + vm.folder.name + '"?', {
          okText: 'Yes',
          cancelText: 'No'
        }).then(function (dialog) {
          vm.$store.dispatch('DELETE_FOLDER', vm.folder.id).then(function () {
            vm.$emit('refresh')
          })
        })
      },
      downloadDocument () {
        let vm = this
        let url = constants.apiUrl + '/media/download/' + vm.folder.media_id
        window.open(url, '_blank')
      },
      getIconSrc () {
        return (this.folder.documents.length + this.folder.children.length) > 0
          ? '/static/img/folder_48/Empty-Folder-icon.png'
          : '/static/img/folder_48/Open-Folder-icon.png'
        // constants.apiUrl + '/media/icons/defaults/folder'
      },
      toggleSelection () {
        let vm = this
        this.$store.dispatch('TOGGLE_FOLDER_SELECTION', vm.folder).then(function (response) {
          // vm.$nextTick(function () {
          //   vm.$emit('updateSelected')
          // })
          // console.log('toggleDocument :: after dispatch :: vm.folder: ', vm.folder)
        })
      }
    }
  }
</script>

<style>
    .folder-item.selected .folder-checkbox,
    .folder-item.have-selection .folder-checkbox {
        display: block;
    }

    .folder-item .folder-checkbox {
        display: none;
    }

    /*.folder-item.selected .folder-checkbox i.fa-check-square {*/
    /*display:block;*/
    /*}*/
    /*.folder-item.selected .folder-checkbox i.fa-square {*/
    /*display:none;*/
    /*}*/
    /*.folder-item .folder-checkbox i.fa-check-square {*/
    /*display:none;*/
    /*}*/
    /*.folder-item .folder-checkbox i.fa-square {*/
    /*display:block;*/
    /*}*/

    .folder-item {
        position: Relative;
        cursor: pointer;
        display: inline-block !important;
        width: 120px;
        text-align: center;
        float: left;
        margin-bottom: 10px;
    }

    .folder-item .folder-label {
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

    .folder-item:hover .folder-checkbox {
        display: block;
    }

    .folder-item .folder-checkbox i {
        font-size: 1.5rem;
        margin-top: -2px;
    }

    .folder-item .folder-checkbox {
        display: none;
        position: absolute;
        left: 8px;
        top: 0;
    }

    .folder-item:hover .folder-action {
        visibility: visible;
        z-index: 8000;
    }

    .folder-item .folder-action {
        position: absolute;
        right: 11px;
        top: 0;
        visibility: hidden;
        text-align: left;
    }

    .folder-item .folder-icon {
        width: 48px;
        height: 48px;
        object-fit: contain;
    }

    .folder-item input.filename-editing {
        padding: 0;
        font-size: 9px;
        width: 100%;
        border: 1px solid darkgray;
    }

    .folder-item .dropdown-menu {
        padding: 0;
        border: none;
        text-align: right;
        right: 0;
        left: inherit;
        white-space: nowrap;
        min-width: 0;
    }

    .folder-item .dropdown-menu .dropdown-item {
        padding: 5px 10px;
        display: inline-block;
    }

    .folder-item .dropdown-menu .dropdown-item i {
        margin-left: 0;
        color: darkgray;
    }

    .folder-item .dropdown-menu .btn {
        margin-right: 1px;
    }

    .folder-item .dropdown-menu .dropdown-item:hover {
        background-color: lightgray;
        color: black;
    }
</style>