import * as types from './equipments_types'
import * as constants from '../../constants'
import axios from 'axios'

const state = {
  equipments: []
}

const getters = {
  equipments: state => {
    return state.equipments
  },
  scanner: state => {
    let result = null
    for (var i = 0; i < state.equipments.length; i++) {
      if (state.equipments[i].name === 'scanner') {
        result = state.equipments[i]
        break
      }
    }
    return result
  }

}

const mutations = {
  setEquipments (state, payload) {
    state.equipments = payload
  },
  holdScanner (state, payload) {
    let scanner = payload.scanner
    let user = payload.user
    scanner.occupied_by = user.id
    scanner.occupied_by_user = user
  },
  releaseScanner (state, payload) {
    let scanner = payload.scanner
    scanner.occupied_by = 0
    scanner.occupied_by_user = null
  }
}

const actions = {
  async [types.GET_EQUIPMENTS] ({state, commit, dispatch}) {
    let apiUrl = constants.apiUrl + '/equipments'
    await axios.get(apiUrl).then(function (response) {
      commit('setEquipments', response.data)
    })
  },

  async [types.HOLD_SCANNER] ({state, commit, dispatch, getters}, user) {
    let apiUrl = constants.apiUrl + '/equipments/' + getters.scanner.id
    await axios.put(apiUrl, {occupied_by: user.id}).then(function (response) {
      commit('holdScanner', {scanner: getters.scanner, user: user})
    })
  },

  async [types.RELEASE_SCANNER] ({state, commit, dispatch, getters}) {
    let apiUrl = constants.apiUrl + '/equipments/' + getters.scanner.id
    await axios.put(apiUrl, {occupied_by: 0}).then(function (response) {
      commit('releaseScanner', {scanner: getters.scanner})
    })
  }

}

export default {
  state,
  getters,
  mutations,
  actions
}
