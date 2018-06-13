<template>
  <yoov-modal id="fileRenameDialog">
    <div slot="header">
      <h3 class="dialog-title">
        Rename File
      </h3>
    </div>
    <div slot="body" class="yoov-modal-body">
      <div class="form-group">
        <label for="oldName">Original Name</label>
        <input id="oldName" readonly class="form-control" v-model="oldName"/>
      </div>
      <div class="form-group">
        <label for="newName">New Name</label>
        <input id="newName" class="form-control" v-model="newName"/>
      </div>
    </div>
    <div slot="footer" style="width:100%;" class="mt-0 pt-0">
      <button class="btn btn-default"
              @click="$emit('close')">Cancel</button>
      <button class="btn btn-primary"
              :disabled="newName===''"
              @click="onConfirmed"
      >OK</button>
    </div>
  </yoov-modal>
</template>

<script>
  import YoovModal from '@/components/Modal'

  export default {
    props: {
      oldName: {
        type: String,
        default: ''
      }
    },
    components: {
      'yoov-modal': YoovModal
    },
    computed: {
      user () {
        return this.$store.getters.user
      }
    },
    data () {
      return {
        newName: ''
      }
    },
    methods: {
      onConfirmed () {
        let vm = this
        this.$emit('ok', {
          newName: vm.newName
        })
      },
      markDisabled (folders, disabled) {
        if (typeof disabled === 'undefined') {
          disabled = false
        }
        let vm = this
        if (folders) {
          for (var i = 0; i < folders.length; i++) {
            folders[i].disabled = disabled || vm.disabledFolderIds.indexOf(folders[i].id) >= 0
            if (folders[i].children) {
              vm.markDisabled(folders[i].children, folders[i].disabled)
            }
          }
        }
        return folders
      },
      refreshUserAllFolders () {
        let vm = this
        let publicFolders = JSON.parse(JSON.stringify(vm.userAllFolders.publicFolders))
        let personalFolders = JSON.parse(JSON.stringify(vm.userAllFolders.personalFolders))
        let sharedFolders = JSON.parse(JSON.stringify(vm.userAllFolders.sharedFolders))
        vm.publicFolders = vm.markDisabled(publicFolders)
        vm.personalFolders = vm.markDisabled(personalFolders)
        vm.sharedFolders = vm.markDisabled(sharedFolders)

        // console.log('refreshUserAllFolders :: publicFolders:', vm.publicFolders)
        // console.log('refreshUserAllFolders :: personalFolders:', vm.personalFolders)
        // console.log('refreshUserAllFolders :: sharedFolders:', vm.sharedFolders)
      },
      async asyncLoad (node) {
        // method1:
        this.$refs.tree.addNodes(node, await this.$api.demo.getChild())
        // method2:
        // this.$set(node, 'loading', true)
        // let data = await this.$api.demo.getChild()
        // this.$set(node, 'children', data)
        // this.$set(node, 'loading', false)
        // method3: use concat
      },
      search () {
        this.$refs.tree.searchNodes(this.searchword)
      }
    }
  }
</script>

<style>
  #fileRenameDialog .tree-container {
    height: 400px;
    overflow-y: auto;
  }
  #fileRenameDialog span.node-disabled:hover {
    background-color: transparent;
  }
  #fileRenameDialog span.node-disabled:hover > span {
    background-color: transparent;
    cursor: default;
    color: lightgray;
  }

  #fileRenameDialog .node-disabled {
    cursor: default;
    color: lightgray;
  }

  .halo-tree .tree-close:after {
    padding-left: 1px;
  }
  .tree-node-el span.tree-open,
  .tree-node-el span.tree-close {
    line-height: 0.8;
  }

</style>