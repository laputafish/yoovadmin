import * as types from './fileManager_types'
import * as constants from '../../constants'
import axios from 'axios'
// import moment from 'moment'

const state = {
  currentFolder: null
}

const getters = {
  currentFolder: (state) => {
    return state.currentFolder
  }
}
const mutations = {
  setCurrentFolder: (state, payload) => {
    state.currentFolder = payload
    for (var i = 0; i < state.currentFolder.documents.length; i++) {
      state.currentFolder.documents[i].selected = false
    }
    console.log('currentFolder:', state.currentFolder)
  },
  toggleDocumentSelection: (state, payload) => {
    for (var i = 0; i < state.currentFolder.documents.length; i++) {
      if (state.currentFolder.documents[i] === payload) {
        state.currentFolder.documents[i].selected = !state.currentFolder.documents[i].selected
        break
      }
    }
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
  },
  async [types.TOGGLE_DOCUMENT_SELECTION] ({state, commit, dispatch}, payload) {
    commit('toggleDocumentSelection', payload)
  }
}

export default {
  state,
  getters,
  mutations,
  actions
}
