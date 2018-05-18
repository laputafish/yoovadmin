<template>
  <div>
    <div class="input-group">
      <input class="form-control" type="text"
             disabled
             :placeholder="meetingRoomName"/>
      <div class="input-group-append">
        <button @click="book()"
                class="btn btn-primary" type="button">Make a Booking</button>
      </div>
    </div>
    <small class="label label-default">{{ meetingRoomBookingPeriod }}</small>
    <yoov-meeting-room-booking-dialog
      v-if="showingMeetingRoomBookingDialog"
      :booking="record"
      @updateBooking="updateBookingHandler"
      @close="showingMeetingRoomBookingDialog=false">

    </yoov-meeting-room-booking-dialog>
  </div>
</template>

<script>
  import YoovMeetingRoomBookingDialog from '@/dialogs/YoovMeetingRoomBookingDialog'

  export default {
    components: {
      'yoov-meeting-room-booking-dialog': YoovMeetingRoomBookingDialog
    },
    data () {
      return {
        showingMeetingRoomBookingDialog: false,
        record: {
          id: 0,
          user_id: 0,
          meeting_room_id: 0,
          meeting_room: null,
          started_at: null,
          ended_at: null,
          remark: ''
        }
      }
    },
    model: {
      prop: 'meetingRoomBooking',
      event: 'input'
    },
    methods: {
      book () {
        let vm = this
        console.log('YoovMeetingRoomBookingField :: show(YoovMeetingRoomBookingDialog) :: record: ', vm.record)
        vm.showingMeetingRoomBookingDialog = true
        // this.$modal.show(YoovMeetingRoomBookingDialog, {
        //   booking: vm.record,
        //   updateBooking: (params) => {
        //     vm.record.meeting_room_id = params.meeting_room_id
        //     vm.record.meeting_room = params.meeting_room
        //     vm.record.started_at = params.started_at
        //     vm.record.ended_at = params.ended_at
        //   }
        // }, {
        //   height: 'auto',
        //   width: '90%',
        //   minWidth: 1200
        // })
      },
      updateBookingHandler (params) {
        let vm = this
        vm.record.meeting_room_id = params.meeting_room_id
        vm.record.meeting_room = params.meeting_room
        vm.record.started_at = params.started_at
        vm.record.ended_at = params.ended_at
      }
    },
    props: {
      meetingRoomBooking: {
        type: Object,
        default () {
          return {
            id: 0,
            user_id: 0,
            meeting_room: null,
            started_at: null,
            ended_at: null,
            remark: ''
          }
        }
      }
    },
    mounted () {
      let vm = this
      vm.record.id = vm.meetingRoomBooking.id
      vm.record.user_id = vm.meetingRoomBooking.user_id
      vm.record.meeting_room = vm.meetingRoomBooking.meeting_room
      vm.record.started_at = vm.meetingRoomBooking.started_at
      vm.record.ended = vm.meetingRoomBooking.ended
      vm.record.remark = vm.meetingRoomBooking.remark
    },
    computed: {
      meetingRoomName () {
        let vm = this
        let result = ''
        if (vm.record.id !== 0) {
          result = vm.record.meeting_room.name
        }
        return result
      },
      meetingRoomBookingPeriod () {
        let vm = this
        let result = ''
        if (vm.record.id !== 0) {
          result = vm.record.meeting_room.period
        }
        return result
      }
    }
  }
</script>