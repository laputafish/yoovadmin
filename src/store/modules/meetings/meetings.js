import * as types from './meetings_types'
import * as constants from '../../constants'
import axios from 'axios'

const state = {
  meetings: [],
  loadingMeetings: true
}

const getters = {
  meetings: (state) => {
    return state.meetings
  }
}

const mutations = {
  updateMeetings (state, payload) {
    state.meetings = payload
    console.log('updateMeetings :: meetings: ', state.meetings)
  },
  changeLoadingMeetingsState (state, loading) {
    state.loadingMeetings = loading
  },
  createMeeting (state, payload) {

  },
  updateMeeting (state, payload) {

  }
}

const actions = {
  [types.CREATE_MEETING] ({commit, dispatch}, payload) {
    let meeting = payload.meeting
    let url = constants.URL + '/meetings'
    axios.post(url, meeting).then(function (response) {
      if (typeof payload.callback === 'function') {
        payload.callback()
      }
      //    dispatch('GET_MEETINGS')
    })
  },

  [types.UPDATE_MEETING] ({commit, dispatch}, payload) {
    let meeting = payload.meeting
    let url = constants.URL + '/meetings/' + meeting.id
    axios.put(url, meeting).then(function (response) {
      if (typeof payload.callback === 'function') {
        payload.callback()
      }
//      dispatch('GET_MEETINGS')
    })
  },

  [types.SET_MEETINGS] ({commit, state}, payload) {
    commit('updateMeetings', payload)
    commit('changeLoadingMeetingsState', false)
  },

  [types.GET_MEETINGS] ({commit, state}, payload) {
    axios.get(constants.URL + '/meetings').then((response) => {
      console.log('GET_MEETINGS :: data: ', response.data)
      commit('updateMeetings', response.data)
      commit('changeLoadingMeetingsState', false)
    })
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
