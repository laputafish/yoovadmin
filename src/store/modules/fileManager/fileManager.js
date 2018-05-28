import * as types from './fileManager_types'
import * as constants from '../../constants'
import axios from 'axios'
// import moment from 'moment'

const state = {
  currentFolder: null
}

const mutations = {
  setCurrentFolder: (state, payload) => {
    state.currentFolder = payload
  }
}

const actions = {
  async [types.SET_CURRENT_FOLDER] ({state, commit, dispatch}, payload) {
    console.log('SET_CURRENT_FOLDER :: payload:', payload)
    let folderId = payload
    if (typeof folderId === 'undefined') {
      folderId = 0
    }
    let apiUrl = constants.apiUrl + '/folders/' + folderId
    await axios.get(apiUrl).then(function (response) {
      commit('setCurrentFolder', response.data)
    })
  }
}

export default {
  state,
  mutations,
  actions
}
