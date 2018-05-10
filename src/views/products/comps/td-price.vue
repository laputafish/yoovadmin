<template>
  <div>
    {{ price }}
  </div>
</template>

<script>
  // import { EventBus } from '../../../event-bus.js'

  export default {
    data () {
      return {
        selectedRequestId: 0,
        selectedCandidateId: 0
      }
    },
    props: ['row', 'nested'],
    mounted () {

    },
    computed: {
      price () {
        return this.formatCurrency(this.row.price)
      }
    }
  }
</script>
