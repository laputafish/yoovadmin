<template>
    <div class="d-flex flex-grow-1 flex-row align-items-stretch justify-content-around animated fadeIn"
         style="height:100%;">
        <div class="d-flex p-2 flex-column flex-grow-0 bg-default" style="width:400px;">
            <panel-toolbar
                :buttons="buttons"
                v-model="activePane">
            </panel-toolbar>
            <order-pane :order="activeOrder"></order-pane>
        </div>
        <table-map-pane>

        </table-map-pane>
        <product-category-pane>
        </product-category-pane>
        <product-list-pane>
        </product-list-pane>
    </div>
</template>

<script>
  import OrderPane from './components/OrderPane'
  import ProductCategoryPane from './components/ProductCategoryPane'
  import ProductListPane from './components/ProductListPane'
  import PanelToolbar from './components/PanelToolbar'

  export default {
    data () {
      return {
        activeOrder: {},
        activePane: 'tablePane',
        buttons: [
          {
            label: 'Order',
            iconClass: 'icon-film icons',
            pane: 'orderPane'
          },
          {
            label: 'Tables',
            iconClass: 'icon-grid icons',
            pane: 'tablePane'
          }
        ]
      }
    },
    components: {
      orderPane: OrderPane,
      productCategoryPane: ProductCategoryPane,
      productListPane: ProductListPane,
      panelToolbar: PanelToolbar
    },
    computed: {
      products () {
        return this.$store.state.products
      }
    },
    mounted () {

    }
  }
</script>

<style>

</style>
