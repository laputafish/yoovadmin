<template>
    <yoov-modal id="folderTreeDialog">
        <div slot="header">
            <h3 class="dialog-title">
                Select Timeline
            </h3>
        </div>
        <div slot="body" class="yoov-modal-body">
            <div class="d-flex d-row">
                <button class="flex-grow-1"
                    :class="{'btn-primary':activeTab=='personal'}"
                    @click="activeTab='personal'">
                    Personal
                </button>
                <button class="flex-grow-1"
                        :class="{'btn-primary':activeTab=='public'}"
                        @click="activeTab='public'">
                    Public
                </button>
                <button class="flex-grow-1"
                        :class="{'btn-primary':activeTab=='shared'}"
                        @click="activeTab='shared'">
                    Shared
                </button>
            </div>
            <div class="tree-container" v-if="activeTab==='personal'">
                <v-tree ref='tree' :data='personalFolders' :tpl='tpl' :halfcheck='true'/>
            </div>
            <div class="tree-container" v-else-if="activeTab==='public'">
                <v-tree ref='tree' :data='publicFolders' :tpl='tpl' :halfcheck='true'/>
            </div>
            <div class="tree-container" v-else>
                <v-tree ref='tree' :data='sharedFolders' :tpl='tpl' :halfcheck='true'/>
            </div>
            <!--<input type="text" v-model="searchword"/>-->
            <!--<button type="button" @click="search">GO</button>-->
        </div>
        <div slot="footer" style="width:100%;" class="mt-0 pt-0">
            <button class="btn btn-default" @click="$emit('close')">Cancel</button>
            <button class="btn btn-primary">OK</button>
        </div>
    </yoov-modal>
</template>

<script>
  import YoovModal from '@/components/Modal'

  export default {
    props: {
      disableNodeId: 0
    },
    components: {
      'yoov-modal': YoovModal
    },
    computed: {
      userAllFolders () {
        return this.$store.getters.userAllFolders
      },
      user () {
        return this.$store.getters.user
      }
    },
    created () {
      this.$store.dispatch('GET_USER_ALL_FOLDERS', this.user.id)
    },
    mounted () {
      this.refreshUserAllFolders()
    },
    watch: {
      userAllFolders: {
        handler: function (value) {
          this.refreshUserAllFolders()
        },
        deep: true
      }
    },
    data () {
      return {
        activeTab: 'personal',
        searchword: '',
        personalFolders: [],
        publicFolders: [],
        sharedFolders: [],
        treeData: [{
          name: 'node1',
          expanded: true,
          children: [{
            name: 'node 1-1',
            expanded: true,
            children: [{
              name: 'node 1-1-1'
            }, {
              name: 'node 1-1-2'
            }, {
              name: 'node 1-1-3'
            }]
          }, {
            name: 'node 1-2',
            children: [{
              name: "<span style='color: red'>node 1-2-1</span>"
            }, {
              name: "<span style='color: red'>node 1-2-2</span>"
            }]
          }]
        }]
      }
    },
    methods: {
      refreshUserAllFolders () {
        let vm = this
        vm.publicFolders = vm.userAllFolders.publicFolders
        vm.personalFolders = vm.userAllFolders.personalFolders
        vm.sharedFolders = vm.userAllFolders.sharedFolders
        console.log('refreshUserAllFolders :: publicFolders:', vm.publicFolders)
        console.log('refreshUserAllFolders :: personalFolders:', vm.personalFolders)
        console.log('refreshUserAllFolders :: sharedFolders:', vm.sharedFolders)
      },
      tpl (node, ctx) {
        let titleClass = node.selected ? 'node-title node-selected bg-primary' : 'node-title'
        if (node.searched) titleClass += ' node-searched'
        return <span>
        <span class={titleClass} domPropsInnerHTML={node.name} onClick={() => {
          ctx.parent.nodeSelected(ctx.props.node)
          console.log(ctx.parent.getSelectedNodes())
        }}></span>
        </span>
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
    #folderTreeDialog .tree-container {
        height: 400px;
        overflow-y: auto;
    }
</style>