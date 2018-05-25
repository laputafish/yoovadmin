<template>
  <b-card class="flex-grow-1">
    <form class="form-line pull-right" v-if="rooms">
      <select v-model="selectedRoomId"
        class="form-control">
        <option disabled value="0">Please select room</option>
        <option v-for="room in rooms" :value="room.id">{{ room.name }}</option>
      </select>
    </form>
    <h3>MMMMSSSSSSSSSSSSSSSSSSSSSSS</h3>
    <b-card-body>
      <yoov-room-booking-schedule
        v-model="booking"
        :defaultRoom="selectedRoom"
        @input="updateBooking">
      </yoov-room-booking-schedule>
    </b-card-body>
    {{ selectedRoomId }}
  </b-card>
</template>

<script>
  import YoovRoomBookingSchedule from '@/components/YoovRoomBookingSchedule'

  export default {
    components: {
      'yoov-room-booking-schedule': YoovRoomBookingSchedule
    },
    data () {
      return {
        selectedRoomId: 0,
        booking: {
          meeting_room_id: 0,
          applicant_id: 0,
          started_at: null,
          ended_at: null,
          status: 'pending',
          remark: ''
        }
      }
    },
    mounted () {
      let vm = this
      this.$store.dispatch('GET_MEETING_ROOMS').then(function (response) {
        if (vm.rooms && vm.rooms.length > 0) {
          vm.selectedRoomId = vm.rooms[0].id
        } else {
          vm.selectedRoomId = 0
        }
      })
    },
    computed: {
      selectedRoom () {
        let vm = this
        let result = null
        if (vm.selectedRoomId !== 0) {
          for (var i = 0; i < vm.rooms.length; i++) {
            if (vm.rooms[i].id === vm.selectedRoomId) {
              result = vm.rooms[i]
              break
            }
          }
        }
        return result
      },
      rooms () {
        return this.$store.getters.meetingRooms
      }
    },
    methods: {
      updateBooking (params) {
        this.booking.started_at = params.started_at
        this.booking.ended_at = params.ended_at
      }
    }
  }
</script>
