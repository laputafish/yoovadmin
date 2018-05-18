import * as types from './meetingRoomBookings_types'
import * as constants from '../../constants'
import axios from 'axios'

const state = {
  meetingRoomBookings: [],
  loadingMeetingRoomBookings: true
}

const getters = {
  meetingRoomBookings: (state) => {
    return state.meetingRoomBookings
  }
}

const mutations = {
  updateMeetingRooms (state, payload) {
    state.meetingRooms = payload
    console.log('updateMeetingRooms :: meetingRooms: ', state.meetingRooms)
  },
  changeLoadingMeetingRoomsState (state, loading) {
    state.loadingMeetingRooms = loading
  },
  createMeetingRoom (state, payload) {

  },
  updateMeetingRoom (state, payload) {

  },
  setMeetingRoomBookings (state, payload) {
    state.meetingRoomBookings = payload
  }
}

const actions = {
  async [types.GET_MEETING_ROOM_BOOKINGS] ({commit, dispatch}, payload) {
    let apiUrl = constants.apiUrl
    await axios.get(apiUrl + '/meeting_room_bookings').then(function (response) {
      commit('setMeetingRoomBookings', response.data)
      if (payload) {
        if (typeof payload.callback === 'function') {
          payload.callback(response.data)
        }
      }
    })
  },

  async [types.GET_DAY_BOOKINGS] ({commit, dispatch, state}, payload) {
    return new Promise((resolve, reject) => {
      let requestedDayMoment = payload
      let ymmdd = requestedDayMoment.format('Y-MM-DD')
      // console.log('GET_DAY_BOOKINGS  requestedDayMoment :: ymmdd: ' + ymmdd)
      // console.log('GET_DAY_BOOKINGS  state.meetingRoomBookings.length = ' + state.meetingRoomBookings.length)

      let result = []
      for (var i = 0; i < state.meetingRoomBookings.length; i++) {
        // console.log('#' + i + ': meetingRoomBookings[i]: ', state.meetingRoomBookings[i])
        // console.log('#' + i + ': started_at=' + state.meetingRoomBookings[i].started_at)
        // console.log('#' + i + ': subsstr(0,8): ' + state.meetingRoomBookings[i].started_at.substr(0, 10))        // let moment = Vue.moment(state.meetingRoomBookings.started_at)
        if (state.meetingRoomBookings[i].started_at.substr(0, 10) === ymmdd) {
          // console.log('#' + i + ': push')
          result.push(state.meetingRoomBookings[i])
        }
      }
      resolve(result)
    })
  }

}

export default {
  state,
  getters,
  actions,
  mutations
}
