<template>
  <div>
    <b-card v-if="selectedMeetingRoom">
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
        <strong>{{ selectedMeetingRoom.id===0 ? 'New' : 'Edit'}}</strong>
      </div>
      <div class="col-sm-12">
        <meeting-room-form
          @updated="updatedHandler"
          :record="selectedMeetingRoom"></meeting-room-form>
      </div>
    </b-card>

    <b-card v-else>
      <div slot="header">
        <strong>Meeting Rooms</strong>
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
  import MeetingRoomForm from './MeetingRoomForm'
  import { EventBus } from '@/event-bus.js'

  export default {
    components: {
      ...components,
      'meeting-room-form': MeetingRoomForm
    },
    data () {
      return {
        selectedMeetingRoom: null,
        columns: [
          {title: 'Name', field: 'name', sortable: true},
          {title: 'Capacity', field: 'capacity', sortable: true},
          {title: 'Location', field: 'location', sortable: false},
          {title: 'Equipments', field: 'equipments', sortable: false},
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
      meetingRooms () {
        return this.$state.getters.meetingRooms
      },
      loadingMeetingRooms () {
        return this.$state.loadingMeetingRooms
      }
    },
    created () {
      EventBus.$on('edit_meeting_room', this.edit)
      EventBus.$on('delete_meeting_room', this.delete)
    },
    destroyed () {
      EventBus.$off('edit_meeting_room')
      EventBus.$off('delete_meeting_room')
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
        axios.get(constants.URL + '/meeting_rooms').then(function (response) {
          vm.$store.dispatch('SET_MEETING_ROOMS', response.data)
          let meetingRooms = response.data
          vm.data = meetingRooms
          vm.total = vm.data.length
          console.log('watch(query) :: meetingRooms: ', meetingRooms)
        })
      },

      initRecord (value) {
        console.log('initRecord :: value: ', value)
        return (typeof value === 'undefined')
          ? {
            name: '',
            capacity: 0,
            equipments: '',
            id: 0,
            location: '',
            remarK: ''
          }
          : {
            name: value.name,
            capacity: value.capacity,
            equipments: value.equipments,
            id: value.id,
            location: value.location,
            remarK: value.remark
          }
      },
      updateSelectedRecord (value) {
        this.selectedMeetingRoom.name = value.name
        this.selectedMeetingRoom.capacity = value.capacity
        this.selectedMeetingRoom.equipments = value.equipments
        this.selectedMeetingRoom.id = value.id
        this.selectedMeetingRoom.location = value.location
        this.selectedMeetingRoom.remark = value.remark
      },
      edit (value) {
        console.log('MeetingRoomList.vue :: edit(value) :: value.room: ', value.room)
        this.selectedMeetingRoom = this.initRecord(value.room)
        console.log('MeetingRoomList.vue :: edit(value): this.selectedMeetingRoom: ', this.selectedMeetingRoom)
      },
      newItem () {
        this.selectedMeetingRoom = this.initRecord()
      },
      delete (value) {
        console.log('MeetingRoomList :: delete :: value: ', value)
      },
      saveItem () {
        console.log('saveItem :: updatedMeetingRoom: ', this.selectedMeetingRoom)
        if (this.selectedMeetingRoom.id === 0) {
          // New
          this.$store.dispatch('CREATE_MEETING_ROOM', {
            meetingRoom: this.selectedMeetingRoom,
            callback: this.refresh
          })
          this.selectedMeetingRoom = null
        } else {
          // Update
          this.$store.dispatch('UPDATE_MEETING_ROOM', {
            meetingRoom: this.selectedMeetingRoom,
            callback: this.refresh
          })
          this.selectedMeetingRoom = null
        }
      },
      cancel () {
        this.selectedMeetingRoom = null
      },
      updatedHandler (value) {
        this.updateSelectedRecord(value)
      }
    },
    mounted () {
      this.$store.dispatch('GET_MEETING_ROOMS')
    }
  }
</script>
