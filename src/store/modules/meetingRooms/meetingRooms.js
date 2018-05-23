import * as types from './meetingRooms_types'
import * as constants from '../../constants'
import axios from 'axios'

const state = {
  selectedRoom: null,
  meetingRooms: [],
  loadingMeetingRooms: true
}

const getters = {
  selectedRoom: (state) => {
    return state.selectedRoom
  },
  meetingRooms: (state) => {
    return state.meetingRooms
  }
}

const mutations = {
  updateMeetingRooms (state, payload) {
    state.meetingRooms = payload
    if (state.meetingRooms.length > 0) {
      console.log('Mutations :: updateMeetingRooms :: meetingRooms.length>0 => set selectedRoom')
      if (state.selectedRoom === null) {
        state.selectedRoom = state.meetingRooms[0]
      }
    }
  },
  changeLoadingMeetingRoomsState (state, loading) {
    state.loadingMeetingRooms = loading
  },
  createMeetingRoom (state, payload) {

  },
  updateMeetingRoom (state, payload) {

  },
  selectRoom (state, payload) {
    console.log('MUTATION :: selectRoom: payload:', payload)
    state.selectedRoom = payload
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
  },

  async [types.SELECT_ROOM] ({commit, dispatch, state}, payload) {
    console.log('ACTIONS :: SELECT_ROOM: payload:', payload)
    commit('selectRoom', payload)
  }

}

export default {
  state,
  getters,
  actions,
  mutations
}
