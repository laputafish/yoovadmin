<template>
  <yoov-modal id="yoovMeetingRoomBookingDialog"
    :class="{'read-only':booking.status=='approved'||booking.status=='rejected'}">
    <div slot="header" class="header" style="position:relative;">
      <div class="pull-right">
        <span class="badge badge-primary booking-status" v-if="booking.status==='pending'">Pending</span>
        <span class="badge badge-success booking-status" v-else-if="booking.status==='approved'">Approved</span>
        <span class="badge badge-danger booking-status" v-else-if="booking.status==='rejected'">Rejected</span>
        <span class="badge badge-secondary booking-status" v-else>(New)</span>
      </div>
      <h3 class="dialog-title">
        Meeting Room Booking
      </h3>
      <div v-if="false" class="pull-left" style="margin-top:-5px;position:absolute;left: 0;top:0;margin:0 0 0 320px;font-size:10px;">
        <table style="width:640px;" id="booking-table" v-if="localBooking">
          <tr>
            <td>#</td><td>{{ localBooking.id }}</td>
            <td>Room ID</td><td>{{ localBooking.meeting_room_id }} ({{ localBooking.meeting_room_name }})</td>
            <td>Started At</td><td>{{ localBooking.started_at }} (Moment:{{ localBooking.startMoment.toString() }})</td>
          </tr>
          <tr>
            <td>app. ID</td><td>{{ localBooking.applicant_id }}</td>
            <td>app. Name</td><td>{{ localBooking.applicant_name }}</td>
            <td>Ended At</td><td>{{ localBooking.ended_at }} (Moment:{{ localBooking.endMoment.toString() }})</td>
          </tr>
        </table>
      </div>
    </div>
    <div slot="body" class="d-flex flex-column">
      <div class="row flex-grow-1">
        <div class="col-sm-3">
          <yoov-room-list-table class="d-flex flex-column">
          </yoov-room-list-table>
        </div>
        <div class="col-sm-9 d-flex flex-column">
          <yoov-room-booking-schedule
            v-model="localBooking"
            @input="updateBooking">
          </yoov-room-booking-schedule>
        </div>
      </div>
    </div>
    <div slot="footer" style="height:40px;width: 100%;position:relative;" class="text-center">
      <div v-if="false" style="position:absolute;left:0;top:0;text-align:center;width:100%;">selectedRoom: {{ selectedRoom }}
      </div>
      <div style="position:absolute;left:0;top:0;text-align:center;width:100%;">
        <b-button @click="update()"
                  :disabled="disableUpdate()"
                  variant="primary">
          OK
        </b-button>
        <b-button @click="$emit('close')"
                  variant="default">
          Cancel
        </b-button>
      </div>
    </div>
  </yoov-modal>
</template>

<script>
import YoovModal from '@/components/Modal'
import YoovRoomBookingSchedule from '@/components/YoovRoomBookingSchedule'
import YoovRoomListTable from '@/components/YoovRoomListTable'

