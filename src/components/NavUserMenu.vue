<template>
  <b-nav-item-dropdown right class="nav-user-menu">
    <template slot="button-content">
      <h3 style="display:inline-block;"><i class="fa fa-user"></i>&nbsp;</h3>
      <!--<img src="/static/img/avatars/6.jpg" class="img-avatar" alt="admin@bootstrapmaster.com">-->
      <div class="user-name d-md-down-none">{{ user ? user.name : '' }}</div>
    </template>
    <my-dropdown-item
      :menuItem="menuItem"
      v-for="(menuItem,index) in transformedUserMenu"
      v-bind:key="index">
    </my-dropdown-item>
  </b-nav-item-dropdown>
</template>

<script>
  import MyDropdownItem from './MyDropdownItem.vue'

  import userMenu from '@/_user_menu.js'

  export default {
    components: {
      myDropdownItem: MyDropdownItem
    },
    data () {
      return {
        userMenuItems: userMenu.items
      }
    },
    props: {
      user: {
        type: Object,
        default: null
      }
    },
    computed: {
      transformedUserMenu () {
        let result = []
        for (var i = 0; i < this.userMenuItems.length; i++) {
          let menu = this.userMenuItems[i]
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
    }
  }
</script>

<style>
.nav-user-menu .user-name {
  font-size: 14px;
  display: inline-block;
  vertical-align:top;
  padding-top:8px;
}
</style>
