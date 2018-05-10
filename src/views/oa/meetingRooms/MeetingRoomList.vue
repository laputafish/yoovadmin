<template>
  <div class="animated fadeIn">
    <div class="row">
      <div class="col-sm-12">
        <button type="button"
                class="btn btn-success pull-right ml-1">
          <i class="fa fa-fw fa-plus"></i>
        </button>
        <datatable v-bind="$data">

        </datatable>
      </div>
    </div>
  </div>
</template>

<script>
  import * as constants from '@/store/constants.json'
  import axios from 'axios'
  import components from './comps'

  export default {
    components,
    data () {
      return {
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
    watch: {
      query: {
        handler (query) {
          let vm = this
          axios.get(constants.URL + '/meeting_rooms').then(function (response) {
            vm.$store.dispatch('SET_MEETING_ROOMS', response.data)
            let meetingRooms = response.data
            vm.data = meetingRooms
            vm.total = vm.data.length
            console.log('watch(query) :: meetingRooms: ', meetingRooms)
          })
        }
      }
    },
    mounted () {
      this.$store.dispatch('GET_MEETING_ROOMS')
    }
  }
</script>
