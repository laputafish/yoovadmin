<template>
  <b-dropdown-header v-if="menuItem.type==='header'" tag="div" class="text-center">
    <strong>{{ menuItem.title }}</strong>
  </b-dropdown-header>

  <b-dropdown-item v-else-if="menuItem.link" :to="menuItem.link">
    <i class="fa" :class="menuItem.icon"></i>
    <span>
      {{ menuItem.title }}
    </span>
    <span v-if="menuItem.badgeNo" class="badge" :class="menuItem.badgeClass">{{ menuItem.badgeNo }}</span>
  </b-dropdown-item>
  <b-dropdown-item v-else @click="processCommand(menuItem.command)">
    <i class="fa" :class="menuItem.icon"></i>
    <span>
      {{ menuItem.title }}
    </span>
    <span v-if="menuItem.badgeNo" class="badge" :class="menuItem.badgeClass">{{ menuItem.badgeNo }}</span>
  </b-dropdown-item>
</template>

<script>
export default {
  name: 'MyDropdownItem',
  props: {
    menuItem: {
      type: Object,
      default: null
    }
  },
  methods: {
    processCommand (command) {
      let vm = this
      switch (command) {
        case 'logout':
          let promises = [
            vm.$store.dispatch('SET_TOKEN', null),
            vm.$store.dispatch('SET_USER', {user: null})
          ]
          Promise.all(promises).then(function (response) {
            vm.$router.push('/pages/login')
          })
          break
      }
    }
  }
}
</script>

<style>
  .no-anchor-style {
    color: #212529;
    text-decoration: none;
  }
  .no-anchor-style:hover {
    color: #212529;
    text-decoration: none;
  }
</style>