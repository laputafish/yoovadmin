import * as types from './dragging_types'
// import * as constants from '../../constants'
// import axios from 'axios'

const state = {
  draggingItem: null
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
    commit('setDraggableItem', payload)
  }
}

export default {
  state,
  getters,
  mutations,
  actions
}
