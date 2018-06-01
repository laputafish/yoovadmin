<template>
<div>
  <div class="inline" v-for="(ancestor, index) in ancestors">
    <span v-if="index!==0">&nbsp;
      /&nbsp;</span>
    <a class="no-text-decoration" v-if="index<ancestors.length-1" :href="'/folders/' + ancestor.id">
      <i class="fa fa-folder"></i>
      {{ ancestor.description }}
    </a>
    <span v-else>
      <i class="fa fa-folder"></i>
      {{ ancestor.description }}
    </span>
  </div>
</div>
</template>

<script>
  export default {
    props: {
      ancestors: {
        type: Array,
        default () {
          return []
        }
      }
    }
  }
</script>

<style>
  .inline {
    display: inline-block;
  }
</style>