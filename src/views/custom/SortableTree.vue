<template>
  <div class="animated fadeIn">
    <div class="row">
      <div class="col-sm-4">
        <button @click="consoleData">consoleData</button>
        <div class="tree-container">
          <sortable-tree :data="treeData"
                         mixinParentKey="$parent"
                         @changePosition="changePosition" :dragEnable="true"
                         closeStateKey="$foldClose">
            <template slot-scope="{item}">
              <div class="custom-tree-content" :class="{'exitChild': item.children && item.children.length}">
                <!--<span>▶</span>-->
                <span v-if="item['$foldClose'] && item.children && item.children.length"
                      @click="changeState(item)"><i class="fa fa-fw fa-chevron-circle-right"></i></span>
                <!--<span>▼</span>-->
                <span v-else-if="!item['$foldClose'] && item.children && item.children.length"
                      @click="changeState(item)"><i class="fa fa-fw fa-chevron-circle-down"></i></span>
                <span>{{item.name}}</span>
                <div class="treenode-toolbar">
                  <button class="btn btn-xs btn-primary"
                          @click="editItem(item)">
                    <i class="fa fa-fw fa-edit"></i>
                  </button>
                  <button class="btn btn-xs btn-success"
                          @click="addItem(item)">
                    <i class="fa fa-fw fa-plus"></i>
                  </button>
                  <button
                      :disabled="item.name==='root'"
                      @click="deleteItem(item)"
                      :class="{'btn-default':item.name==='root', 'btn-danger':item.name!=='root'}"
                      class="btn btn-xs">
                    <i class="fa fa-fw fa-close"></i>
                  </button>
                </div>
              </div>
            </template>
          </sortable-tree>
        </div>
      </div>
      <div class="col-sm-4">

      </div>
      <div class="col-sm-4">

      </div>
    </div>
    <b-modal id="modal1" ref="newItemModalRef" title="New Item" @ok="doAddItem">
      <div class="d-block form-group">
        <label>Name</label>
        <input v-model="newItemName" class="form-control"/>
      </div>
    </b-modal>
    <b-modal v-model="showingConfirmationDialog" title="Confirmation" @ok="$emit('ok')"
             ok-variant="danger">
      <div class="d-block text-center">
        Are you sure?
      </div>
    </b-modal>

    <!--<confirmation-dialog v-model="showingConfirmationDialog">-->
    <!--</confirmation-dialog>-->
  </div>
</template>
<script>
  // import ConfirmationDialog from '../shared/dialogs/ConfirmationDialog'

  // import SortableTree from 'vue-sortable-tree'
  export default {
    name: 'hello',
    // components: {
    //   confirmationDialog: ConfirmationDialog
    // },
    data () {
      return {
        showingConfirmationDialog: false,
        $parent: null,
        newItemName: ''
      }
    },
    computed: {
      treeData () {
        return this.$store.getters.categoryTree
      }
    },
    methods: {
      showItem (item) {
        console.log('showItem :: item: ', item)
      },
      consoleData () {
        console.log(this.treeData)
      },
      changeState (item) {
        this.$set(item, '$foldClose', !item['$foldClose'])
      },
      changePosition (option) {
        this.$store.commit('REPOSITION_CATEGORY', option)
      },
      addItem (item) {
        this.$refs.newItemModalRef.show()
      },
      doAddItem () {
        alert('new name = ' + this.newItemName)
      },
      editItem (item) {
        console.log('editITem :: item: ', item)
      },
      deleteItem (item) {
        let vm = this
        vm.showingConfirmationDialog = true
        console.log('deleteItem :: item: ', item)
        console.log('deleteItem :: showingConfirmationDialog = ' + (vm.showingConfirmationDialog ? 'yes' : 'no'))
      }
    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="scss" scoped>
  .tree-container {
    padding-left: 20px;
  }

  .btn.btn-xs {
    padding: 0.15rem 0.2rem;
    font-size: 0.875rem;
    line-height: 1;
    border-radius: 0.2rem;
  }

  .custom-tree-content {
    position: relative;
    top: 2px;
    z-index: 1;
    &.exitChild {
      margin-left: -7px;
    }
  }

  .treenode-toolbar button {
    margin-right: 1px;
  }

  .custom-tree-content .treenode-toolbar {
    display: inline-block;
    visibility: hidden;
  }

  .custom-tree-content:hover .treenode-toolbar {
    visibility: visible;
  }

  .custom-tree-content > span > i {
    margin-left: -3px;
    margin-top: 1px;
    background-color: white;
    font-size: 18px;
  }
</style>