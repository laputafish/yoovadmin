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
      <b-nav-item class="px-3" :to="'/pages/header_page1'">Page 1</b-nav-item>
      <b-nav-item class="px-3" :to="'/pages/header_page2'">Page 2</b-nav-item>
      <b-nav-item class="px-3" :to="'/pages/header_page3'">Page 3</b-nav-item>
    </b-nav>
    <b-nav is-nav-bar class="ml-auto">
      <b-nav-item :href="'http://google.com'" class="d-md-down-none">
        <i class="icon-bell"></i><span class="badge badge-pill badge-danger">5</span>
      </b-nav-item>
      <b-nav-item class="d-md-down-none">
        <i class="icon-list"></i>
      </b-nav-item>
      <b-nav-item class="d-md-down-none">
        <i class="icon-location-pin"></i>
      </b-nav-item>
      <b-nav-item-dropdown right>
        <template slot="button-content">
          <img src="/static/img/avatars/6.jpg" class="img-avatar" alt="admin@bootstrapmaster.com">
          <span class="d-md-down-none">admin</span>
        </template>
        <my-dropdown-item
          :menuItem="menuItem"
          v-for="(menuItem,index) in transformedMenu"
          v-bind:key="index">
        </my-dropdown-item>
      </b-nav-item-dropdown>
      <button class="navbar-toggler aside-menu-toggler d-md-down-none" type="button" @click="asideToggle">&#9776;</button>
    </b-nav>
  </header>
</template>

<script>
import MyDropdownItem from './MyDropdownItem.vue'

// import MyDropdownItem from './MyDropdownItem.vue'
export default {
  components: {
    myDropdownItem: MyDropdownItem
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
  computed: {
    transformedMenu () {
      let result = []
      for (var i = 0; i < this.userMenu.length; i++) {
        let menu = this.userMenu[i]
        result.push({
          type: 'header',
          title: menu.sectionTitle
        })
        let items = menu.menuItems
        for (var j = 0; j < items.length; j++) {
          result.push(Object.assign({type: 'item'}, items[j]))
        }
      }
      return result
    }
  },
  data () {
    return {
      userMenu: [
        {
          sectionTitle: 'Account',
          menuItems: [
            {icon: 'fa-bell-o', title: 'Updates', badgeClass: 'badge-info', badgeNo: 42},
            {icon: 'fa-envelope-o', title: 'Messages', badgeClass: 'badge-success', badgeNo: 42},
            {icon: 'fa-tasks', title: 'Tasks', badgeClass: 'badge-danger', badgeNo: 42},
            {icon: 'fa-comments', title: 'Comments', badgeClass: 'badge-warning', badgeNo: 42}
          ]
        },
        {
          sectionTitle: 'Settings',
          menuItems: [
            {icon: 'fa-user', title: 'Profile'},
            {icon: 'fa-wrench', title: 'Settings'},
            {icon: 'fa-usd', title: 'Payments'},
            {icon: 'fa-file', title: 'Projects'}
          ]
        },
        {
          sectionTitle: 'System',
          menuItems: [
            {icon: 'fa-shield', title: 'Lock Account'},
            {icon: 'fa-lock', title: 'Logout'}
          ]
        }
      ]
    }
  }
}
</script>
