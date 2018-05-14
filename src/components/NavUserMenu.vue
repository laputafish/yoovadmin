<template>
  <b-nav-item-dropdown right>
    <template slot="button-content">
      <img src="/static/img/avatars/6.jpg" class="img-avatar" alt="admin@bootstrapmaster.com">
      <span class="d-md-down-none">{{ user ? user.name : '' }}</span>
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

</style>
