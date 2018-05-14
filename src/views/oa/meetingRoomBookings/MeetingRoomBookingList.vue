<template>
  <div>
    <!-- Form -->
    <b-card v-if="selectedMeetingRoomBooking">
      <div slot="header">
        <button type="button"
          @click="saveITem"
          class="ml-1 btn btn-primary pull-right">
          <i class="fa fa-fw fa-save"></i>&nbsp;Save
        </button>
        <button type="button"
                @click="cancel"
                class="btn btn-default pull-right">
          <i class="fa fa-fw fa-save"></i>&nbsp;Cancel
        </button>
        <strong>{{ selectedMeetingRoomBooking.id===0 ? 'New' : 'Edit'}}</strong>
      </div>
      <div class="col-sm-12">
        <meeting-room-booking-form
          @updated="updatedHandler"
          :record="selectedMeetingRoomBooking"></meeting-room-booking-form>
      </div>
    </b-card>

    <!-- List -->
    <b-card v-else>
      <div slot="header">
        <strong>Meeting Room Bookings</strong>
      </div>
      <div class="row">
        <div class="col-sm-12">
          <button type="button"
                  @click="newItem"
                  class="btn btn-success pull-right ml-1">
            <i class="fa fa-fw fa-plus"></i>
          </button>
          <datatable v-bind="$data">

          </datatable>
        </div>
      </div>
    </b-card>
  </div>
</template>

<script>
  import * as constants from '@/store/constants.json'
  import axios from 'axios'
  import components from './comps'
  import MeetingRoomBookingForm from './MeetingRoomBookingForm'
  import { EventBus } from '@/event-bus.js'

  export default {
    components: {
      ...components,
      'meeting-room-booking-form': MeetingRoomBookingForm
    },
    data () {
      return {
        selectedMeetingRoomBooking: null,
        columns: [
          {title: 'Meeting Room', field: 'meeting_room_name', sortable: true},
          {title: 'Applicant', field: 'applicant_name', sortable: true},
          {title: 'Started At', field: 'started_at', sortable: false},
          {title: 'Ended At', field: 'ended_at', sortable: false},
          {title: 'Remark', field: 'remark', sortable: false},
          {title: 'Action', tdComp: 'tdAction', field: 'action', sortable: false}
        ],
        data: [],
        total: 0,
        query: {}
      }
    },
    computed: {
      meetingRoomBookings () {
        return this.$store.getters.meetingRoomBookings
      },
      loadingMeetingRoomBookings () {
        return this.$store.loadingMeetingRoomBookings
      }
    },
    created () {
      EventBus.$on('edit_meeting_room_booking', this.edit)
      EventBus.$on('delete_meeting_room_booking', this.delete)
    },
    destroyed () {
      EventBus.$off('edit_meeting_room_booking')
      EventBus.$off('delete_meeting_room_booking')
    },
    watch: {
      query: {
        handler (query) {
          this.refresh(query)
        }
      }
    },
    methods: {
      refresh (query) {
        let vm = this
        axios.get(constants.apiUrl + '/meeting_room_bookings').then(function (response) {
          vm.$store.dispatch('SET_MEETING_ROOM_BOOKINGS', response.data)
          let meetingRoomBookings = response.data
          vm.data = meetingRoomBookings
          vm.total = vm.data.length
          console.log('watch(query) :: meetingRoomBookings: ', meetingRoomBookings)
        })
      },

      initRecord (value) {
        console.log('initRecord :: value: ', value)
        return (typeof value === 'undefined')
          ? {
            id: 0,
            meeting_room_id: 0,
            meeting_room_name: '',
            applicant_id: 0,
            applicant_name: '',
            started_at: '',
            ended_at: '',
            remark: ''
          }
          : {
            id: value.id,
            meeting_room_id: value.meeting_room_id,
            meeting_room_name: value.meeting_room_name,
            applicant_id: value.applicant_id,
            applicant_name: value.applicant_name,
            started_at: value.started_at,
            ended_at: value.ended_at,
            remark: value.remark
          }
      },
      updateSelectedRecord (value) {
        this.selectedMeetingRoomBooking.id = value.id
        this.selectedMeetingRoomBooking.meeting_room_id = value.meeting_room_id
        this.selectedMeetingRoomBooking.meeting_room_name = value.meeting_room_name
        this.selectedMeetingRoomBooking.applicant_id = value.applicant_id
        this.selectedMeetingRoomBooking.applicant_name = value.applicant_name
        this.selectedMeetingRoomBooking.started_at = value.started_at
        this.selectedMeetingRoomBooking.ended_at = value.ended_at
        this.selectedMeetingRoomBooking.remark = value.remark
      },
      edit (value) {
        this.selectedMeetingRoomBooking = this.initRecord(value.booking)
      },
      newItem () {
        this.selectedMeetingRoomBooking = this.initRecord()
      },
      doDeleteRoomBooking (booking) {
        let vm = this
        let url = constants.apiUrl + '/meeting_room_bookings/' + booking.id
        axios.delete(url).then((response) => {
          vm.refresh()
        })
      },
      delete (value) {
        let vm = this
        let booking = value.booking
        vm.$dialog.confirm({
          title: 'Confirmation',
          body: 'Delete booking at "' + booking.started_at + '".\nAre you sure?'
        })
          .then(() => {
            vm.doDeleteRoomBooking(booking)
          })
      },
      saveItem () {
        console.log('saveItem :: updatedMeetingRoomBooking: ', this.selectedMeetingRoomBooking)
        if (this.selectedMeetingRoomBooking.id === 0) {
          // New
          this.$store.dispatch('CREATE_MEETING_ROOM_BOOKING', {
            meetingRoomBooking: this.selectedMeetingRoomBooking,
            callback: this.refresh
          })
          this.selectedMeetingRoomBooking = null
        } else {
          // Update
          this.$store.dispatch('UPDATE_MEETING_ROOM_BOOKING', {
            meetingRoomBooking: this.selectedMeetingRoomBooking,
            callback: this.refresh
          })
          this.selectedMeetingRoomBooking = null
        }
      },
      cancel () {
        this.selectedMeetingRoomBooking = null
      },
      updatedHandler (value) {
        this.updateSelectedRecord(value)
      }
    },
    mounted () {
      this.refresh()
    }
  }
</script>
