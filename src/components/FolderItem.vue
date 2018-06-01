<template>
  <div class="folder-item d-flex flex-column align-items-center"
       :class="{selected:selected, 'have-selection':haveSelection}">
    <div class="folder-checkbox"
         @click="toggleDocument">
      <i class="fa fa-fw"
         :class="{'fa-check-square text-info':selected,'fa-square text-black-20':!selected}"></i>
    </div>
    <img class="folder-icon"
         @click="onImageClicked"
         :src="getIconSrc(folder.media_id)"/><br/>
    <div class="folder-label">{{ folder.filename }}</div>
    <div class="folder-action">
      <a :href="downloadLink" class="btn btn-primary btn-xs xx">
        <i class="fa fa-fw fa-download"></i>
      </a><br/>
      <button class="btn btn-danger btn-xs" @click="deleteDocument()">
        <i class="fa fa-fw fa-close"></i>
      </button>
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
        return this.$store.getters.selectedDocumentIds.length > 0
      },
      selected () {
        let vm = this
        console.log('DocumentItem :: computed(selected) :: folder.id = ' + vm.folder.id)
        console.log('computer(selected) :: selectedDocumentIds: ', vm.$store.getters.selectedDocumentIds)
        console.log('computer(selected) :: selectedDocumentIds.index(folder.id) = ' +
          vm.$store.getters.selectedDocumentIds.indexOf(vm.folder.id))
        let result = vm.$store.getters.selectedDocumentIds.indexOf(vm.folder.id) >= 0
        console.log('computer(selected) :: result = ' + result)
        return result
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
      deleteDocument () {
        let vm = this
        this.$dialog.confirm('Are you sure?', {
          okText: 'Yes',
          cancelText: 'No'
        }).then(function (dialog) {
          vm.$store.dispatch('DELETE_DOCUMENT', vm.folder.id).then(function () {
            vm.$emit('refresh')
          })
        })
      },
      downloadDocument () {
        let vm = this
        let url = constants.apiUrl + '/media/download/' + vm.folder.media_id
        window.open(url, '_blank')
      },
      getIconSrc (mediaId) {
        return constants.apiUrl + '/media/icons/' + mediaId
      },
      toggleDocument () {
        let vm = this
        console.log('toggleDocument: ' + vm.folder.id)
        this.$store.dispatch('TOGGLE_DOCUMENT_SELECTION', vm.folder).then(function (response) {
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
    display:block;
  }

  .folder-item .folder-checkbox {
    display:none;
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
    width:120px;
    text-align: center;
    float:left;
    margin-bottom:10px;
  }
  .folder-item .folder-label {
    font-size: 8px;
    line-height: 1;
    max-width:120px;
    padding:0 3px;
    margin-top:5px;
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
    margin-top:-2px;
  }

  .folder-item .folder-checkbox {
    display: none;
    position: absolute;
    left: 8px;
    top: 0;
  }
  .folder-item:hover .folder-action {
    visibility: visible;
  }
  .folder-item .folder-action {
    position: absolute;
    right: 11px;
    top: 0;
    visibility: hidden;
  }
  .folder-item .folder-icon {
    width: 48px;
    height: 48px;
    object-fit: contain;
  }
</style>