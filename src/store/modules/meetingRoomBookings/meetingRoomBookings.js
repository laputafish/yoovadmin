import * as types from './meetingRoomBookings_types'
import * as constants from '../../constants'
import axios from 'axios'

const state = {
  meetingRoomBookings: [],
  loadingMeetingRoomBookings: true,
  workingBooking: null
}

const getters = {
  meetingRoomBookings: (state) => {
    return state.meetingRoomBookings
  },
  workingBooking: (state) => {
    return state.workingBooking
  }
}

const getBooking = (bookings, bookingId) => {
  let result = null
  for (var i = 0; i < bookings.length; i++) {
    if (bookings[i].id === bookingId) {
      result = bookings[i]
      break
    }
  }
  return result
}

const mutations = {
  // updateMeetingRooms (state, payload) {
  //   state.meetingRooms = payload
  //   console.log('updateMeetingRooms :: meetingRooms: ', state.meetingRooms)
  // },
  changeLoadingMeetingRoomsState (state, loading) {
    state.loadingMeetingRooms = loading
  },
  createMeetingRoom (state, payload) {

  },
  updateMeetingRoom (state, payload) {

  },
  setMeetingRoomBookings (state, payload) {
    state.meetingRoomBookings = payload
  },
  removeBooking (state, bookingId) {
    console.log('meetingRoomBooking.js :: removeBooking :: bookingId = ' + bookingId)
    for (var i = 0; i < state.meetingRoomBookings.length; i++) {
      if (state.meetingRoomBookings[i].id === bookingId) {
        state.meetingRoomBookings.splice(i, 1)
      }
    }
  },

  appendBooking (state, booking) {
    let existingBooking = getBooking(state.meetingRoomBookings, booking.id)
    if (!existingBooking) {
      state.meetingRoomBookins.push(booking)
    }
  },

  updateBooking (state, booking) {
    /* payload
      id
      applicant_id
      status
      meeting_room_id
      meeting_room
      started_at
      ended_at
      remark
     */
    console.log('meetingRoomBooking :: updateBooking: booking.id=(' + booking.id + ') booking:', booking)
    let found = false
    for (var i = 0; i < state.meetingRoomBookings.length; i++) {
      console.log('meetingRoomBooking i=' + i)
      if (state.meetingRoomBookings[i].id === booking.id) {
        console.log('meetingRoomBooking :: found')
        state.meetingRoomBookings[i].status = 'pending'
        state.meetingRoomBookings[i].meeting_room_id = booking.meeting_room_id
        state.meetingRoomBookings[i].meeting_room = booking.meeting_room
        state.meetingRoomBookings[i].meeting_room_name = booking.meeting_room.name
        state.meetingRoomBookings[i].started_at = booking.started_at
        state.meetingRoomBookings[i].ended_at = booking.ended_at
        state.meetingRoomBookings[i].remark = booking.remark
        found = true
      }
    }
    if (!found) {
      state.meetingRoomBookings.push(booking)
    }
  },

  updateWorkingBooking (state, booking) {
    if (state.workingBooking === null) {
      state.workingBooking = booking
    } else {
      state.workingBooking.id = booking.id
      state.workingBooking.status = booking.status
      state.workingBooking.meeting_room_id = booking.meeting_room_id
      state.workingBooking.meeting_room = booking.meeting_room
      state.workingBooking.meeting_room_name = booking.meeting_room_name
      state.workingBooking.started_at = booking.started_at
      state.workingBooking.ended_at = booking.ended_at
      state.workingBooking.remark = booking.remark
    }
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

  async [types.REMOVE_BOOKING] ({commit, dispatch, state}, payload) {
    let bookingId = payload
    commit('removeBooking', bookingId)
  },

  async [types.APPEND_BOOKING] ({commit, dispatch, state}, payload) {
    commit('appendBooking', payload)
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
  },

  async [types.UPDATE_BOOKING] ({commit, dispatch, state}, payload) {
    commit('updateBooking', payload)
  },

  async [types.UPDATE_WORKING_BOOKING] ({commit, dispatch, state}, payload) {
    commit('updateWorkingBooking', payload)
  }

}

export default {
  state,
  getters,
  actions,
  mutations
}
