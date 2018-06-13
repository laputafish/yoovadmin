<template>
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
            :disabled="noneSelected"
            @click="moveSelection()">
      <i class="fa fa-arrows"></i>
    </button>
    <button v-tooltip="'Copy'" class="btn btn-sm btn-default"
            :disabled="noneSelected"
            @click="copySelection()">
      <i class="fa fa-copy"></i>
    </button>
    <button v-tooltip="'Delete'" class="btn btn-sm btn-default"
            :disabled="noneSelected"
            @click="deleteSelected()">
      <i class="fa fa-close"></i>
    </button>
    <!-- Select None -->
    <!--<button class="btn btn-sm btn-info" @click="selectNone()">-->
    <!--<i class="fa fa-square"></i>&nbsp;Clear-->
    <!--</button>-->
    <!-- Download -->
    <a v-tooltip="'Download'" :href="downloadLink" class="btn-toolbar btn btn-sm btn-default ml-auto no-anchor-style"
       :class="{'disabled':noneSelected}">
      <i class="fa fa-download"></i>
    </a>
    <!-- Delete -->
  </div>
</template>

<script>
  export default {
    props: {
      allSelected: {
        type: Boolean,
        default: false
      },
      noneSelected: {
        type: Boolean,
        default: true
      },
      downloadLink: {
        type: String,
        default: ''
      }
    },
    methods: {
      selectClear () {
        this.$emit('onCommand', {command: 'SELECT_OR_CLEAR_ALL'})
      },
      newFolder () {
        this.$emit('onCommand', {command: 'NEW_FOLDER'})
      },
      moveSelection () {
        this.$emit('onCommand', {command: 'MOVE_SELECTION'})
      },
      copySelection () {
        this.$emit('onCommand', {command: 'COPY_SELECTION'})
      },
      deleteSelected () {
        this.$emit('onCommand', {command: 'DELETE_SELECTION'})
      }
    }
  }
</script>