export default {
  components: {
    'yoov-modal': YoovModal,
    'yoov-room-booking-schedule': YoovRoomBookingSchedule,
    'yoov-room-list-table': YoovRoomListTable
  },
  data () {
    return {
      localBooking: null
    }
  },
  props: {
    booking: null
  },
  methods: {
    updateBooking (params) {
      let vm = this
      vm.localBooking.started_at = params.started_at
      vm.localBooking.ended_at = params.ended_at
    },
    disableUpdate () {
      let vm = this
      let result = true
      if (vm.localBooking && vm.localBooking.started !== null) {
        result = false
      }
      return result
    },
    update () {
      let vm = this

      vm.$emit('updateBooking', {
        startedAt: vm.localBooking.started_at,
        endedAt: vm.localBooking.ended_at
      })
      vm.$emit('close')
    },
    updateBookingHandler (payload) {
      // payload.startMoment
      // payload.endMoment
      let vm = this
      vm.$emit('updateBooking', {
        meeting_room_id: 0,
        meeting_room: null,
        started_at: '',
        ended_at: ''
      })
    }
  },
  watch: {
    'displayedWeekdays': {
      handler () {
      },
      deep: true
    },
    'booking': {
      handler () {
        let vm = this
        vm.localBooking = vm.booking
        console.log('watch(booking) :: vm.localBooking: ', vm.localBooking)
        console.log('watch(booking) :: vm.selectedRoom: ', vm.selectedRoom)
        vm.fillBookingInfos()
        vm.refreshCalendar(vm.selectedRoom)
      },
      deep: true
    }
  },
  mounted () {
    let vm = this
    // vm.logCurrentBookings()
    vm.localBooking = vm.booking

    let promises = [
      vm.$store.dispatch('GET_MEETING_ROOM_BOOKINGS'),
      vm.$store.dispatch('GET_MEETING_ROOMS')
    ]
    Promise.all(promises).then(function (responses) {
      vm.$store.dispatch('UPDATE_BOOKING', vm.localBooking).then(function (response) {
        console.log('promise.all :: meeting_rooms.length = ' + vm.rooms.length)
        let selectedRoom = null
        for (var i = 0; i < vm.rooms.length; i++) {
          if (vm.rooms[i].id === vm.booking.meeting_room_id) {
            selectedRoom = vm.rooms[i]
            vm.$store.dispatch('SELECT_ROOM', selectedRoom)
            break
          }
        }
        // vm.initBookingInfos()
        // console.log('mounted => refreshCalendar :: selectedRoom: ', selectedRoom)
        // vm.refreshCalendar(selectedRoom)
      })
    })

    // vm.$store.dispatch('GET_MEETING_ROOM_BOOKINGS', {
    //   callback: (bookings) => {
    //     console.log('mounted :: callback :: bookings: ', bookings)
    //   }
    // })
    // let response = vm.$store.dispatch('GET_MEETING_ROOMS', {
    //   callback: () => {
    //
    //   }
    // })
    // console.log('mounted :: response: ', response)
    // vm.$nextTick(function () {
    //   console.log('mounted: bookings: ', vm.bookings)
    //   console.log('mounted: rooms: ', vm.rooms)
    //   vm.currentMoment = vm.$moment()
    //   vm.fillBookingInfos()
    //   vm.refreshCalendar()
    // })
  },
  computed: {
    selectedRoom () {
      return this.$store.getters.selectedRoom
    },
    rooms () {
      return this.$store.getters.meetingRooms
    }
    // currentBooking () {
    //   let vm = this
    //   var result = {
    //     startMoment: null,
    //     endMoment: null
    //   }
    //   if (vm.booking) {
    //     result.startMoment = vm.$moment(vm.booking.started_at)
    //     result.endMoment = vm.$moment(vm.booking.ended_at)
    //   }
    //   return result
    // },
    // timestamp () {
    //   let vm = this
    //   vm.$moment.locale('hk')
    //   // let moment = vm.$moment('2018-5-7 8:22:11')
    //   // let localeData = vm.$moment.localeData()
    //   return 'timestamp'
    // }
  }
}
</script>

<style>
#yoovMeetingRoomBookingDialog .dialog-header {

}

#yoovMeetingRoomBookingDialog .modal-container {
  width: 90%;
  min-width: 1200px;
  height: 710px;
}

#yoovMeetingRoomBookingDialog.read-only .modal-body {
  background-color: rgba(128,128,128,.05);
}

#yoovMeetingRoomBookingDialog .booking-status {
  font-size: 18px;

}

#yoovMeetingRoomBookingDialog .header {
  width: 100%;
  padding: 0 5px;
}

#yoovMeetingRoomBookingDialog .card {
  margin-bottom: 0;
  min-height: 360px;
}

#yoovMeetingRoomBookingDialog .rooms-table td.room-item {
  cursor: pointer;
  background-color: white;
}

#yoovMeetingRoomBookingDialog .rooms-table td.room-item:hover {
  background-color: rgba(0, 0, 0, 0.05);
}

#yoovMeetingRoomBookingDialog .rooms-table tr:nth-child(2n+1) td.room-item {
  background-color: rgba(0, 0, 0, 0.03);
}

#yoovMeetingRoomBookingDialog .rooms-table td.room-item {
  padding: 10px;
  border-radius: 5px;
}

#yoovMeetingRoomBookingDialog .modal-footer button {
  min-width: 80px;
}

#yoovMeetingRoomBookingDialog #booking-table {
  background-color: white;
}

#yoovMeetingRoomBookingDialog #booking-table tr td {
  white-space: nowrap;
}

#yoovMeetingRoomBookingDialog #booking-table tr td:nth-child(2n+1) {
  text-align: right;
  min-width: 50px;
  padding-left: 3px;
  padding-right: 5px;
  margin-bottom: 1px;
  border-bottom: 1px solid white;
}
#yoovMeetingRoomBookingDialog #booking-table tr td:nth-child(2n) {
  text-align: left;
  min-wdith: 50px;
  padding-left: 5px;
  padding-right: 3px;
  background-color: yellow;
  margin-bottom: 1px;
  border-bottom: 1px solid white;
}

</style>