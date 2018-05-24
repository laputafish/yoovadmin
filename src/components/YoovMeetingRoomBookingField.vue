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
      :booking="localBooking"
      @updateBooking="updateBookingHandler"
      @close="showingMeetingRoomBookingDialog=false">
    </yoov-meeting-room-booking-dialog>

    <yoov-timeline-selection-dialog
      v-if="showingTimelineSelectionDialog"
      :currentMoment="timelineSelectionDialog_currentMoment"
      :booking="timelineSelectionDialog_booking"
      :mode="timelineSelectionDialog_mode"
      @onResult="onDialogResult"
      @close="showingTimelineSelectionDialog=false">
    </yoov-timeline-selection-dialog>

    <yoov-time-slot-entry-confirmation-dialog
      v-if="showingTimeSlotEntryConfirmationDialog"
      :booking="timeSlotEntryConfirmationDialog_booking"
      @onResult="onDialogResult"
      @close="showingTimeSlotEntryConfirmationDialog=false">
    </yoov-time-slot-entry-confirmation-dialog>
  </div>
</template>

<script>
  import YoovMeetingRoomBookingDialog from '@/dialogs/YoovMeetingRoomBookingDialog'
  import YoovTimelineSelectionDialog from '@/dialogs/YoovTimelineSelectionDialog'
  import YoovTimeSlotEntryConfirmationDialog from '@/dialogs/YoovTimeSlotEntryConfirmationDialog'

  import {EventBus} from '@/event-bus'

  export default {
    components: {
      'yoov-meeting-room-booking-dialog': YoovMeetingRoomBookingDialog,
      'yoov-timeline-selection-dialog': YoovTimelineSelectionDialog,
      'yoov-time-slot-entry-confirmation-dialog': YoovTimeSlotEntryConfirmationDialog
    },
    data () {
      return {
        showingMeetingRoomBookingDialog: false,
        showingTimelineSelectionDialog: false,
        showingTimeSlotEntryConfirmationDialog: false,

        timelineSelectionDialog_booking: null,
        timelineSelectionDialog_currentMoment: null,
        timelineSelectionDialog_mode: 'edit',

        timeSlotEntryConfirmationDialog_booking: null,
        timeSlotEntryConfirmationDialog_callback: null,

        localBooking: {
          id: 0,
          user_id: 0,
          meeting_room_id: 0,
          meeting_room: null,
          started_at: null,
          ended_at: null,
          status: 'new',
          remark: ''
        }
      }
    },
    model: {
      prop: 'meetingRoomBooking',
      event: 'input'
    },
    methods: {
      onDialogResult (result) {
        let dialog = result.dialog
        let payload = result.payload
        let vm = this
        switch (dialog) {
          case 'yoovTimeSlotEntryConfirmationDialog':
            vm.showingTimeSlotEntryConfirmationDialog = false
            console.log('onDialogResult dialog=' + dialog)
            let action = payload.action
            if (typeof vm.timeSlotEntryConfirmationDialog_callback === 'function') {
              console.log('onDialogResult callback is function')
              vm.timeSlotEntryConfirmationDialog_callback(action)
            }
            break
          case 'yoovTimelineSelectionDialog':
            console.log('onDialogResult dialog=' + dialog)
            let startedAt = payload.startedAt
            let endedAt = payload.endedAt
            let mode = payload.mode

            vm.localBooking.started_at = startedAt
            vm.localBooking.ended_at = endedAt
            if (mode === 'new') {
              vm.$store.dispatch('REMOVE_BOOKING', vm.localBooking.id).then(function () {
                vm.$store.dispatch('APPEND_BOOKING', vm.localBooking)
              })
            } else {
              // update booking
              vm.$store.dispatch('UPDATE_BOOKING', vm.localBooking)
            }

            break
        }
      },
      book () {
        let vm = this
        console.log('YoovMeetingRoomBookingField :: show(YoovMeetingRoomBookingDialog) :: localBooking: ', vm.localBooking)
        vm.showingMeetingRoomBookingDialog = true
        // this.$modal.show(YoovMeetingRoomBookingDialog, {
        //   booking: vm.localBooking,
        //   updateBooking: (params) => {
        //     vm.localBooking.meeting_room_id = params.meeting_room_id
        //     vm.localBooking.meeting_room = params.meeting_room
        //     vm.localBooking.started_at = params.started_at
        //     vm.localBooking.ended_at = params.ended_at
        //   }
        // }, {
        //   height: 'auto',
        //   width: '90%',
        //   minWidth: 1200
        // })
      },
      updateBookingHandler (params) {
        let vm = this
        let selectedRoom = vm.selectedRoom
        vm.localBooking.meeting_room_id = selectedRoom.id
        vm.localBooking.meeting_room = selectedRoom
        vm.localBooking.started_at = params.started_at
        vm.localBooking.ended_at = params.ended_at
        vm.$store.dispatch('UPDATE_BOOKING', vm.localBooking)
        vm.showingTimelineSelectionDialog = false
      },
      showDialog (params) {
        console.log('showDialog: params: ', params)
        let vm = this
        switch (params.dialog) {
          case 'timelineSelectionDialog':
            vm.timelineSelectionDialog_booking = params.booking
            vm.timelineSelectionDialog_currentMoment = params.currentMoment
            vm.timelineSelectionDialog_mode = params.mode
            console.log('showDialog timelineSelectionDialog_booking = ' + vm.timelineSelectionDialog_booking)
            console.log('showDialog timelineSelectionDialog_currentMoment = ' + vm.timelineSelectionDialog_currentMoment.toString())
            console.log('showDialog timelineSelectionDialog_mode = ' + vm.timelineSelectionDialog_mode)
            vm.showingTimelineSelectionDialog = true
            break
          case 'timeSlotEntryConfirmationDialog':
            vm.timeSlotEntryConfirmationDialog_booking = params.booking
            vm.timeSlotEntryConfirmationDialog_callback = params.callback
            vm.showingTimeSlotEntryConfirmationDialog = true
            break
        }
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
      vm.localBooking.id = vm.meetingRoomBooking.id
      vm.localBooking.user_id = vm.meetingRoomBooking.user_id
      vm.localBooking.meeting_room_id = vm.meetingRoomBooking.meeting_room_id
      vm.localBooking.meeting_room = vm.meetingRoomBooking.meeting_room
      vm.localBooking.started_at = vm.meetingRoomBooking.started_at
      vm.localBooking.ended_at = vm.meetingRoomBooking.ended_at
      vm.localBooking.status = vm.meetingRoomBooking.status
      vm.localBooking.remark = vm.meetingRoomBooking.remark
    },
    created () {
      let vm = this
      EventBus.$on('showDialog', vm.showDialog)
    },
    destroyed () {
      EventBus.$off('showDialog')
    },
    computed: {
      selectedRoom () {
        return this.$store.getters.selectedRoom
      },
      meetingRoomName () {
        let vm = this
        let result = ''
        if (vm.localBooking.id !== 0) {
          result = vm.localBooking.meeting_room.name
        }
        return result
      },
      meetingRoomBookingPeriod () {
        let vm = this
        let result = ''
        if (vm.localBooking.id !== 0) {
          result = vm.localBooking.meeting_room.period
        }
        return result
      }
    }
  }
</script>