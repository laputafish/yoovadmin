<template>
  <div class="animated fadeIn">
    <div class="container-fluid">
      <div class="d-flex flex-column-reverse flex-sm-row">
        <yoov-room-booking></yoov-room-booking>
        <yoov-scanner-box v-if="false"></yoov-scanner-box>
      </div>
    </div>
  </div>
</template>

<script>
  import YoovScannerBox from '@/components/YoovScannerBox'
  import YoovRoomBooking from '@/components/YoovRoomBooking'

  export default {
    components: {
      'yoov-scanner-box': YoovScannerBox,
      'yoov-room-booking': YoovRoomBooking
    },
    computed: {
      token () {
        return this.$store.getters.token
      },
      user () {
        return this.$store.getters.user
      }
    }
  }
</script>
<style>
  .office-scanner {
    max-width: 64px;
    max-height: 64px;
    object-fit: contain;
  }
</style>