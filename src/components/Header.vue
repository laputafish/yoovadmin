<template>
  <header class="app-header navbar">
    <button
      class="navbar-toggler mobile-sidebar-toggler d-lg-none"
      type="button"
      @click="mobileSidebarToggle">&#9776;
    </button>
    <b-link class="navbar-brand" to="#"></b-link>
    <button
      class="navbar-toggler sidebar-toggler d-md-down-none"
      type="button"
      @click="sidebarMinimize">&#9776;
    </button>
    <b-nav is-nav-bar class="d-md-down-none">
      <b-nav-item class="px-3"
                  v-for="(item, index) in topMenuItems"
                  v-bind:key="index"
                  :to="item.link">
        {{ item.caption }}
      </b-nav-item>
      <!--<b-nav-item class="px-3" :to="'/pages/header_page2'">Page 2</b-nav-item>-->
      <!--<b-nav-item class="px-3" :to="'/pages/header_page3'">Page 3</b-nav-item>-->
    </b-nav>
    <b-nav id="top-right-menu" is-nav-bar class="ml-auto">
      <!--<b-nav-item :href="'http://google.com'" class="d-md-down-none">-->
        <!--<i class="icon-bell"></i><span class="badge badge-pill badge-danger">5</span>-->
      <!--</b-nav-item>-->
      <!--<b-nav-item class="d-md-down-none">-->
        <!--<i class="icon-list"></i>-->
      <!--</b-nav-item>-->
      <!--<b-nav-item class="d-md-down-none">-->
        <!--<i class="icon-location-pin"></i>-->
      <!--</b-nav-item>-->
      <nav-user-menu right
        :user="user">
      </nav-user-menu>
      <button disabled class="navbar-toggler aside-menu-toggler d-md-down-none" type="button" @click="asideToggle">&#9776;</button>
    </b-nav>
  </header>
</template>

<script>
import NavUserMenu from '@/components/NavUserMenu'
import topMenu from '@/_top_menu.js'

// import MyDropdownItem from './MyDropdownItem.vue'
export default {
  components: {
    navUserMenu: NavUserMenu
  },
  name: 'app-header',
  methods: {
    sidebarToggle (e) {
      e.preventDefault()
      document.body.classList.toggle('sidebar-hidden')
    },
    sidebarMinimize (e) {
      e.preventDefault()
      document.body.classList.toggle('sidebar-minimized')
    },
    mobileSidebarToggle (e) {
      e.preventDefault()
      document.body.classList.toggle('sidebar-mobile-show')
    },
    asideToggle (e) {
      e.preventDefault()
      document.body.classList.toggle('aside-menu-hidden')
    }
  },
  data () {
    return {
      topMenuItems: topMenu.items

    }
  },
  props: {
    user: {
      type: Object,
      default () {
        return null
      }
    }
  }
}
</script>
<style>
  #top-right-menu li {
    /*display: none;*/
  }
  #top-right-menu button {
    /*display: none;*/
  }
  .navbar-toggler,
  .navbar-toggler:hover,
  .navbar-toggler:active,
  .navbar-toggler:focus {
    border: none !important;
    outline: 5px auto transparent;
  }
  .navbar-toggler:hover {
    color: black;
  }
</style>
