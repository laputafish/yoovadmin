import * as types from './dragging_types'
import * as constants from '../../constants'
import axios from 'axios'

const state = {
  draggingItem: null
  // draggingItem = {
  //  vm: vm,
  //  name: vm.fileItem.name,
  //  fileType: vm.fileType,
  //  fileItem: vm.fileItem
}

const getters = {
  draggingVm: (state) => {
    return state.draggingItem.vm
  }
}
const mutations = {
  setDraggableItem: (state, payload) => {
    state.draggingItem = payload
  }
}

const actions = {
  async [types.SET_DRAGGABLE_ITEM] ({commit}, payload) {
    console.log('SET_DRAGGABLE_ITEM :: payload: ', payload)
    commit('setDraggableItem', payload)
  },

  async [types.DROP_FILEITEM] ({commit, state}, payload) {
    let target = payload.target
    let apiUrl = constants.apiUrl + '/folders'
    console.log('DROP_FILEITEM :: draggableItem: ', state.draggableItem)
    let data = {
      targetFolderId: target.id,
      fileType: state.draggableItem.fileType,
      fileItemId: state.draggableItem.fileItem.id,
      command: 'move'
    }
    await axios.post(apiUrl, data)
  }
}

export default {
  state,
  getters,
  mutations,
  actions
}
