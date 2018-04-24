<template>
    <div class="animated fadeIn">
        <div class="row">
            <div class="col-sm-5">
                <v-tree ref='tree'
                        :draggable='draggable'
                        :data='treeData'
                        :multiple='true'
                        :tpl='tpl'
                        @node-click="onNodeClick(node)"
                        :halfcheck='true'/>
            </div>
            <div class="col-sm-4">
                <div v-if="lastNodeSelected">
                Title
                <input v-model="lastNodeSelected.title" class="form-control"/>
                </div>
            </div>
            <div class="col-sm-3">
{{ lastNodeSelected }}
            </div>
        </div>
        <input type="text" v-model="searchword" />
        <button type="button" @click="search">GO</button>
    </div>
</template>

<script>
  export default {
    name: 'vue-tree',
    data () {
      return {
        lastNodeSelected: null,
        draggable: true,
        searchword: '',
        treeData: [{
          title: 'node1',
          expanded: true,
          children: [{
            title: 'node 1-1',
            expanded: true,
            children: [{
              title: 'node 1-1-1'
            }, {
              title: 'node 1-1-2'
            }, {
              title: 'node 1-1-3'
            }]
          }, {
            title: 'node 1-2',
            children: [{
              title: "<span style='color: red'>node 1-2-1</span>"
            }, {
              title: "<span style='color: red'>node 1-2-2</span>"
            }]
          }]
        }]
      }
    },
    methods: {
      onNodeClicked (node) {
        console.log('onNodeClicked :: node: ', node)
      },
      /*
      <div class='btn btn-xs btn-default' onClick={() => {
          ctx.parent.nodeSelected(ctx.props.node)
          console.log(ctx.parent.getSelectedNodes())
        }}>
            <i class='fa fa-fw fa-arrows'></i>
        </div>
       */
      tpl (node, ctx) {
        let titleClass = node.selected ? 'node-title node-selected' : 'node-title'
        if (node.searched) {
          titleClass += ' node-searched'
        }
        return <span>
        <span class={titleClass} domPropsInnerHTML={node.title}></span>
        <button style='display:none;color:green; background-color:pink' onClick={() => this.asyncLoad(node)}>async loading</button>
        <button class='btn btn-xs btn-success' onClick={() => this.$refs.tree.addNode(node, {title: 'sync loading'})}>
            <i class='fa fa-fw fa-plus'></i>
        </button>
        <button class='btn btn-xs btn-danger' onClick={() => this.$refs.tree.delNode(node.parent, node)}>
            <i class='fa fa-fw fa-close'></i>
        </button>
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

<style scoped>
    @import url(https://fonts.googleapis.com/css?family=Tangerine|Open+Sans:300);

    .main {
        display: flex;
        flex-direction: column;
        font-size: 35px;
        align-items: center;
    }

    .sentence {
        background-color: #D3DCE6;
        margin-top: 2rem;
        width: 50%;
        padding: 1rem;
        font-size: 25px;
    }

    .senMain {
        background-color: white;
        padding: 1rem;
        color: #8492A6;
    }

    .lang {
        font-size: 20px;
        color: #8492A6;
        font-weight: bold;
    }

    ul {
        margin-left: 1rem;
    }

    .container {
        width: 60%;
        display: flex;
        margin-top: 2rem;
        justify-content: space-between;
        padding: 0 5rem;
    }

    .treeSelf {
        border: 3px solid #E5E9F2;
        color: white;
        width: 40%;
        text-align: left;
        padding: 1rem;
    }

    .showSec {
        border: 3px solid #E5E9F2;
        width: 40%;
        text-align: left;
        padding: 1rem;
        font-size: 15px;
    }

    .howtouse {
        text-align: center;
        width: 30%;
        background-color: #E5E9F2;
        margin-top: 1rem;
        padding: 1rem;
        font-size: 50px;
        font-weight: bold;
    }

    .howtouse > div {
        font-family: 'Tangerine';
        font-size: 5rem;
    }

    .getstart > div {
        background-color: #D3DCE6;
        padding: 0.5rem 1rem;
    }

    .getstart > p {
        margin: 0.5rem 0;
    }

    a {
        color: black;
    }
</style>

<style>
    .tree-view-item-key {
        font-size: 20px;
        color: black;
    }

    .tree-view-item-value {
        font-size: 20px;
        font-weight: bold;
        color: white;
    }

    .btn-xs,
    btn-group-xs > .btn {
        padding: 0.1rem 0.2rem;
        font-size: 0.875rem;
        line-height: 1;
        border-radius: 0.3rem;
        margin-right:1px;
        margin-top: -4px;
    }

    .a .btn-xs .btn-group-xs > .btn {
        padding: 0.25rem 0.5rem;
        font-size: 0.875rem;
        line-height: 1.5;
        border-radius: 0.2rem;
    }

    .halo-tree .tree-close,
    .halo-tree .tree-open {
        line-height: 8px;
    }

    .halo-tree .tree-close:after,
    .halo-tree .tree-open:after {
        line-height: 0.7;
    }

    .halo-tree .inputCheck {
        top: 3px;
    }

    .halo-tree .node-selected {
        border: 2px solid #ddd;
        background-color: lightblue;
    }
</style>