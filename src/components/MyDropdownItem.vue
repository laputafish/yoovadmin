<template>
  <b-dropdown-header v-if="menuItem.type==='header'" tag="div" class="text-center">
    <strong>{{ menuItem.title }}</strong>
  </b-dropdown-header>
  <b-dropdown-item v-else>
    <i class="fa" :class="menuItem.icon"></i>
    {{ menuItem.title }}
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
  }
}
</script>
