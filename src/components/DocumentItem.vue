<template>
  <div class="document-item d-flex flex-column align-items-center"
    :class="{selected:document.selected}">
    <div class="document-checkbox"
      @click="toggleDocument">
      <i class="fa fa-fw fa-square"></i>
    </div>
    <img class="document-icon"
         :src="getIconSrc(document.media_id)"/><br/>
    <small class="document-label">{{ document.filename }}</small>
    <div class="document-action">
      <button class="btn btn-danger btn-xs">
        <i class="fa fa-fw fa-close"></i>
      </button>
    </div>
  </div>
</template>

<script>
  import * as constants from '@/store/constants'

  export default {
    props: {
      document: {
        type: Object,
        default () {
          return null
        }
      }
    },
    methods: {
      getIconSrc (mediaId) {
        return constants.apiUrl + '/media/icons/' + mediaId
      },
      toggleDocument () {
        let vm = this
        console.log('toggleDocument: ' + vm.document.id)
        this.$store.dispatch('TOGGLE_DOCUMENT_SELECTION', document)
      }
    }
  }
</script>

<style>
  .document-item.selected .document-checkbox {
    display:block;
  }

  .document-item .document-checkbox {
    display:none;
  }

  .document-item.selected .document-checkbox i.fa-check-square {
    display:block;
  }
  .document-item.selected .document-checkbox i.fa-square {
    display:none;
  }
  .document-item .document-checkbox i.fa-check-square {
    display:none;
  }
  .document-item .document-checkbox i.fa-square {
    display:block;
  }

  .document-item {
    position: Relative;
    cursor: pointer;
    display: inline-block !important;
    width:120px;
    text-align: center;
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