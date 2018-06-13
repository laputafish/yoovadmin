import * as types from './fileManager_types'
import * as constants from '../../constants'
import axios from 'axios'
// import moment from 'moment'

const state = {
  currentFolder: null,
  selectedDocumentIds: [],
  selectedFolderIds: [],
  userAllFolders: {
    personalFolders: [],
    publicFolders: [],
    sharedFolders: []
  }
}

const getters = {
  currentFolder: (state) => {
    return state.currentFolder
  },
  selectedDocumentIds: (state) => {
    return state.selectedDocumentIds
  },
  personalFolders: (state) => {
    return state.userAllFolders.personalFolders
  },
  selectedFolderIds: (state) => {
    return state.selectedFolderIds
  },
  haveFileSelected: (state) => {
    return state.selectedDocumentIds.length + state.selectedFolderIds.length > 0
  },
  selectionCount: (state) => {
    return state.selectedDocumentIds.length + state.selectedFolderIds.length
  },
  userAllFolders: (state) => {
    return state.userAllFolders
  }

}
const mutations = {
  setCurrentFolder: (state, payload) => {
    state.currentFolder = payload
    for (var i = 0; i < state.currentFolder.documents.length; i++) {
      state.currentFolder.documents[i].selected = false
    }
    state.selectedDocumentIds = []
    state.selectedFolderIds = []

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
  },
  toggleFolderSelection: (state, payload) => {
    let folder = payload
    let index = state.selectedFolderIds.indexOf(folder.id)

    if (index >= 0) {
      state.selectedFolderIds.splice(index, 1)
    } else {
      state.selectedFolderIds.push(folder.id)
    }
  },
  selectAllDocuments: (state, payload) => {
    console.log('selectAllDocuments')
    state.selectedDocumentIds = state.currentFolder.documents.map(function (document) {
      return document.id
    })
    console.log('state.selectedDocumentIds: ', state.selectedDocumentIds)
  },
  selectAllFolders: (state, payload) => {
    console.log('selectAllFolders')
    state.selectedFolderIds = state.currentFolder.children.map(function (folder) {
      return folder.id
    })
    console.log('state.selectedFolderIds: ', state.selectedFolderIds)
  },
  clearDocumentSelection: (state) => {
    state.selectedDocumentIds = []
  },
  clearFolderSelection: (state) => {
    state.selectedFolderIds = []
  },
  updateFolderName: (state, payload) => {
    payload.folder.name = payload.name
  },
  updateDocumentName: (state, payload) => {
    payload.document.filename = payload.name
  },
  setUserAllFolders: (state, payload) => {
    state.userAllFolders = payload
  }
}

