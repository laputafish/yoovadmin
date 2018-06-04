<template>
  <div class="app"
    :class="{'mobile':isMobile}">
    <app-header
      :user="user"/>
    <div class="app-body">
      <sidebar :navItems="nav"/>
      <main class="main">
        <breadcrumb :list="list" class="mb-xs-1 mb-sm-3"/>
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
  created () {
    console.log('Full.vue created starts')
    let vm = this
    vm.$store.dispatch('checkToken', {
      callback: function (status) {
        console.log('checkToken :: token = ' + vm.$store.getters.token.substr(0, 10))
        if (status) {
          console.log('if status')
        } else {
          console.log('if not status')
          vm.$router.push({name: 'Login'})
        }
      }
    })
  },
  computed: {
    isMobile () {
      return this.$mq === 'mobile'
    },
    token () {
      return this.$store.getters.token
    },
    name () {
      return 'name not specified' // his.$route.name
    },
    list () {
      console.log('Full :: list: ', this.$route.matched)
      return this.$route.matched
    },
    user () {
      return this.$store.getters.user
    }
  }
}
</script>

<style>
  .app.mobile .app-footer {
    font-size: 14px;
  }
</style>