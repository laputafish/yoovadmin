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
    <small class="label label-default" v-html="meetingRoomBookingPeriod"></small>

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
          applicant_id: 0,
          applicant_name: '',
          meeting_room_id: 0,
          meeting_room: null,
          meeting_room_name: '',
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
            vm.showingTimelineSelectionDialog = false
            console.log('yoovTimelineSelectionDialog onDialogResult dialog=' + dialog)
            console.log('yoovTimelineSelectionDialog onDialogResult payload:', payload)
            let startedAt = payload.startedAt
            let endedAt = payload.endedAt
            let mode = payload.mode

            vm.localBooking.started_at = startedAt
            vm.localBooking.ended_at = endedAt
            console.log('onDialogResult :: localBooking: ', vm.localBooking)
            console.log('onDialogResult :: mode = ' + mode)
            if (mode === 'new') {
              vm.$store.dispatch('REMOVE_BOOKING', vm.localBooking.id).then(function () {
                vm.$store.dispatch('APPEND_BOOKING', vm.localBooking).then(function () {
                  vm.showCurrentBookings()
                })
              })
            } else {
              // update booking
              vm.$store.dispatch('UPDATE_BOOKING', vm.localBooking).then(function () {
                vm.showCurrentBookings()
              })
            }

            break
        }
      },
      book () {
        let vm = this
        console.log('YoovMeetingRoomBookingField :: show(YoovMeetingRoomBookingDialog) :: localBooking: ', vm.localBooking)
        vm.localBooking.startMoment = vm.$moment(vm.localBooking.started_at)
        vm.localBooking.endMoment = vm.$moment(vm.localBooking.ended_at)

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
        vm.localBooking.meeting_room_name = selectedRoom.name
        vm.localBooking.started_at = params.startedAt
        vm.localBooking.ended_at = params.endedAt
        vm.$store.dispatch('UPDATE_BOOKING', vm.localBooking)
        vm.$store.dispatch('UPDATE_WORKING_BOOKING', vm.localBooking)
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
            vm.showingTimelineSelectionDialog = true
            break
          case 'timeSlotEntryConfirmationDialog':
            vm.timeSlotEntryConfirmationDialog_booking = params.booking
            vm.timeSlotEntryConfirmationDialog_callback = params.callback
            vm.showingTimeSlotEntryConfirmationDialog = true
            break
        }
      },
      showCurrentBookings () {
        let vm = this
        for (var i = 0; i < vm.currentBookings.length; i++) {
          let booking = vm.currentBookings[i]
          console.log('#' + i + ': id=' + booking.id + ' appId=' + booking.applicant_id +
            ' (' + booking.applicant_name + ') ' +
            'room id = ' + booking.meeting_room_id + ' (' + booking.meeting_room_name + ') ' +
            'started_at=' + booking.started_at + '   ended_at=' + booking.ended_at
          )
        }
      },
      getFriendlyDateTimePair (phpDateTime) { // yyyy-mm-dd hh:nn:ss
        let dateStr = phpDateTime.substr(0, 10)
        let dt = new Date(phpDateTime)
        let hr = dt.getHours()
        let mi = dt.getMinutes()
        let ss = dt.getSeconds()
        let apm = 'am'
        if (hr > 12) {
          apm = 'pm'
          hr = hr - 12
        }
        let timeStr = hr
        if (mi > 0) {
          timeStr += ':' + mi
          if (ss > 0) {
            timeStr += ':' + ss
          }
        } else if (ss > 0) {
          timeStr += ':00:' + ss
        }
        timeStr += apm
        return [dateStr, timeStr]
      }
    },
    props: {
      meetingRoomBooking: {
        type: Object,
        default () {
          return {
            id: 0,
            applicant_id: 0,
            applicant_name: '',
            meeting_room_id: 0,
            meeting_room_name: '',
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
      vm.localBooking.applicant_id = vm.meetingRoomBooking.applicant_id
      vm.localBooking.applicant_name = vm.meetingRoomBooking.applicant_name

      vm.localBooking.meeting_room_id = vm.meetingRoomBooking.meeting_room_id
      vm.localBooking.meeting_room_name = vm.meetingRoomBooking.meeting_room_name
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
      currentBookings () {
        return this.$store.getters.meetingRoomBookings
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
          let dtPair1 = vm.getFriendlyDateTimePair(vm.localBooking.started_at)
          let dtPair2 = vm.getFriendlyDateTimePair(vm.localBooking.ended_at)

          const DATE = 0
          const TIME = 1

          if (dtPair1[DATE] === dtPair2[DATE]) {
            result = '<span class="badge badge-primary">' + dtPair1[DATE] + '</span>' + ' ' +
              dtPair1[TIME] + ' to ' + dtPair2[TIME]
          } else {
            result = '<span class="badge badge-primary">' + dtPair1[DATE] + '</span>' + ' ' +
              dtPair1[TIME] + ' to ' +
              '<span class="badge badge-primary">' + dtPair2[DATE] + '</span>' + ' ' +
              dtPair2[TIME]
          }
        }
        return result
      }
    }
  }
</script>