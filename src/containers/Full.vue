<template>
  <div class="app">
    <app-header
      :user="user"/>
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
  mounted () {
    console.log('mounted')
    let vm = this
    vm.$nextTick(function () {
      vm.$store.dispatch('checkToken', {
        callback: function (status) {
          console.log('checkToken :: token = ' + vm.$store.getters.token)
          if (status) {
            console.log('if status')
          } else {
            console.log('if not status')
            vm.$router.push({name: 'Login'})
          }
        }
      })
    })
  },
  computed: {
    token () {
      return this.$store.getters.token
    },
    name () {
      return 'name not specified' // his.$route.name
    },
    list () {
      return this.$route.matched
    },
    user () {
      return this.$store.getters.user
    }
  }
}
</script>
