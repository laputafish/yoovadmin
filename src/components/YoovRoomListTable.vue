<template>
  <div id="room-list-table">
    <h4>Meeting Rooms</h4>
    <div class="flex-grow-1" style="overflow-y: scroll;">
      <table class="rooms-table table-hover table-responsive" style="display:table;">
        <tbody>
        <tr v-for="room in rooms"
            @click="onRoomSelected(room)">
          <td class="room-item"
              :class="{'bg-primary':selectedRoom===room}">
            {{ room.name }}&nbsp;
            <span class="badge badge-success"><i class="fa fa-user"></i>&nbsp;x&nbsp;{{ room.capacity }}</span>
          </td>
        </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
  export default {
    computed: {
      rooms () {
        return this.$store.getters.meetingRooms
      },
      selectedRoom () {
        return this.$store.getters.selectedRoom
      }
    },
    methods: {
      onRoomSelected (room) {
        console.log('onRoomSelected starts')
        let vm = this
        vm.$store.dispatch('SELECT_ROOM', room).then(function () {
          console.log('after dispatch(SELECT_ROOM)')
          // vm.refreshCalendar(room)
          // vm.localBooking.meeting_room_id = room.id
          // vm.localBooking.meeting_room_name = room.name
          // vm.localBooking.meeting_room = room
        })
        console.log('onRoomSelected ends')
      }
    }
  }
</script>