<template>
  <div class="app">
    <app-header />
    <div class="app-body">
      <sidebar :navItems="nav"/>
      <main class="main">
        <breadcrumb :list="list"/>
        <div class="container-fluid">
          <router-view></router-view>
        </div>
      </main>
      <app-aside/>
    </div>
    <app-footer/>
  </div>
</template>

<script>
import nav from '../_nav'
import {
  AppHeader as appHeader,
  AppSidebar as sidebar,
  AppAside as appAside,
  AppFooter as appFooter} from '../components/index.js'
import Breadcrumb from '../components/Breadcrumb.vue'

export default {
  name: 'full',
  components: {
    appHeader,
    sidebar,
    appAside,
    appFooter,
    breadcrumb: Breadcrumb
  },
  data () {
    return {
      nav: nav.items
    }
  },
  computed: {
    name () {
      return 'name not specified' // his.$route.name
    },
    list () {
      return this.$route.matched
    }
  }
}
</script>
