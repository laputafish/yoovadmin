<template>
    <div class="folder-icon d-flex flex-column">
        <img :src="imgSrc"/>
        <small :style="labelStyle" v-if="label!==''" class="align-self-center">{{ label }}</small>
    </div>
</template>

<script>
  const ICON_FILES = {
    'all_close': {bMargin: 13, filename: 'All-Folder-icon.png'},
    'close': {bMargin: 13, filename: 'Close-Folder-icon.png'},
    'close_path': {bMargin: 9, filename: 'Close-Folder-icon.png'},
    'download_path': {bMargin: 7, filename: 'Download-path-icon.png'},
    'open_document_path': {bMargin: 13, filename: 'Empty-path-icon.png'},
    'empty_basket1': {bMargin: 0, filename: 'Empty-Trash-icon.png'},
    'full_basket1': {bMargin: 0, filename: 'Full-Trash-icon.png'},
    'lock_path': {bMargin: 12, filename: 'Lock-Folder-icon.png'},
    'network_off_path': {bMargin: 2, filename: 'Network-Folder-Cross-icon.png'},
    'open_documents_path': {bMargin: 13, filename: 'Opened-Folder-icon.png'},
    'open_empty_path': {bMargin: 13, filename: 'Open-Folder-icon.png'},
    'plus_path': {bMargin: 12, filename: 'Plus-Folder-icon.png'},
    'network_on_path': {bMargin: 2, filename: 'Stand-Folder-icon.png'},
    'empty_basket2': {bMargin: 0, filename: 'Start-Menu-Recycle-Bin-Empty-icon.png'},
    'full_basket2': {bMargin: 0, filename: 'Start-Menu-Recycle-Bin-Full-icon.png'},
    'tick_path': {bMargin: 13, filename: 'Tick-Folder-icon.png'},
    'empty_incoming_tray': {bMargin: 8, filename: 'Trash-2-Empty-icon.png'},
    'full_outgoing_tray': {bMargin: 8, filename: 'Trash-2-Full-icon.png'},
    'empty_trash': {bMargin: 1, filename: 'Trash-empty-icon.png'},
    'full_trash': {bMargin: 1, filename: 'Trash-icon.png'},
    'empty_recycle_bin': {bMargin: 8, filename: 'Trash-white-empty-icon.png'},
    'full_recycle_bin': {bMargin: 8, filename: 'Trash-white-full-icon.png'},
    'upload_folder': {bMargin: 7, filename: 'Upload-Folder-icon.png'},
    'full_tray': {bMargin: 6, filename: 'White-Recycle-Bin-Full-icon.png'},
    'empty_tray': {bMargin: 6, filename: 'White-Recycle-Bin-icon.png'}
  }

  export default {
    data () {
      return {
        imgSrc: ''
      }
    },
    props: {
      label: {
        type: String,
        default: ''
      },
      iconType: {
        type: String,
        default: 'close'
      },
      iconSize: {
        type: Number,
        default: 64
      }
    },
    mounted () {
      let vm = this
      let path = '/static/img/folder_'
      switch (vm.iconSize) {
        case 32:
        case 48:
        case 64:
        case 72:
        case 96:
        case 128:
        case 256:
        case 512:
          path += vm.iconSize
          break
        default:
          path += 32
      }
      path += '/' + ICON_FILES[vm.iconType].filename
      vm.imgSrc = path
    },
    computed: {
      labelStyle () {
        let vm = this
        return {
          marginTop: '-' + (ICON_FILES[vm.iconType].bMargin - 2) + 'px'

        }
      }
    }
  }
</script>