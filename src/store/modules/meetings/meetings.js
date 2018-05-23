import * as types from './meetings_types'
import * as constants from '../../constants'
import axios from 'axios'

const state = {
  meetings: [],
  loadingMeetings: true,
  tempMeeting: null
}

const getters = {
  meetings: (state) => {
    return state.meetings
  },
  tempMeeting: (state) => {
    return state.tempMeeting
  }
}

const mutations = {
  setMeetings (state, payload) {
    state.meetings = payload
    console.log('setMeetings :: meetings: ', state.meetings)
  },
  changeLoadingMeetingsState (state, loading) {
    state.loadingMeetings = loading
  },
  createMeeting (state, payload) {

  },
  updateMeeting (state, payload) {

  },
  setTempMeeting (state, payload) {
    console.log('setTempMeeting :: payload: ', payload)
    state.tempMeeting = JSON.parse(JSON.stringify(payload))
  },
  setTempMeetingStartedAt (state, payload) {
    state.tempMeeting.started_at = payload
  },
  setTempMeetingEndedAt (state, payload) {
    state.tempMeeting.ended_at = payload
  }

}

const actions = {
  [types.CREATE_MEETING] ({commit, dispatch}, payload) {
    let meeting = payload.meeting
    let url = constants.apiUrl + '/meetings'
    axios.post(url, meeting).then(function (response) {
      if (typeof payload.callback === 'function') {
        payload.callback()
      }
      //    dispatch('GET_MEETINGS')
    })
  },

  [types.UPDATE_MEETING] ({commit, dispatch}, payload) {
    let meeting = payload.meeting
    let url = constants.apiUrl + '/meetings/' + meeting.id
    axios.put(url, meeting).then(function (response) {
      if (typeof payload.callback === 'function') {
        payload.callback()
      }
//      dispatch('GET_MEETINGS')
    })
  },

  [types.SET_MEETINGS] ({commit, state}, payload) {
    commit('setMeetings', payload)
    commit('changeLoadingMeetingsState', false)
  },

  [types.GET_MEETINGS] ({commit, state}, payload) {
    axios.get(constants.apiUrl + '/meetings').then((response) => {
      console.log('GET_MEETINGS :: data: ', response.data)
      commit('setMeetings', response.data)
      commit('changeLoadingMeetingsState', false)
    })
  },

  async [types.SET_TEMP_MEETING] ({commit, state}, payload) {
    console.log('types.SET_TEMP_MEETING :: payload: ', payload)
    console.log('types.SET_TEMP_MEETING :: state.meetings: ', state.meetings)
    let result = null
    for (var i = 0; i < state.meetings.length; i++) {
      if (state.meetings[i].id === payload.id) {
        result = state.meetings[i]
        break
      }
    }
    console.log('SET_TEMP_MEETING :: => commit')
    commit('setTempMeeting', result)
  },

  async [types.DELETE_MEETING] ({commit, state}, meetingId) {
    await axios.delete(constants.apiUrl + '/meetings/' + meetingId).then((response) => {

    })
  },

  async [types.SET_TEMP_MEETING_STARTED_AT] ({commit, state}, startedat) {
    commit('setTempMeetingStartedAt', startedat)
  },

  async [types.SET_TEMP_MEETING_ENDED_AT] ({commit, state}, endedAt) {
    commit('setTempMeetingEndedAt', endedAt)
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
