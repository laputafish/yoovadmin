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
  },

  fileItemList: [],
  lastSelectedIndex: -1
}

function getFileItemIndex (fileItem) {
  let result = -1
  for (var i = 0; i < state.fileItemList.length; i++) {
    let item = state.fileItemList[i]
    if (item.data.id === fileItem.data.id && item.type === fileItem.type) {
      result = i
      break
    }
  }
  return result
}

// function getFileIndex (itemList, type, id) {
//   console.log('getFileIndex: itemList: ', itemList)
//   console.log('getFileIndex: type = ' + type)
//   console.log('getFileIndex: id = ' + id)
//   let result = -1
//   for (var i = 0; i < itemList.length; i++) {
//     let item = itemList[i]
//     if (item.data.id === id && item.type === type) {
//       result = i
//       break
//     }
//   }
//   return result
// }
//
function fileItemSelected (index) {
  let fileItem = state.fileItemList[index]
  console.log('fileItemSelected(' + index + ') :; fileItem.data.id = ' + fileItem.data.id)
  let result = false
  let i
  if (fileItem.type === 'folder') {
    i = state.selectedFolderIds.indexOf(fileItem.data.id)
    console.log('fileItemSelected :: folder  index=' + i)
    result = i >= 0
  } else {
    i = state.selectedDocumentIds.indexOf(fileItem.data.id)
    console.log('fileItemSelected :: document  index=' + i)
    result = i >= 0
  }
  return result
}

function allSelected (startIndex, endIndex) {
  let result = true
  for (var i = startIndex; i <= endIndex; i++) {
    if (!fileItemSelected(i)) {
      result = false
      break
    }
  }
  return result
}

