<template>
<div>
  <div class="inline" v-for="(ancestor, index) in ancestors">
    <span v-if="index!==0">&nbsp;/&nbsp;</span>
    <i class="fa fa-folder"></i>
    <a v-if="index<ancestors.length-1" :href="'/folders/' + ancestor.id">{{ ancestor.description }}</a>
    <span v-else>{{ ancestor.description }}</span>
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
