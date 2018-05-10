<template>
    <div class="tree-container">
        <sortable-tree :data="nodes"
                       mixinParentKey="$parent"
                       @changeParent="changeParentHandler" :dragEnable="true"
                       @changePosition="changePositionHandler"
                       closeStateKey="$foldClose">
            <template slot-scope="{item}">
                <div class="custom-tree-content"
                      :class="{'exitChild': item.children && item.children.length}">
                    <!--<span>▶</span>-->
                    <span v-if="item['$foldClose'] && item.children && item.children.length"
                          @click="changeState(item)"><i class="fa fa-fw fa-chevron-circle-right"></i></span>
                    <!--<span>▼</span>-->
                    <span v-else-if="!item['$foldClose'] && item.children && item.children.length"
                          @click="changeState(item)"><i class="fa fa-fw fa-chevron-circle-down"></i></span>
                    <span class="category-title" @click="select(item)">{{item.name}} #{{item.id}}</span>
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
</template>

<script>
  export default {
    data () {
      return {
        $parent: null
      }
    },
    props: {
      nodes: {
        type: Object,
        default () {
          return {
            id: 0,
            name: '主目錄',
            children: []
          }
        }
      }
    },
    methods: {
      addItem (item) {
        this.$emit('onCommand', {
          command: 'add',
          payload: {item: item}
        })
      },
      editItem (item) {
        this.$emit('onCommand', {
          command: 'edit',
          payload: {item: item}
        })
      },
      deleteItem (item) {
        this.$emit('onCommand', {
          command: 'delete',
          payload: {item: item}
        })
      },
      changeState (item) {
        this.$emit('onCommand', {
          command: 'changeState',
          payload: {item: item}
        })
//          this.$set(item, '$foldClose', !item['$foldClose'])
      },
      changeParentHandler (option) {
        this.$emit('onCommand', {
          command: 'changeParent',
          payload: {option: option}
        })
      },
      changePositionHandler (payload) {
        console.log('AppTree.vue :: changePosition => onCommand(changePosition')
        this.$emit('onCommand', {
          command: 'changePosition',
          payload: payload
        })
      },
      select (item) {
        this.$emit('onCommand', {
          command: 'select',
          payload: item
        })
      },
      newProduct () {
        alert('newProduct')
      }
    }
  }
</script>

<style lang="scss" scoped>
    .tree-container {
        padding-left: 20px;
    }

    .tree-container .btn.btn-xs {
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
    .category-title {
        cursor: pointer;
    }
</style>