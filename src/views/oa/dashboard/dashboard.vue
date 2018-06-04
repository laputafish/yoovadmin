<template>
  <div id="dashboard" class="animated fadeIn">
    <div class="d-flex flex-row d-sm-none">
      <button class="flex-grow-1"
              :class="{'btn-primary':activePanel==='scannerBox','btn-default':activePanel!=='scannerBox'}"
              @click="activePanel = 'scannerBox'">
        Scan Folder
      </button>
      <button class="flex-grow-1"
              :class="{'btn-primary':activePanel==='roomBooking','btn-default':activePanel!=='roomBooking'}"
              @click="activePanel = 'roomBooking'">
        Room Booking
      </button>
    </div>
    <div class="d-flex flex-column-reverse flex-sm-row">
      <yoov-room-booking class="dashboard-panel"
                         :class="{'active-panel':activePanel==='roomBooking'}"></yoov-room-booking>
      <yoov-scanner-box class="dashboard-panel"
                        :class="{'active-panel':activePanel==='scannerBox'}"></yoov-scanner-box>
    </div>
  </div>
</template>

<script>
  import YoovScannerBox from '@/components/YoovScannerBox'
  import YoovRoomBooking from '@/components/YoovRoomBooking'

  export default {
    data () {
      return {
        activePanel: 'roomBooking'
      }
    },
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
    },
    mounted () {
      this.$store.dispatch('GET_EQUIPMENTS')
      this.$store.dispatch('GET_PUBLIC_FOLDERS')
    }
  }
</script>
<style>
  #dashboard .card-body {
    padding: 0.5rem;
  }

  @media(min-width:576px) {
    #dashboard .card-body {
      padding: 1.25rem;
    }
  }

  .office-scanner {
    max-width: 64px;
    max-height: 64px;
    object-fit: contain;
  }

</style>