<template>
  <div class="input-group">
    <input type="text"
           name="q"
           class="form-control"
           placeholder="Search..."
           v-model="value">
    <span class="input-group-btn">
      <button type="button"
              @click="startSearch"
              name="search"
              id="search-btn"
              class="btn btn-flat">
        <i class="fa fa-search"></i>
      </button>
    </span>
  </div>

</template>

<script>
export default {
  data () {
    return {
      value: ''
    }
  },
  methods: {
    startSearch () {
      this.$emit('search', this.value)
    }
  }
}
</script>

<style>

</style>
