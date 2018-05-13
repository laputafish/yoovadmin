import * as types from './meetingRooms_types'
import * as constants from '../../constants'
import axios from 'axios'

const state = {
  meetingRooms: [],
  loadingMeetingRooms: true
}

const getters = {
  meetingRooms: (state) => {
    return state.meetingRooms
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

  }
}

const actions = {
  [types.CREATE_MEETING_ROOM] ({commit, dispatch}, payload) {
    let meetingRoom = payload.meetingRoom
    let url = constants.apiUrl + '/meeting_rooms'
    axios.post(url, meetingRoom).then(function (response) {
      if (typeof payload.callback === 'function') {
        payload.callback()
      }
      //    dispatch('GET_MEETING_ROOMS')
    })
  },

  [types.UPDATE_MEETING_ROOM] ({commit, dispatch}, payload) {
    let meetingRoom = payload.meetingRoom
    let url = constants.apiUrl + '/meeting_rooms/' + meetingRoom.id
    axios.put(url, meetingRoom).then(function (response) {
      if (typeof payload.callback === 'function') {
        payload.callback()
      }
//      dispatch('GET_MEETING_ROOMS')
    })
  },

  [types.SET_MEETING_ROOMS] ({commit, state}, payload) {
    commit('updateMeetingRooms', payload)
    commit('changeLoadingMeetingRoomsState', false)
  },

  [types.GET_MEETING_ROOMS] ({commit, state}, payload) {
    axios.get(constants.apiUrl + '/meeting_rooms').then((response) => {
      console.log('GET_MEETING_ROOMS :: data: ', response.data)
      commit('updateMeetingRooms', response.data)
      commit('changeLoadingMeetingRoomsState', false)
    })
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
