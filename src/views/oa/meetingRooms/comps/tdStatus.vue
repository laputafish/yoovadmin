<template>
  <div>
    <span v-if="row.status==='vacant'">Vacant</span>
    <span v-else>Occupied</span>
  </div>
</template>

<script>
  export default {
    props: ['row', 'nested']
  }
</script>