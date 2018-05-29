import * as types from './fileManager_types'
import * as constants from '../../constants'
import axios from 'axios'
// import moment from 'moment'

const state = {
  currentFolder: null,
  selectedDocumentIds: []
}

const getters = {
  currentFolder: (state) => {
    return state.currentFolder
  },
  selectedDocumentIds: (state) => {
    return state.selectedDocumentIds
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
    let document = payload
    let index = state.selectedDocumentIds.indexOf(document.id)

    if (index >= 0) {
      state.selectedDocumentIds.splice(index, 1)
    } else {
      state.selectedDocumentIds.push(document.id)
    }
    // console.log('mutations: toggleDocumentSelection :; payload: ', payload)
    // for (var i = 0; i < state.currentFolder.documents.length; i++) {
    //   if (state.currentFolder.documents[i] === payload) {
    //     state.currentFolder.documents[i].selected = !state.currentFolder.documents[i].selected
    //     console.log('toggleDocumentSelection : document: ', state.currentFolder.documents[i])
    //     break
    //   }
    // }
  },
  selectAllDocuments: (state, payload) => {
    state.selectedDocumentIds = state.currentFolder.documents.map(function (document) {
      return document.id
    })
  },
  clearDocumentSelection: (state, payload) => {
    state.selectedDocumentIds = []
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
    console.log('toggle: async :: before commit')
    await commit('toggleDocumentSelection', payload)
    console.log('toggle: async :: after commit')
  },
  async [types.SELECT_ALL_DOCUMENTS] ({state, commit, dispatch}, payload) {
    await commit('selectAllDocuments')
  },
  async [types.CLEAR_DOCUMENT_SELECTION] ({state, commit, dispatch}, payload) {
    await commit('clearDocumentSelection')
  },
  async [types.DELETE_DOCUMENT] ({state, commit, dispatch}, payload) {
    let documentId = payload
    let apiUrl = constants.apiUrl + '/documents/' + documentId
    await axios.delete(apiUrl).then(function (response) {
    })
  },
  async [types.DELETE_SELECTED] ({state, commit, dispatch}, payload) {
    let apiUrl = constants.apiUrl + '/documents'
    let data = {
      command: 'DELETE',
      ids: state.selectedDocumentIds
    }
    await axios.post(apiUrl, data).then(function (response) {})
  }
}

export default {
  state,
  getters,
  mutations,
  actions
}
