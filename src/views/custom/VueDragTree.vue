<template>
    <vue-drag-tree :model='data' :current-highlight='true' :default-text='"New A Girl"' :hover-color='"lightblue"'
                   :highlight-color='"green"'></vue-drag-tree>
</template>
<script>
  export default {
    data () {
      return {
        data: {
          name: 'Root',
          id: 0,
          children: [
            {
              name: 'Node 1-1',
              id: 1,
              children: [
                {
                  name: 'Node 2-1',
                  id: 2
                }
              ]
            },
            {
              name: 'Node 1-2',
              id: 3
            }
          ]
        }
      }
    },
    methods: {
      assignData (data) {
        // data is a json object that node infomation was exchanged inside.You need to assign to finish the last step of exchange.

        // If you have not use vuex or something similar, you can just assign data to this.data
        this.data = data

        // If you have used vuex or something similar, you need to write assign code by yourselft.
        // vuex as an example:
        // updateData function is a mutation of vuex.

        // this.updateData(data)
      },
      curNodeClicked (model, component) {
        // information of the node clicked just now.
      }
    }
  }
</script>