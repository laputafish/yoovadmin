<template>
    <div class="animated fadeIn">
        <div class="row">
            <div class="col-sm-5">
                <button @click="consoleData">consoleData</button>
                <app-tree :nodes="treeData"
                          @onCommand="commandHandler"></app-tree>
            </div>
            <div class="col-sm-7">
                <b-card>
                    <div class="b-card-title" style="position:absolute;">
                        <strong>{{ activeCategory.name }}</strong>
                        <small>(5)</small>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="button-group"
                                 style="position: relative;float: right;margin-left:5px;">
                                <button type="button"
                                        @click="newProduct"
                                        class="btn btn-success">
                                    <i class="fa fa-fw fa-plus"></i>
                                </button>
                                <!--<button type="button" class="btn btn-success">-->
                                    <!--<i class="fa fa-fw fa-plus"></i>-->
                                <!--</button>-->
                                <!--<button type="button" class="btn btn-success">-->
                                    <!--<i class="fa fa-fw fa-plus"></i>-->
                                <!--</button>-->
                            </div>
                            <datatable v-bind="$data">

                            </datatable>
                        </div>
                    </div>
                </b-card>
            </div>
        </div>
        <b-modal id="modal1" ref="itemModalRef" :title="(activeItemId==0 ? 'New' : 'Edit') + ' Item'" @ok="doUpdateItem">
            <div class="d-block form-group">
                <label>Name</label>
                <input v-model="activeItemName" class="form-control"/>
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
  import tdComps from './comps'
  import AppTree from '@/components/AppTree'
//  import mockData from '../custom/_mockData'
  // import SortableTree from 'vue-sortable-tree'
  export default {
    components: {
      ...tdComps,
      appTree: AppTree
    },
    name: 'hello',
    // components: {
    //   confirmationDialog: ConfirmationDialog
    // },
    data () {
      return {
        showingConfirmationDialog: false,
        // $parent: null,

        activeItem: null,
        activeItemId: 0,
        activeItemName: '',

        activeCategory: {
          type: Object,
          default: null
        },

        columns: [
          {title: '#', field: 'id', sortable: true},
          {title: '名稱', field: 'name', sortable: true},
          {title: '價格', field: 'price', tdComp: 'TdPrice', sortable: true, tdClass: 'text-right'}
        ],
        data: [],
        total: 0,
        query: {}
      }
    },
    computed: {
      treeData () {
        return this.$store.getters.categoryTree
      }
    },
    watch: {
      query: {
        handler (query) {
          this.reload({categoryId: this.activeCategoryId})
          // mockData(query).then(({ rows, total }) => {
          //   this.data = rows
          //   this.total = total
          // })
        },
        deep: true
      }
    },
    methods: {
      reload (options) {
        let vm = this
        this.data = this.$store.getters.productsByCategory(options.categoryId)
        this.total = this.data.length
        console.log('methods: reload: options: ', options)
        console.log('methods: reload: data: ', vm.data)
        console.log('methods: reload: total: ', vm.total)
      },
      showItem (item) {
        console.log('showItem :: item: ', item)
      },
      consoleData () {
        console.log(this.treeData)
      },
      // changePosition (payload) {
      //   let vm = this
      //
      //   let beforeParent = payload.beforeParent
      //   let afterParent = payload.afterParent
      //   let dataItem = payload.dataItem
      //   let targetIndex = payload.targetIndex
      //   let childrenAttr = payload.childrenAttr
      //   let originalIndex = beforeParent[childrenAttr].indexOf(dataItem)
      //   let dragToNode = payload.dragToNode
      //
      //   // remove original node
      //   beforeParent[childrenAttr].splice(originalIndex, 1)
      //
      //   if (dragToNode) {
      //     if (!afterParent[childrenAttr]) {
      //       afterParent[childrenAttr] = []
      //     }
      //     afterParent[childrenAttr].push(dataItem)
      //   } else {
      //     if (beforeParent === afterParent) {
      //       if (targetIndex > originalIndex) {
      //         afterParent[childrenAttr].splice(targetIndex, 0, dataItem)
      //       } else {
      //         afterParent[childrenAttr].splice(targetIndex - 1, 0, dataItem)
      //       }
      //     } else {
      //       afterParent[childrenAttr].splice(targetIndex, 0, dataItem)
      //     }
      //   }
      // },
      commandHandler (params) {
        console.log('commandHandler :: params: ', params)
        let command = params.command
        let payload = params.payload
        let vm = this
        switch (command) {
          case 'changeState':
            this.$set(payload.item, '$foldClose', !payload.item['$foldClose'])
            break
          case 'changeParent':
            console.log('SortableTree.vue :: before changePosition')
            this.$store.commit('REPOSITION_CATEGORY', payload.option)
            console.log('SortableTree.vue :: after changePosition')
            break
          case 'changePosition':
            vm.$store.dispatch('MOVE_PRODUCT_CATEGORY', payload)
            break
          case 'add':
            vm.addItem()
            break
          case 'edit':
            vm.editItem(payload.item)
            break
          case 'update':
            vm.updateItem(payload.item)
            break
          case 'delete':
            vm.deleteItem(payload.item)
            break
          case 'select':
            console.log('select :: payload: ', payload)
            vm.activeCategory = payload
            vm.reload({
              categoryId: vm.activeCategory.id
            })
            break
        }
      },

      // changeState (item) {
      //   this.$set(item, '$foldClose', !item['$foldClose'])
      // },
      // changePosition (option) {
      //   this.$store.commit('REPOSITION_CATEGORY', option)
      // },
      addItem (item) {
        this.activeItemId = 0
        this.activeItemName = ''
        this.activeItem = null
        this.$refs.itemModalRef.show()
      },
      doUpdateItem () {
        if (this.activeItem !== null) {
          this.activeItem.name = this.activeItemName
        }
      },
      editItem (item) {
        this.activeItem = item
        this.activeItemId = item.id
        this.activeItemName = item.name
        this.$refs.itemModalRef.show()
      },
      deleteItem (item) {
        let vm = this
        vm.showingConfirmationDialog = true
        console.log('deleteItem :: item: ', item)
        console.log('deleteItem :: showingConfirmationDialog = ' + (vm.showingConfirmationDialog ? 'yes' : 'no'))
      },
      newProduct () {
        alert('newProduct')
      }
    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="scss" scoped>

</style>
