//
// vue-tree
// added:
// babel-plugin-syntax-jsx
// babel-plugin-transform-vue-jsx
// babel-helper-vue-jsx-merge-props

// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import $ from 'jquery'
import Vue from 'vue'
// import 'vue-tree-halower/dist/halower-tree.min.css'
// import VTree from 'vue-tree-halower'
import LiquorTree from 'liquor-tree'
import VueDraggable from 'vue-draggable'
import Datatable from 'vue2-datatable-component'
import customLocale from 'vue2-datatable-component/locale/custom'

// import VueDraggableTree from 'vue-draggable-tree'

// import VueDragTree from 'vue-drag-tree'
import SortableTree from 'vue-sortable-tree'

import { store } from './store/store'
import 'bootstrap'
import BootstrapVue from 'bootstrap-vue/dist/bootstrap-vue.esm'
// import {Carousel} from 'bootstrap-vue/es/components'
import App from './App'
import router from './router'
import VTooltip from 'v-tooltip'
// import jQuery from 'jquery'
//
import 'font-awesome/scss/font-awesome.scss'
import 'simple-line-icons/scss/simple-line-icons.scss'
// import 'bootstrap/dist/css/bootstrap.css'
// import 'bootstrap-vue/dist/bootstrap-vue.css'

// window.jQuery = jQuery
// window.$ = jQuery

window.$ = $
window.jQuery = $

Vue.use(BootstrapVue)
// Vue.directive('tooltip', VTooltip)
Vue.use(VTooltip)
Vue.use(LiquorTree)
Vue.use(VueDraggable)
Vue.use(Datatable, {customLocale})
// Vue.use(VTree)
// Vue.use(Carousel)
// Vue.component('vue-drag-tree', VueDragTree)
Vue.component(SortableTree.name, SortableTree)
Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  template: '<App/>',
  components: { App }
})
