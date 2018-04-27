<template>
  <router-link tag="li"
               class="nav-item nav-dropdown"
               :to="url"
               disabled>
    <div class="nav-link nav-dropdown-toggle" @click="handleClick"><i :class="icon"></i>xxxxxx {{name}}</div>
    <ul class="nav-dropdown-items">
      <slot></slot>
    </ul>
  </router-link>
</template>

<script>
export default {
  props: {
    name: {
      type: String,
      default: ''
    },
    url: {
      type: String,
      default: ''
    },
    icon: {
      type: String,
      default: ''
    },
    activeMenuName: {
      type: String,
      default: ''
    }
  },
  methods: {
    closeAll () {
      let sidebar = document.getElementsByClassName('sidebar-nav')[0]
      console.log('closeAll :: sidebar: ', sidebar)

      let objsOpened = sidebar.getElementsByClassName('open')
      console.log('objsOpened: ', objsOpened)
//      let objsOpened = document.querySelectorAll('.sidebar-nav .open')
      console.log('closeAll :: objsOpened.length = ' + objsOpened.length)
      for (var i = 0; i < objsOpened.length; i++) {
        objsOpened[i].classList.remove('open')
      }
    },
    handleClick (e) {
      let vm = this
      e.preventDefault()

      let opened = e.target.parentElement.classList.contains('open')
      if (opened) {
        vm.closeAll()
      } else {
        vm.closeAll()
        e.target.parentElement.classList.toggle('open')
      }
    }
  }
}
</script>
