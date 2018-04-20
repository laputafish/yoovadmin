// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import BootstrapVue from 'bootstrap-vue/dist/bootstrap-vue.esm'
// import {Carousel} from 'bootstrap-vue/es/components'
import App from './App'
import router from './router'
import $ from 'jquery'
import VTooltip from 'v-tooltip'
// import jQuery from 'jquery'
//
import 'font-awesome/scss/font-awesome.scss'
import 'simple-line-icons/scss/simple-line-icons.scss'
// import 'bootstrap/dist/css/bootstrap.css'
// import 'bootstrap-vue/dist/bootstrap-vue.css'

import 'bootstrap'

// window.jQuery = jQuery
// window.$ = jQuery

window.$ = $
window.jQuery = $

Vue.use(BootstrapVue)
// Vue.directive('tooltip', VTooltip)
Vue.use(VTooltip)
// Vue.use(Carousel)

Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  template: '<App/>',
  components: { App }
})