const actions = {
  async [types.REFRESH_FOLDER] ({state, commit, dispatch}) {
    let apiUrl = constants.apiUrl + '/folders/' + state.currentFolder.id
    console.log('REFRESH_FOLDER :: apiUrl = ' + apiUrl)
    await axios.get(apiUrl).then(function (response) {
      commit('setCurrentFolder', response.data)
    })
  },

  async [types.SET_CURRENT_FOLDER_BY_TYPE] ({commit}, payload) {
    let folderType = payload.folderName
    let folderName = payload.subFolderName
    let apiUrl = constants.apiUrl + '/folders'
    let data = {
      type: folderType
    }
    if (folderName) {
      data.folderName = folderName
    }
    await axios.get(apiUrl, {params: data}).then(function (response) {
      commit('setCurrentFolder', response.data)
    })
  },

  async [types.SET_CURRENT_FOLDER] ({commit}, payload) {
    let folderId = payload
    if (typeof folderId === 'undefined') {
      folderId = 0
    }
    let apiUrl = constants.apiUrl + '/folders/' + folderId
    await axios.get(apiUrl).then(function (response) {
      commit('setCurrentFolder', response.data)
    })
  },
  async [types.TOGGLE_DOCUMENT_SELECTION] ({commit}, payload) {
    await commit('toggleDocumentSelection', payload)
  },
  async [types.TOGGLE_FOLDER_SELECTION] ({commit}, payload) {
    await commit('toggleFolderSelection', payload)
  },
  async [types.TOGGLE_FILE_ITEM_SELECTION] ({dispatch}, payload) {
    let fileItem = payload.fileItem
    let fileType = payload.fileType
    if (fileType === 'folder') {
      dispatch(types.TOGGLE_FOLDER_SELECTION, fileItem)
    } else {
      dispatch(types.TOGGLE_DOCUMENT_SELECTION, fileItem)
    }
  },
  async [types.SELECT_ALL_FILES] ({state, commit, dispatch}, payload) {
    console.log('fileManager.js :: SELECT_ALL_FILES')
    await commit('selectAllDocuments')
    await commit('selectAllFolders')
  },
  async [types.CLEAR_ALL_FILES] ({state, commit, dispatch}, payload) {
    await commit('clearDocumentSelection')
    await commit('clearFolderSelection')
  },
  async [types.DELETE_FOLDER] ({state, commit, dispatch}, payload) {
    let folderId = payload
    let apiUrl = constants.apiUrl + '/folders/' + folderId
    await axios.delete(apiUrl).then(function (response) {
      dispatch('SET_CURRENT_FOLDER', state.currentFolder.id)
    })
  },
  async [types.DELETE_DOCUMENT] ({state, commit, dispatch}, payload) {
    let documentId = payload
    let apiUrl = constants.apiUrl + '/documents/' + documentId
    await axios.delete(apiUrl).then(function (response) {
      dispatch('SET_CURRENT_FOLDER', state.currentFolder.id)
    })
  },
  async [types.DELETE_SELECTED] ({state, commit, dispatch}, payload) {
    let apiUrl = constants.apiUrl + '/documents'
    let data = {
      command: 'DELETE',
      ids: state.selectedDocumentIds
    }
    await axios.post(apiUrl, data).then(function (response) {})
  },
  async [types.NEW_FOLDER] ({state, commit, dispatch}, payload) {
    let apiUrl = constants.apiUrl + '/folders'
    let data = {
      command: 'NEW',
      parent_folder_id: state.currentFolder.id
    }
    await axios.post(apiUrl, data).then(function (response) {}).then(function () {
      dispatch(types.REFRESH_FOLDER)
    })
  },
  async [types.UPDATE_DOCUMENT_NAME] ({state, commit, dispatch}, payload) {
    let document = payload.document
    let apiUrl = constants.apiUrl + '/documents/' + document.id
    let data = {
      command: 'UPDATE_DOCUMENT_NAME',
      name: payload.name
    }
    await axios.post(apiUrl, data).then(function (response) {}).then(function () {
      dispatch(types.REFRESH_FOLDER)
    })
  },
  async [types.UPDATE_FOLDER_NAME] ({state, commit, dispatch}, payload) {
    commit('updateFolderName', payload)
    let folder = payload.folder
    let apiUrl = constants.apiUrl + '/folders/' + folder.id
    let data = {
      command: 'UPDATE_FOLDER_NAME',
      name: payload.name
    }
    await axios.put(apiUrl, data).then(function (response) {}).then(function () {
      dispatch(types.REFRESH_FOLDER)
    })
  },

  async [types.GET_USER_ALL_FOLDERS] ({commit}, payload) {
    let userId = payload
    let apiUrl = constants.apiUrl + '/folders'
    let data = {
      user_id: userId,
      type: 'all'
    }
    await axios.get(apiUrl, {params: data}).then(function (response) {
      commit('setUserAllFolders', response.data)
    })
  },

  async [types.PROCESS_SELECTION] ({dispatch, state}, payload) {
    let command = payload.command
    let targetFolderId = payload.targetFolderId
    let apiUrl = constants.apiUrl + '/folders'
    let data = {
      command: command,
      targetFolderId: targetFolderId,
      documentIds: state.selectedDocumentIds.join(','),
      folderIds: state.selectedFolderIds.join(',')
    }
    await axios.post(apiUrl, data).then(function (response) {
      dispatch(types.REFRESH_FOLDER)
    })
  },

  async [types.PROCESS_FILE_ITEM] ({dispatch}, payload) {
    let command = payload.command

    let apiUrl = constants.apiUrl + '/folders'

    let data = {}
    switch (command) {
      case 'RENAME':
        data = {
          command: command,
          fileType: payload.fileType,
          fileItemId: payload.fileItem.id,
          newName: payload.newName
        }
        break
      default:
        let targetFolderId = payload.targetFolderId
        let documentIds = []
        let folderIds = []
        if (payload.fileType === 'folder') {
          folderIds = [payload.fileItem.id]
        } else {
          documentIds = [payload.fileItem.id]
        }
        data = {
          command: command,
          targetFolderId: targetFolderId,
          documentIds: documentIds.join(','),
          folderIds: folderIds.join(',')
        }
    }
    await axios.post(apiUrl, data).then(function (response) {
      dispatch(types.REFRESH_FOLDER)
    })
  },

  async [types.FETCH_FOLDER] ({dispatch}, payload) {
    if (payload.folderId) {
      await dispatch('SET_CURRENT_FOLDER', payload.folderId)
    } else {
      let folderName = payload.folderName
      if (isNaN(folderName)) {
        // if not number, i.e. folderName
        dispatch('SET_CURRENT_FOLDER_BY_TYPE', payload)
      } else {
        let folderId = folderName
        await dispatch('SET_CURRENT_FOLDER', folderId)
      }
    }
  }

}

export default {
  state,
  getters,
  mutations,
  actions
}
