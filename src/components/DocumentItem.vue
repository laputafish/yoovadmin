<template>
  <div class="document-item d-flex flex-column align-items-center"
    :class="{selected:selected, 'have-selection':haveSelection}">
    <div class="document-checkbox"
      @click="toggleDocument">
      <i class="fa fa-fw"
         :class="{'fa-check-square text-info':selected,'fa-square text-black-20':!selected}"></i>
    </div>
    <img class="document-icon"
         @click="onImageClicked"
         :src="getIconSrc(document.media_id)"/><br/>
    <div class="document-label">{{ document.filename }}</div>
    <div class="document-action">
      <button class="btn btn-primary btn-xs" @click="downloadDocument()">
        <i class="fa fa-fw fa-download"></i>
      </button><br/>
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
      document: {
        type: Object,
        default () {
          return null
        }
      }
    },
    watch: {
      document: {
        handler: (value) => {
          console.log('DocumentItem :: watch(document) :: value = ', value)
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
        console.log('DocumentItem :: computed(selected) :: document.id = ' + vm.document.id)
        console.log('computer(selected) :: selectedDocumentIds: ', vm.$store.getters.selectedDocumentIds)
        console.log('computer(selected) :: selectedDocumentIds.index(document.id) = ' +
          vm.$store.getters.selectedDocumentIds.indexOf(vm.document.id))
        let result = vm.$store.getters.selectedDocumentIds.indexOf(vm.document.id) >= 0
        console.log('computer(selected) :: result = ' + result)
        return result
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
          vm.imageUrl = '/media/image/' + vm.document.media_id
          vm.showingImageDialog = true
        } else {
          let url = '/media/document/' + vm.document.media_id
          window.open(url, '_blank')
        }
      },
      isImage () {
        let vm = this
        let imageTypes = ['png', 'gif', 'jpg', 'jpeg']
        return imageTypes.indexOf(vm.document.file_type.toLowerCase()) >= 0
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
          vm.$store.dispatch('DELETE_DOCUMENT', vm.document.id).then(function () {
            vm.$emit('refresh')
          })
        })
      },
      downloadDocument () {

      },
      getIconSrc (mediaId) {
        return constants.apiUrl + '/media/icons/' + mediaId
      },
      toggleDocument () {
        let vm = this
        console.log('toggleDocument: ' + vm.document.id)
        this.$store.dispatch('TOGGLE_DOCUMENT_SELECTION', vm.document).then(function (response) {
          // vm.$nextTick(function () {
          //   vm.$emit('updateSelected')
          // })
          // console.log('toggleDocument :: after dispatch :: vm.document: ', vm.document)
        })
      }
    }
  }
</script>

<style>
  .document-item.selected .document-checkbox,
  .document-item.have-selection .document-checkbox {
    display:block;
  }

  .document-item .document-checkbox {
    display:none;
  }

  /*.document-item.selected .document-checkbox i.fa-check-square {*/
    /*display:block;*/
  /*}*/
  /*.document-item.selected .document-checkbox i.fa-square {*/
    /*display:none;*/
  /*}*/
  /*.document-item .document-checkbox i.fa-check-square {*/
    /*display:none;*/
  /*}*/
  /*.document-item .document-checkbox i.fa-square {*/
    /*display:block;*/
  /*}*/

  .document-item {
    position: Relative;
    cursor: pointer;
    display: inline-block !important;
    width:120px;
    text-align: center;
    float:left;
  }
  .document-item .document-label {
    font-size: 8px;
    line-height: 1;
    max-width:120px;
    padding:0 3px;
    margin-top:5px;
    height: 24px;
    overflow: hidden;
    white-space: normal;
    text-overflow: ellipsis;
  }
  .document-item:hover .document-checkbox {
    display: block;
  }
  .document-item .document-checkbox i {
    font-size: 1.5rem;
    margin-top:-2px;
  }

  .document-item .document-checkbox {
    display: none;
    position: absolute;
    left: 8px;
    top: 0;
  }
  .document-item:hover .document-action {
    visibility: visible;
  }
  .document-item .document-action {
    position: absolute;
    right: 11px;
    top: 0;
    visibility: hidden;
  }
  .document-item .document-icon {
    width: 48px;
    height: 48px;
    object-fit: contain;
  }
</style>