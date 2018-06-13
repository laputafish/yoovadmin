<template>
  <div class="document-item d-flex flex-column align-items-center"
    :class="{selected:selected, 'have-selection':haveSelection}">
    <div class="document-checkbox"
      @click="toggleSelection">
      <i class="fa fa-fw"
         :class="{'fa-check-square text-info':selected,'fa-square text-black-20':!selected}"></i>
    </div>
    <img class="document-icon"
        :draggable="true"
         @dragStart.stop="handleDragStart"
         @click="onImageClicked"
         :src="getIconSrc(document.media_id)"/><br/>
    <input v-if="editing"
           ref="documentName"
           @blur="onEdited"
           @focus="$event.target.select()"
           class="filename-editing" v-model="currentName"/>
    <div v-else class="document-label">{{ document.filename }}</div>
    <div class="document-action">
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
      :title="document.filename"
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
        return this.$store.getters.haveFileSelected
      },
      selected () {
        return this.$store.getters.selectedDocumentIds.indexOf(this.document.id) >= 0
      },
      downloadLink () {
        return constants.apiUrl + '/media/download/' + this.document.media_id
      }
      // ,
      // selectedDocumentIds () {
      //   return this.$store.getters.selectedDocumentIds
      // }
    },
    methods: {
      handleDragStart () {
        let vm = this
        this.$store.dispatch('SET_DRAGGABLE_ITEM', {
          vm: vm,
          name: vm.document.filename,
          type: 'document',
          data: vm.document
        })
        this.$el.classList.add('dragging-node')
      },
      isAllowedToDrop () {
        let vm = this
        // const { draggingVm } = vm.draggingItem
        //
        // // limitation 1: this cannot be the parent of the dragging node
        // if (vm === draggingVm.$parent) {
        //   return false
        // }
        //
        // // limitation 2: this cannot be the adjacent empty node of the dragging node
        // if (vm.$parent === draggingVm.$parent && Math.abs(vm.vmIdx - draggingVm.vmIdx) === 1) {
        //   return false
        // }
        //
        // // limitation 3: this cannot be the dragging node itself or its descendant
        // while (vm) {
        //   if (vm === draggingVm) return false
        //   vm = vm.$parent.$options.name === 'TreeNode' ? vm.$parent : null
        // }

        return true
      },
      onEdited () {
        alert('onEdited')
        let vm = this
        if (vm.currentName !== vm.document.name) {
          vm.$store.dispatch('UPDATE_FILENAME', {
            folder: vm.folder,
            name: vm.currentName
          })
        }
        vm.editing = false
      },
      editName (name) {
        this.currentName = name
        this.editing = true
        this.$refs.documentName.$el.focus()
      },
      showDocument () {
        let vm = this
        if (vm.isImage()) {
          vm.imageUrl = '/media/image/' + vm.document.media_id
          vm.showingImageDialog = true
        } else {
          let url = constants.apiUrl + '/media/document/' + vm.document.media_id
          window.open(url, '_blank')
        }
      },
      isImage () {
        let vm = this
        let imageTypes = ['png', 'gif', 'jpg', 'jpeg']
        return imageTypes.indexOf(vm.document.file_type.toLowerCase()) >= 0
      },
      onLongTap () {
//       alert('onLongTap')
      },
      onTap () {
//        alert('onTap')
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
        let vm = this
        let url = constants.apiUrl + '/media/download/' + vm.document.media_id
        window.open(url, '_blank')
      },
      getIconSrc (mediaId) {
        return constants.apiUrl + '/media/icons/' + mediaId
      },
      toggleSelection () {
        let vm = this
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
    margin-bottom:10px;
  }
  .document-item .document-label {
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
  .document-item input.filename-editing {
    padding: 0;
    font-size: 9px;
    width: 100%;
    border: 1px solid darkgray;
  }
</style>