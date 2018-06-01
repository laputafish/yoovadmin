<template>
  <b-card class="flex-grow-1" id="yoov-room-booking">
    <div class="d-flex flex-row">
      <h3 style="position:relative;" class="flex-grow-1">
        <div class="spinner"
             v-if="processing">
          <i class="fa fa-spinner fa-spin"></i>
        </div>
        MMMM
      </h3>
      <form class="form-line" v-if="rooms">
        <select v-model="selectedRoomId"
          class="form-control">
          <option disabled value="0">Please select room</option>
          <option v-for="room in rooms" :value="room.id">{{ room.name }}</option>
        </select>
      </form>
    </div>
    <yoov-room-booking-schedule
      :editable="true"
      v-model="booking"
      :defaultRoom="selectedRoom"
      @input="updateBooking">
    </yoov-room-booking-schedule>
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
      let promises = [
        this.$store.dispatch('GET_MEETING_ROOMS'),
        this.$store.dispatch('GET_MEETING_ROOM_BOOKINGS')
      ]
      Promise.all(promises).then(function (response) {
        if (vm.rooms && vm.rooms.length > 0) {
          vm.selectedRoomId = vm.rooms[0].id
        } else {
          vm.selectedRoomId = 0
        }
      })
    },
    watch: {
      processing: function (value) {
        alert('value = ' + value)
      }
    },
    computed: {
      processing () {
        let status = this.$store.getters.processingBooking
        return status
      },
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
      },
      user () {
        return this.$store.getters.user
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

<style>
  #yoov-room-booking .spinner {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    text-align: center;
  }
</style>