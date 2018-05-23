<template>
  <div>
    <b-card v-if="selectedMeeting">
      <div slot="header">
        <button type="button"
                @click="saveItem"
                class="ml-1 btn btn-primary pull-right">
          <i class="fa fa-fw fa-save"></i>&nbsp;Save
        </button>
        <button type="button"
                @click="cancel"
                class="btn btn-default pull-right">
          <i class="fa fa-fw fa-save"></i>&nbsp;Cancel
        </button>
        <strong>{{ selectedMeeting.id===0 ? 'New' : 'Edit'}}</strong>
      </div>
      <div class="col-sm-12">
        <meeting-form
          @updated="updatedHandler"></meeting-form>
      </div>
    </b-card>

    <b-card v-else>
      <div slot="header">
        <strong>Meetings</strong>
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
  import MeetingForm from './MeetingForm'
  import {EventBus} from '@/event-bus.js'

  export default {
    components: {
      ...components,
      'meeting-form': MeetingForm
    },
    data () {
      return {
        selectedMeeting: null,
        columns: [
          {title: 'Subject', field: 'subject', sortable: true},
          {title: 'Venue', field: 'meeting_venue', sortable: true},
          {title: 'Applicant', field: 'applicant_name', sortable: true},
          {title: 'Started At', field: 'started_at', sortable: false},
          {title: 'Ended At', field: 'ended_at', sortable: false},
          {title: 'Remark', field: 'remark', sortable: false},
          {title: 'Status', field: 'status', sortable: false},
          {title: 'Action', tdComp: 'tdAction', field: 'action', sortable: false}
        ],
        data: [],
        total: 0,
        query: {}
      }
    },
    computed: {
      user () {
        return this.$store.getters.user
      },
      meetingRooms () {
        return this.$store.getters.meetingRooms
      },
      loadingMeetingRooms () {
        return this.$store.loadingMeetingRooms
      }
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
        axios.get(constants.apiUrl + '/meetings').then(function (response) {
          let meetings = response.data
          vm.$store.dispatch('SET_MEETINGS', meetings)
          vm.data = meetings
          vm.total = meetings.length
        })
      },

      setRecord (value) {
        let vm = this
        console.log('setRecord :: value: ', value)
        console.log('setRecord :: typeof value = ' + (typeof value))
        let result = (typeof value === 'undefined')
          ? {
            id: 0,
            subject: '',
            venue_type: 'conference_room',
            venue: '',
            meeting_room_booking_id: 0,
            room_booking: null,
            used_id: vm.user.id,
            user_name: vm.user.name,
            started_at: '',
            ended_at: '',
            remark: ''
          }
          : {
            id: value.id,
            subject: value.subject,
            venue_type: value.venue_type,
            venue: value.venue,
            meeting_room_booking_id: value.meeting_room_booking_id,
            room_booking: value.room_booking,
            user_id: value.user_id,
            user_name: value.applicant_name,
            started_at: value.started_at,
            ended_at: value.ended_at,
            remark: value.remark
          }
        console.log('setRecord :: result: ', result)
        return result
      },
      updateSelectedRecord (value) {
        this.selectedMeeting.id = value.id
        this.selectedMeeting.subject = value.subject
        this.selectedMeeting.venue_type = value.venue_type
        this.selectedMeeting.venue = value.venue
        this.selectedMeeting.meeting_room_booking_id = value.meeting_room_booking_id
        this.selectedMeeting.user_id = value.user_id
        this.selectedMeeting.user_name = value.user_name
        this.selectedMeeting.started_at = value.started_at
        this.selectedMeeting.ended_at = value.ended_at
        this.selectedMeeting.remark = value.remark
      },
      doDeleteMeeting (meeting) {
        let vm = this
        vm.$store.dispatch('DELETE_MEETING', meeting.id).then((response) => {
          if (response.status === 'fails') {
            vm.$dialog.alert({
              title: 'Warning',
              message: response.message
            })
          } else {
            vm.refresh()
          }
        })
        // let url = constants.apiUrl + '/meetings/' + meeting.id
        // axios.delete(url).then((response) => {
        //   vm.refresh()
        // })
      },
      saveItem () {
        if (this.selectedMeeting.id === 0) {
          // New
          this.$store.dispatch('CREATE_MEETING', {
            meeting: this.selectedMeeting,
            callback: this.refresh
          })
          this.selectedMeeting = null
        } else {
          // Update
          this.$store.dispatch('UPDATE_MEETING', {
            meeting: this.selectedMeeting,
            callback: this.refresh
          })
          this.selectedMeeting = null
        }
      },
      cancel () {
        this.selectedMeeting = null
      },
      updatedHandler (value) {
        this.updateSelectedRecord(value)
      },
      edit (value) {
        console.log('MeetingList :: edit')
        let vm = this
        vm.$store.dispatch('SET_TEMP_MEETING', value.meeting).then(function (response) {
          vm.selectedMeeting = vm.$store.getters.tempMeeting
          console.log('MeetingList :: edit :: selectedMeeting set :: tempMeeting: ')
        })
        // console.log('MeetingList.vue :: edit')
        // this.selectedMeeting = this.setRecord(value.meeting)
        // console.log('MeetingList :: edit :: this.selectedMeeting: ', this.selectedMeeting)
        // if (value.meeting.venue_type === 'conference_room') {
        //   this.$store.dispatch('GET_ROOM_BOOKING', value.meeting.id).then(function (response) {
        //     this.selectedMeeting.roomBooking = response
        //   })
        // }
      },
      newItem () {
        let vm = this
        vm.$store.dispatch('SET_TEMP_MEETING', {
          id: 0,
          subject: '',
          venue_type: 'conference_room',
          venue: '',
          meeting_room_booking_id: 0,
          room_booking: null,
          used_id: vm.user.id,
          user_name: vm.user.name,
          started_at: '',
          ended_at: '',
          remark: ''
        })
        vm.selectedMeeting = vm.$store.getters.tempMeeting
      },
      delete (value) {
        console.log('MeetingList :: delete')
        let vm = this
        let meeting = value.meeting
        console.log('delete :: value: ', meeting.name)
        vm.$dialog.confirm({
          title: 'Confirmation',
          body: 'Delete meeting "' + meeting.subject + '".\nAre you sure?'
        }, {
          okText: 'Yes',
          cancelText: 'No'
        })
          .then(() => {
            vm.doDeleteMeeting(meeting)
          })
      }
    },
    created () {
      EventBus.$on('edit_meeting', this.edit)
      EventBus.$on('delete_meeting', this.delete)
    },
    destroyed () {
      EventBus.$off('edit_meeting')
      EventBus.$off('delete_meeting')
    },
    mounted () {
      // if (!this.user) {
      //   this.$dialog.alert('Access Denied or Session Timeout. Please login again!')
      //   console.log('after alert')
      //   this.$router.push({name: 'Login'})
      //   console.log('after push login')
      // } else {
      //   this.refresh()
      // }
    }
  }
</script>