function isSelected (fileItem) {
  let result = false
  if (fileItem.type === 'folder') {
    for (var i = 0; i < state.selectedFolderIds.length; i++) {
      if (state.selectedFolderIds[i] === fileItem.data.id) {
        result = true
        break
      }
    }
  } else {
    for (var i = 0; i < state.selectedDocumentIds.length; i++) {
      if (state.selectedDocumentIds[i] === fileItem.data.id) {
        result = true
        break
      }
    }
  }
  return result
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
  },
  fileItemList: (state) => {
    return state.fileItemList
  },
  lastSelectedFileItem: (state) => {
    return state.lastSelectedIndex >= 0 ? state.fileItemList[state.lastSelectedIndex] : null
  },
  lastSelectedIndex: (state) => {
    return state.lastSelectedIndex
  },
  allSelected: (state) => {
    return state.fileItemList.length === (state.selectedDocumentIds.length + state.selectedFolderIds.length)
  }
}
const mutations = {
  setCurrentFolder: (state, payload) => {
    console.log('mutations :: setCurrentFolder :: payload: ', payload)
    state.currentFolder = payload
    // for (var i = 0; i < state.currentFolder.documents.length; i++) {
    //   state.currentFolder.documents[i].selected = false
    // }
    state.selectedDocumentIds = []
    state.selectedFolderIds = []

    state.fileItemList = []
    let i
    for (i = 0; i < payload.children.length; i++) {
      state.fileItemList.push({
        type: 'folder',
        data: payload.children[i]
      })
    }
    for (i = 0; i < payload.documents.length; i++) {
      state.fileItemList.push({
        type: 'document',
        data: payload.documents[i]
      })
    }

    console.log('currentFolder:', state.currentFolder)
    console.log('fileItemList: ', state.fileItemList)
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
  toggleFileItemSelection: (state, payload) => {
    let fileItem = payload.fileItem
    let i
    if (fileItem.type === 'folder') {
      // if not selected, set lastSelected
      i = state.selectedFolderIds.indexOf(fileItem.data.id)
      if (i === -1) {
        state.selectedFolderIds.push(fileItem.data.id)
        state.lastSelectedIndex = getFileItemIndex(fileItem)
      } else {
        state.selectedFolderIds.splice(i, 1)
      }
    } else {
      i = state.selectedDocumentIds.indexOf(fileItem.data.id)
      if (i === -1) {
        state.selectedDocumentIds.push(fileItem.data.id)
        state.lastSelectedIndex = getFileItemIndex(fileItem)
      } else {
        state.selectedDocumentIds.splice(i, 1)
      }
    }

    // let fileItem = payload.fileItem
    // let data = fileItem.data
    // if (fileItem.type === 'folder') {
    //   dispatch(types.TOGGLE_FOLDER_SELECTION, data).then(function () {
    //     commit('setLastSelectedFileItem', {fileType: 'folder', id: data.id})
    //   })
    // } else {
    //   dispatch(types.TOGGLE_DOCUMENT_SELECTION, data).then(function () {
    //     commit('setLastSelectedFileItem', {fileType: 'document', id: data.id})
    //   })
    // }
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
  },
  setLastSelectedFileItem: (state, payload) => {
    let fileItem = payload.fileItem
    for (var i = 0; i < state.fileItemList.length; i++) {
      let loopFileItem = state.fileItemList[i]
      if (loopFileItem.type === fileItem.type && loopFileItem.data.id === fileItem.data.id) {
        state.lastSelectedIndex = i
        break
      }
    }
  },
  setSelection: (state, payload) => {
    console.log('setSelection startIndex=' + payload.startIndex)
    console.log('setSelection endIndex=' + payload.endIndex)
    for (var i = payload.startIndex; i <= payload.endIndex; i++) {
      let fileItem = state.fileItemList[i]
      let index
      if (fileItem.type === 'folder') {
        index = state.selectedFolderIds.indexOf(fileItem.data.id)
        if (index === -1) {
          state.selectedFolderIds.push(fileItem.data.id)
        }
      } else {
        index = state.selectedDocumentIds.indexOf(fileItem.data.id)
        if (index === -1) {
          state.selectedDocumentIds.push(fileItem.data.id)
        }
      }
    }
  },

  clearSelection: (state, payload) => {
    console.log('clearSelection startIndex=' + payload.startIndex)
    console.log('clearSelection endIndex=' + payload.endIndex)
    for (var i = payload.startIndex; i <= payload.endIndex; i++) {
      let fileItem = state.fileItemList[i]
      let index
      if (fileItem.type === 'folder') {
        index = state.selectedFolderIds.indexOf(fileItem.data.id)
        console.log('clearSelection :: folder #' + fileItem.data.id + ', index = ' + index)
        if (index >= 0) {
          state.selectedFolderIds.splice(index, 1)
          console.log('clearSelection :: after removal: ' + state.selectedFolderIds)
        }
      } else {
        index = state.selectedDocumentIds.indexOf(fileItem.data.id)
        console.log('clearSelection :: document #' + fileItem.data.id + ', index = ' + index)
        if (index >= 0) {
          state.selectedDocumentIds.splice(index, 1)
        }
      }
    }
  },

  clearLastSelection: (state) => {
    state.lastSelectedIndex = -1
  }
}

const actions = {
  async [types.REFRESH_FOLDER] ({state, commit, dispatch}) {
    let apiUrl = constants.apiUrl + '/folders/' + state.currentFolder.id
    console.log('REFRESH_FOLDER :: apiUrl = ' + apiUrl)
    await axios.get(apiUrl).then(function (response) {
      console.log('actions :: REFRESH_FOLDER => call mutations :: setCurrentFolder')
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
  async [types.TOGGLE_FILE_ITEM_SELECTION] ({commit, dispatch}, payload) {
    await commit('toggleFileItemSelection', payload)
  },
  async [types.CLEAR_LAST_SELECTION] ({commit}, payload) {
    commit('clearLastSelection')
  },
  async [types.EXTEND_FILE_ITEM_SELECTION] ({state, dispatch, commit}, payload) {
    console.log('EXTEND_FILE_ITEM_SELECTION :: lastSelectedIndex = ' + state.lastSelectedIndex)
    let fileItem = payload.fileItem
    let type = fileItem.type
    let id = fileItem.data.id

    // valid only lastSelected point exists.
    // if no last selected point
    if (state.lastSelectedIndex === -1) {
      if (isSelected(fileItem)) {
        await commit('setLastSelectedFileItem', {fileItem: fileItem})
      } else {
        await commit('toggleFileItemSelection', payload)
      }
      return
    }

    console.log('EXTEND_FILE_ITEM_SELECTION :: type = ' + type)
    console.log('EXTEND_FILE_ITEM_SELECTION :: fileId = ' + id)
    console.log('EXTEND_FILE_ITEM_SELECTION :: fileItemlist: ', state.fileItemList)

    let fileIndex = getFileItemIndex(fileItem)
// getFileIndex(state.fileItemList, type, id)
    console.log('EXTEND_FILE_ITEM_SELECTION :: lastSelectedIndex = ' + state.lastSelectedIndex)

    let startIndex
    let endIndex

    if (fileIndex < state.lastSelectedIndex) {
      startIndex = fileIndex
      endIndex = state.lastSelectedIndex - 1
    } else if (fileIndex > state.lastSelectedIndex) {
      startIndex = state.lastSelectedIndex + 1
      endIndex = fileIndex
    } else {
      dispatch(types.TOGGLE_FILE_ITEM_SELECTION, {fileIndex: fileIndex})
      return
    }

    if (allSelected(startIndex, endIndex)) {
      console.log('allSelected : true (startIndex=' + startIndex + ', endIndex=' + endIndex + ')')
      commit('clearSelection', {startIndex: startIndex, endIndex: endIndex})
    } else {
      console.log('allSelected : false (startIndex=' + startIndex + ', endIndex=' + endIndex + ')')
      commit('setSelection', {startIndex: startIndex, endIndex: endIndex})
    }

    // if (fileType === 'folder') {
    //   if (state.lastSelectedFileItem.fileType === 'folder') {
    //     let lastFolderIndex = folderIndex(state.currentFolder.children, state.lastSelectedFileItem.id)
    //     let currFolderIndex = folderIndex(state.currentFolder.children, fileItem.id)
    //     if (currFolderIndex < lastFolderIndex) {
    //       startIndex = currFolderIndex
    //       endIndex = lastFolderIndex - 1
    //       for (var i = startIndex; i <= endIndex; i++) {
    //         commit('setToggleFolderSelection', state.currentFolder.children[i])
    //       }
    //     } else if (lastFolderIndex < currFolderIndex) {
    //       startIndex = lastFolderIndex + 1
    //       endIndex = currFolderIndex
    //       for (var i = startIndex; i <= endIndex; i++) {
    //         commit('setToggleFolderSelection', state.currentFolder.children[i])
    //       }
    //     }
    //   } else {
    //     for (var i = 0; i < state.currentFolder.documents.length; i++) {
    //       if (state.selectedDocumentIds.indexOf(state.currentFolder.documents[i].id) >= 0) {
    //
    //       }
    //     }
    //   }
    //   dispatch(types.TOGGLE_FOLDER_SELECTION, fileItem)
    // } else {
    //   dispatch(types.TOGGLE_DOCUMENT_SELECTION, fileItem)
    // }
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
    console.log('actions :: DELETE_FOLDER :: payload: ', payload)
    let folderId = payload
    let apiUrl = constants.apiUrl + '/folders/' + folderId
    await axios.delete(apiUrl).then(function (response) {
      console.log('actions :: DELETE_FOLDER => actions :: REFRESH_FOLDER')
      dispatch(types.REFRESH_FOLDER)
      // dispatch('SET_CURRENT_FOLDER', state.currentFolder.id)
    })
  },
  async [types.DELETE_DOCUMENT] ({state, commit, dispatch}, payload) {
    console.log('actions :: DELETE_DOCUMENT :: payload: ', payload)
    let documentId = payload
    let apiUrl = constants.apiUrl + '/documents/' + documentId
    await axios.delete(apiUrl).then(function (response) {
      dispatch(types.REFRESH_FOLDER)
      // dispatch('SET_CURRENT_FOLDER', state.currentFolder.id)
    })
  },
  async [types.DELETE_SELECTED] ({state, commit, dispatch}, payload) {
    console.log('actions :: DELETE_SELECTED :: payload: ', payload)
    let promises = []
    promises.push(
      axios.post(
        constants.apiUrl + '/documents',
        {
          command: 'DELETE',
          ids: state.selectedDocumentIds
        }
      )
    )
    promises.push(
      axios.post(
        constants.apiUrl + '/folders',
        {
          command: 'DELETE',
          ids: state.selectedFolderIds
        }
      )
    )
    await Promise.all(promises).then(function () {
      dispatch(types.REFRESH_FOLDER)
    })
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
