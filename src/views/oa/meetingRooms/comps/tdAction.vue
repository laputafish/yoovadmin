<template>
  <div>
    <button type="button"
            class="btn btn-danger btn-sm">
      <i class="fa fa-fw fa-close"></i>
    </button>
  </div>
</template>

<script>
  export default {
    props: ['row', 'nested']
  }
</script>